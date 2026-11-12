import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechState {
  final bool isAvailable;
  final bool isListening;
  final String recognizedText;
  final String? lastError;
  final String currentLocaleId;
  final List<LocaleName> availableArabicLocales;

  const SpeechState({
    this.isAvailable = false,
    this.isListening = false,
    this.recognizedText = '',
    this.lastError,
    this.currentLocaleId = 'ar_SA',
    this.availableArabicLocales = const [],
  });

  SpeechState copyWith({
    bool? isAvailable,
    bool? isListening,
    String? recognizedText,
    String? lastError,
    String? currentLocaleId,
    List<LocaleName>? availableArabicLocales,
  }) {
    return SpeechState(
      isAvailable: isAvailable ?? this.isAvailable,
      isListening: isListening ?? this.isListening,
      recognizedText: recognizedText ?? this.recognizedText,
      lastError: lastError,
      currentLocaleId: currentLocaleId ?? this.currentLocaleId,
      availableArabicLocales:
          availableArabicLocales ?? this.availableArabicLocales,
    );
  }
}

class SpeechNotifier extends StateNotifier<SpeechState> {
  final SpeechToText _speech = SpeechToText();

  SpeechNotifier() : super(const SpeechState()) {
    initSpeech();
  }

  Future<bool> initSpeech() async {
    try {
      final available = await _speech.initialize(
        onError: _onError,
        onStatus: _onStatus,
      );

      String chosenLocale = 'ar_SA';
      final List<LocaleName> arabicList = [];

      if (available) {
        final locales = await _speech.locales();

        // تصفية جميع اللهجات العربية المتاحة في جهاز المستخدم
        for (final loc in locales) {
          final id = loc.localeId.toLowerCase().replaceAll('-', '_');
          final name = loc.name.toLowerCase();
          if (id.startsWith('ar') || name.contains('arabic') || name.contains('عربي')) {
            arabicList.add(loc);
          }
        }

        // اختيار أفضل لهجة عربية مطابقة
        // الأولوية 1: السورية (ar_SY)
        // الأولوية 2: السعودية القياسية المعيارية في أندرويد (ar_SA)
        // الأولوية 3: أي لهجة عربية مدعومة
        // حظر تام: منع استخدام أي لغة غير عربية مهما كانت
        LocaleName? selected;
        for (final loc in arabicList) {
          final id = loc.localeId.toLowerCase().replaceAll('-', '_');
          if (id == 'ar_sy') {
            selected = loc;
            break;
          }
        }

        if (selected == null) {
          for (final loc in arabicList) {
            final id = loc.localeId.toLowerCase().replaceAll('-', '_');
            if (id == 'ar_sa' || id == 'ar_eg' || id == 'ar_jo' || id == 'ar_lb') {
              selected = loc;
              break;
            }
          }
        }

        if (selected == null && arabicList.isNotEmpty) {
          selected = arabicList.first;
        }

        chosenLocale = selected?.localeId ?? 'ar_SA';
      }

      state = state.copyWith(
        isAvailable: available,
        currentLocaleId: chosenLocale,
        availableArabicLocales: arabicList,
      );
      return available;
    } catch (e) {
      state = state.copyWith(
        isAvailable: false,
        lastError: 'تعذر تهيئة التعرف على الصوت: $e',
      );
      return false;
    }
  }

  void _onError(SpeechRecognitionError error) {
    state = state.copyWith(
      isListening: false,
      lastError: error.errorMsg,
    );
  }

  void _onStatus(String status) {
    if (status == 'listening') {
      state = state.copyWith(isListening: true);
    } else if (status == 'notListening' || status == 'done') {
      state = state.copyWith(isListening: false);
    }
  }

  void setLocale(String localeId) {
    final lower = localeId.toLowerCase();
    if (lower.startsWith('ar') || lower.contains('arabic')) {
      state = state.copyWith(currentLocaleId: localeId);
    }
  }

  Future<void> startListening({
    required Function(String text) onResult,
    String? localeId,
  }) async {
    if (!state.isAvailable) {
      final ok = await initSpeech();
      if (!ok) return;
    }

    // التحقق الصارم من أن معرّف اللغة عربي حصراً لمنع التقاط أحرف لغات أخرى
    String targetLocale = (localeId != null && localeId.isNotEmpty)
        ? localeId
        : state.currentLocaleId;

    final lowerTarget = targetLocale.toLowerCase().replaceAll('-', '_');
    if (!lowerTarget.startsWith('ar') && !lowerTarget.contains('arabic')) {
      targetLocale = 'ar_SA';
    }

    state = state.copyWith(isListening: true, recognizedText: '');

    await _speech.listen(
      onResult: (SpeechRecognitionResult result) {
        final text = result.recognizedWords;
        state = state.copyWith(recognizedText: text);
        onResult(text);
      },
      localeId: targetLocale,
      listenFor: const Duration(seconds: 60),
      pauseFor: const Duration(seconds: 4),
      listenOptions: SpeechListenOptions(
        cancelOnError: false,
        partialResults: true,
      ),
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
    state = state.copyWith(isListening: false);
  }

  Future<void> cancelListening() async {
    await _speech.cancel();
    state = state.copyWith(isListening: false);
  }
}

final speechProvider =
    StateNotifierProvider<SpeechNotifier, SpeechState>((ref) {
  return SpeechNotifier();
});
