import 'package:intl/intl.dart';

/// تنسيق المبالغ المالية بدقة متناهية بناءً على وحدات العد الصغرى (Minor Units)
class CurrencyFormatter {
  /// تحويل القيمة المخزنة بالوحدات الصغرى (Minor Units) إلى نص منسق
  /// بالنسبة لليرة السورية (SYP) عادة لا توجد كسور (1 ليرة = 1 وحدة صغرى)
  /// بالنسبة للدولار (USD) واليورو (EUR): 100 وحدة صغرى = 1.00 دولار/يورو
  static String format(int minorUnits, {String currency = 'SYP'}) {
    final cur = currency.toUpperCase();
    if (cur == 'SYP') {
      final formatter = NumberFormat('#,###', 'ar_SY');
      return '${formatter.format(minorUnits)} ل.س';
    } else if (cur == 'USD') {
      final double major = minorUnits / 100.0;
      final formatter = NumberFormat('#,##0.00', 'en_US');
      return '\$${formatter.format(major)}';
    } else if (cur == 'EUR') {
      final double major = minorUnits / 100.0;
      final formatter = NumberFormat('#,##0.00', 'en_US');
      return '€${formatter.format(major)}';
    } else {
      final formatter = NumberFormat('#,###', 'ar');
      return '${formatter.format(minorUnits)} $currency';
    }
  }

  /// تحويل المدخل النصي من المستخدم إلى وحدات صغرى صحيحة (Integer Minor Units)
  static int parseToMinorUnits(String text, {String currency = 'SYP'}) {
    final cleaned = text.replaceAll(',', '').replaceAll(' ', '').trim();
    if (cleaned.isEmpty) return 0;

    final cur = currency.toUpperCase();
    final value = double.tryParse(cleaned) ?? 0.0;

    if (cur == 'SYP') {
      return value.round();
    } else {
      return (value * 100).round();
    }
  }

  /// الحصول على القيمة العشرية الكبرى للعرض أثناء التعديل
  static double toMajor(int minorUnits, {String currency = 'SYP'}) {
    final cur = currency.toUpperCase();
    if (cur == 'SYP') {
      return minorUnits.toDouble();
    } else {
      return minorUnits / 100.0;
    }
  }
}
