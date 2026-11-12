import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ai/gemini_service.dart';
import '../../../../core/security/security_provider.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  final secService = ref.watch(securityServiceProvider);
  return GeminiService(secService);
});

final selectedAiModelProvider =
    StateProvider<String>((ref) => GeminiService.defaultModel);

final aiAnalysisLoadingProvider = StateProvider<bool>((ref) => false);
final lastAiResultProvider =
    StateProvider<GeminiLegalAnalysisResult?>((ref) => null);

