/// أداة لتسوية وتوحيد النصوص العربية للبحث الذكي
class ArabicNormalizer {
  static final RegExp _diacriticsRegex = RegExp(
    r'[\u064B-\u0652\u0670\u0640]', // التنوين، الحركات، الشدة، الكشيدة
  );

  /// تطبيع النص العربي للبحث:
  /// - إزالة التشكيل والتطويل
  /// - توحيد أشكال الألف (أ، إ، آ -> ا)
  /// - توحيد الياء والتاء المربوطة (ى -> ي، ة -> ه)
  static String normalize(String text) {
    if (text.isEmpty) return '';

    var result = text.replaceAll(_diacriticsRegex, '');

    // توحيد الألف
    result = result.replaceAll(RegExp(r'[أإآٱ]'), 'ا');

    // توحيد الياء والتاء المربوطة
    result = result.replaceAll('ى', 'ي');
    result = result.replaceAll('ة', 'ه');

    // إزالة الفراغات المكررة وتحويل للحروف الصغيرة إن وجدت نصوص لاتينية
    return result.trim().toLowerCase();
  }

  /// التحقق مما إذا كان النص الأول يحتوي على النص الثاني بعد التطبيع
  static bool contains(String source, String query) {
    return normalize(source).contains(normalize(query));
  }
}
