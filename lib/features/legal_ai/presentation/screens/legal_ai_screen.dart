import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/ai/gemini_service.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../file_manager/presentation/providers/file_manager_provider.dart';
import '../providers/legal_ai_provider.dart';

class LegalAiScreen extends ConsumerStatefulWidget {
  const LegalAiScreen({super.key});

  @override
  ConsumerState<LegalAiScreen> createState() => _LegalAiScreenState();
}

class _LegalAiScreenState extends ConsumerState<LegalAiScreen> {
  final _promptCtrl = TextEditingController();
  String _selectedTask = 'SUMMARIZE';
  final List<({String name, String content})> _selectedDocuments = [];

  final _taskOptions = [
    (value: 'SUMMARIZE', label: 'تلخيص مستند / دعوى'),
    (value: 'EXTRACT_DATES', label: 'استخراج التواريخ والأطراف'),
    (value: 'ANALYZE_CONTRACT', label: 'تدقيق وتحليل بنود عقد'),
    (value: 'DRAFT_MEMO', label: 'صياغة مسودة لائحة / مذكرة'),
    (value: 'GENERAL_QA', label: 'استشارة وبحث قانوني عام'),
  ];

  @override
  void dispose() {
    _promptCtrl.dispose();
    super.dispose();
  }

  void _showDocumentSelectionDialog() {
    final docsAsync = ref.read(allDocumentsStreamProvider);

    docsAsync.whenData((docs) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('اختيار مستند لإرفاقه بالمساعد الذكي'),
          content: SizedBox(
            width: double.maxFinite,
            child: docs.isEmpty
                ? const Text('لا توجد مستندات مسجلة في مدير الملفات')
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (cCtx, idx) {
                      final doc = docs[idx];
                      return ListTile(
                        leading: const Icon(Icons.description, color: Colors.blue),
                        title: Text(doc.fileName),
                        subtitle: Text('${(doc.fileSize / 1024).toStringAsFixed(1)} KB • ${doc.category}'),
                        onTap: () {
                          setState(() {
                            _selectedDocuments.add((
                              name: doc.fileName,
                              content: 'مستند: ${doc.fileName} (${doc.category})',
                            ));
                          });
                          Navigator.of(ctx).pop();
                        },
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
          ],
        ),
      );
    });
  }

  Future<void> _executeAiRequest() async {
    if (_promptCtrl.text.trim().isEmpty && _selectedDocuments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى كتابة استفسار أو إرفاق مستند للمراجعة')),
      );
      return;
    }

    ref.read(aiAnalysisLoadingProvider.notifier).state = true;

    try {
      final gemini = ref.read(geminiServiceProvider);
      final model = ref.read(selectedAiModelProvider);

      final result = await gemini.analyzeLegalPrompt(
        prompt: _promptCtrl.text.trim().isEmpty
            ? 'يرجى مراجعة وتلخيص المستندات المرفقة واستخلاص أهم النقاط القانونية.'
            : _promptCtrl.text.trim(),
        legalTask: _selectedTask,
        documents: _selectedDocuments,
        model: model,
      );

      ref.read(lastAiResultProvider.notifier).state = result;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تنبيه: $e'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'ضبط المفتاح',
              textColor: Colors.white,
              onPressed: () => context.push('/settings'),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        ref.read(aiAnalysisLoadingProvider.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoading = ref.watch(aiAnalysisLoadingProvider);
    final lastResult = ref.watch(lastAiResultProvider);
    final currentModel = ref.watch(selectedAiModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعد القانوني الذكي (Gemini)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.vpn_key_outlined),
            tooltip: 'إعدادات مفتاح Gemini',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // بطاقة التنبيه الأمني والخصوصية الصارمة
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withAlpha(60)),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, color: Colors.blue, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'الخصوصية محمية: لن يتم إرسال أي مستند أو ملف إلى Gemini إلا بما تحدده أنت يدوياً في هذه الشاشة.',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // اختيار نوع المهمة القانونية والنموذج
          Row(
            children: [
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: _selectedTask,
                  decoration: const InputDecoration(labelText: 'نوع المهمة القانونية'),
                  items: _taskOptions
                      .map((opt) => DropdownMenuItem(
                            value: opt.value,
                            child: Text(opt.label, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedTask = v!),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: currentModel,
                  decoration: const InputDecoration(labelText: 'النموذج'),
                  items: GeminiService.availableModels
                      .map((m) => DropdownMenuItem(
                            value: m,
                            child: Text(m, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      ref.read(selectedAiModelProvider.notifier).state = v;
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // المستندات المحددة يدوياً
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المستندات المرفقة للمراجعة (${_selectedDocuments.length})',
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: _showDocumentSelectionDialog,
                icon: const Icon(Icons.attach_file, size: 16),
                label: const Text('إرفاق مستند'),
              ),
            ],
          ),
          if (_selectedDocuments.isNotEmpty) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _selectedDocuments
                  .map((d) => Chip(
                        avatar: const Icon(Icons.description, size: 16),
                        label: Text(d.name),
                        onDeleted: () =>
                            setState(() => _selectedDocuments.remove(d)),
                      ))
                  .toList(),
            ),
          ],
          const SizedBox(height: 12),

          // حقل الطلب / السؤال
          TextField(
            controller: _promptCtrl,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'اكتب استفسارك أو طلبك للمساعد القانوني',
              hintText: 'مثال: لخص هذه الدعوى واستخرج الدفوع الشكلية وبنود الخطر...',
            ),
          ),
          const SizedBox(height: 16),

          // زر الإرسال والمعالجة
          ElevatedButton.icon(
            onPressed: isLoading ? null : _executeAiRequest,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.auto_awesome),
            label: Text(
              isLoading ? 'جاري التحليل القانوني عبر Gemini...' : 'بدء التحليل والمعالجة الذكية',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 24),

          // عرض نتيجة التحليل القانوني
          if (lastResult != null) ...[
            Text(
              'نتيجة التحليل القانوني الاسترشادي',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.smart_toy_outlined, color: Colors.purple),
                          const SizedBox(width: 8),
                          Text(
                            'بواسطة ${lastResult.modelUsed}',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        tooltip: 'نسخ الإجابة',
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: lastResult.content));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('تم نسخ التحليل إلى الحافظة')),
                          );
                        },
                      ),
                    ],
                  ),
                  if (lastResult.sourceDocuments.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      'المستندات المعتمدة: ${lastResult.sourceDocuments.join(" • ")}',
                      style: TextStyle(fontSize: 11, color: theme.hintColor),
                    ),
                  ],
                  const Divider(height: 18),
                  SelectableText(
                    lastResult.content,
                    style: const TextStyle(fontSize: 14, height: 1.6),
                  ),
                  const Divider(height: 24),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.amber, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'تنبيه: مخرجات الذكاء الاصطناعي استرشادية فقط وتخضع لمراجعة ومسؤولية المحامي الممارس.',
                            style: TextStyle(fontSize: 11, color: Colors.brown),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ],
      ),
    );
  }
}
