import 'dart:convert';
import 'package:http/http.dart' as http;
import '../security/security_service.dart';

class GeminiLegalAnalysisResult {
  final String content;
  final List<String> sourceDocuments;
  final String modelUsed;
  final int timestamp;

  GeminiLegalAnalysisResult({
    required this.content,
    required this.sourceDocuments,
    required this.modelUsed,
    required this.timestamp,
  });
}

class GeminiService {
  final SecurityService _securityService;
  final http.Client _client;

  GeminiService(this._securityService, [http.Client? client])
      : _client = client ?? http.Client();

  static const String defaultModel = 'gemini-1.5-flash';
  static const List<String> availableModels = [
    'gemini-1.5-flash',
    'gemini-1.5-pro',
    'gemini-2.0-flash',
  ];

  /// اختبار الاتصال بمفتاح API
  Future<bool> testConnection(String apiKey, {String model = defaultModel}) async {
    try {
      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
      );

      final response = await _client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': 'مرحباً، أجب بكلمة واحدة: متصل'}
              ]
            }
          ]
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// إرسال استفسار قانوني استرشادي للمساعد الذكي مع مستندات محددة يدوياً
  Future<GeminiLegalAnalysisResult> analyzeLegalPrompt({
    required String prompt,
    required String legalTask, // 'SUMMARIZE', 'EXTRACT_DATES', 'ANALYZE_CONTRACT', 'DRAFT_MEMO', 'GENERAL_QA'
    List<({String name, String content})> documents = const [],
    String model = defaultModel,
  }) async {
    final apiKey = await _securityService.getGeminiApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('لم يتم ضبط مفتاح Google Gemini API في الإعدادات بعد');
    }

    final systemInstruction = _getSystemPromptForTask(legalTask);

    final parts = <Map<String, dynamic>>[];

    // إضافة المستندات المحددة صراحة من قبل المحامي
    final sourceNames = <String>[];
    if (documents.isNotEmpty) {
      parts.add({
        'text': '=== المستندات المرفقة للمراجعة والتحليل (بإذن المحامي) ===\n'
      });
      for (final doc in documents) {
        sourceNames.add(doc.name);
        parts.add({
          'text': '\n--- بداية مستند: [${doc.name}] ---\n${doc.content}\n--- نهاية مستند: [${doc.name}] ---\n'
        });
      }
    }

    // إضافة طلب المحامي
    parts.add({
      'text': '\n=== طلب المحامي ===\n$prompt\n'
    });

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
    );

    final requestBody = {
      'system_instruction': {
        'parts': [
          {'text': systemInstruction}
        ]
      },
      'contents': [
        {'parts': parts}
      ],
      'generationConfig': {
        'temperature': 0.2, // دقة قانونية عالية وتجنب الهلوسة
        'maxOutputTokens': 4096,
      }
    };

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      final errorMsg = errorJson['error']?['message'] ?? 'فشل الاتصال بـ Gemini';
      throw Exception('خطأ Gemini ($response.statusCode): $errorMsg');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = json['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('لم يقدم النموذج أي إجابة');
    }

    final first = candidates.first as Map<String, dynamic>;
    final content = first['content']?['parts']?[0]?['text'] as String? ?? '';

    return GeminiLegalAnalysisResult(
      content: content,
      sourceDocuments: sourceNames,
      modelUsed: model,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  String _getSystemPromptForTask(String task) {
    const base = '''أنت المساعد القانوني الذكي التابع لنظام إدارة مكتب المحاماة في الجمهورية العربية السورية (محاكم دمشق).
مهمتك: مساعدة المحامي في التدقيق والتلخيص والصياغة الرصينة باللغة العربية الفصحى القانونية.
القواعد الصارمة:
1. لا تختلق مواد قانونية أو اجتهادات قضائية لا وجود لها.
2. ميز بوضوح تام بين الوقائع المستخرجة نصاً من المستند وبين التحليل والاستنتاج التوليدي.
3. اكتب بلغة قانونية سورية رصينة ومحترفة.
4. أرفق دائماً تنبيهاً ختامياً بأن الرأي استرشادي فقط ويخضع لتقدير ومسؤولية المحامي الممارس.''';

    switch (task) {
      case 'SUMMARIZE':
        return '$base\nالتركيز: تلخيص موضوع الدعوى، أطراف النزاع، الأسباب والوقائع، والطلبات الختامية بنقاط محددة.';
      case 'EXTRACT_DATES':
        return '$base\nالتركيز: استخراج كافة التواريخ المهمة (تواريخ العقود، التبليغات، مهل الطعن، مواعيد الاستحقاق) مع دلالة كل تاريخ.';
      case 'ANALYZE_CONTRACT':
        return '$base\nالتركيز: مراجعة العقد وبيان التزامات الأطراف، الشروط الجزائية، بنود حل النزاع والتحكيم، وأي ثغرات أو مخاطر قانونية محتملة.';
      case 'DRAFT_MEMO':
        return '$base\nالتركيز: صياغة مسودة مذكرة دفاع أو لائحة ادعاء رصينة مقسمة إلى: الشكل، الوقائع، الأسانيد القانونية، والطلبات.';
      default:
        return base;
    }
  }
}

