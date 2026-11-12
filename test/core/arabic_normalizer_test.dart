import 'package:flutter_test/flutter_test.dart';
import 'package:law_office/core/utils/arabic_normalizer.dart';

void main() {
  group('ArabicNormalizer Tests', () {
    test('normalizes Alif variations to bare Alif', () {
      expect(ArabicNormalizer.normalize('أحمد'), 'احمد');
      expect(ArabicNormalizer.normalize('إبراهيم'), 'ابراهيم');
      expect(ArabicNormalizer.normalize('آدم'), 'ادم');
      expect(ArabicNormalizer.normalize('ٱستئناف'), 'استئناف');
    });

    test('normalizes Taa Marbuta to Haa', () {
      expect(ArabicNormalizer.normalize('محكمة'), 'محكمه');
      expect(ArabicNormalizer.normalize('قضية'), 'قضيه');
      expect(ArabicNormalizer.normalize('بداية'), 'بدايه');
    });

    test('normalizes Yaa and Alif Maqsura', () {
      expect(ArabicNormalizer.normalize('علي'), 'علي');
      expect(ArabicNormalizer.normalize('دعوى'), 'دعوي');
      expect(ArabicNormalizer.normalize('مستشفى'), 'مستشفي');
    });

    test('strips diacritics (Tashkeel) correctly', () {
      const withTashkeel = 'مَحْكَمَةُ البِدَايَةِ المَدَنِيَّةِ بِدِمَشْقَ';
      final normalized = ArabicNormalizer.normalize(withTashkeel);
      expect(normalized, 'محكمه البدايه المدنيه بدمشق');
    });

    test('fuzzy contains match works across Arabic variants', () {
      expect(ArabicNormalizer.contains('محكمة بداية الجزاء بدمشق', 'بداية'), isTrue);
      expect(ArabicNormalizer.contains('محكمة بداية الجزاء بدمشق', 'بدايه'), isTrue);
      expect(ArabicNormalizer.contains('أحمد بن إبراهيم', 'احمد'), isTrue);
      expect(ArabicNormalizer.contains('أحمد بن إبراهيم', 'ابراهيم'), isTrue);
      expect(ArabicNormalizer.contains('أحمد بن إبراهيم', 'خالد'), isFalse);
    });
  });
}
