import 'package:flutter_test/flutter_test.dart';
import 'package:law_office/core/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter Tests', () {
    test('formats minor integer units correctly', () {
      final formattedSyp = CurrencyFormatter.format(1500000, currency: 'SYP');
      expect(formattedSyp.contains('1,500,000') || formattedSyp.contains('١٬٥٠٠٬٠٠٠') || formattedSyp.contains('1.500.000'), isTrue);
      expect(formattedSyp.contains('ل.س'), isTrue);

      expect(CurrencyFormatter.format(250000, currency: 'USD'), '\$2,500.00');
      expect(CurrencyFormatter.format(120000, currency: 'EUR'), '€1,200.00');
    });

    test('parses comma-separated string to minor units', () {
      expect(CurrencyFormatter.parseToMinorUnits('1,500,000', currency: 'SYP'), 1500000);
      expect(CurrencyFormatter.parseToMinorUnits('50 000 000', currency: 'SYP'), 50000000);
      expect(CurrencyFormatter.parseToMinorUnits('25.50', currency: 'USD'), 2550);
      expect(CurrencyFormatter.parseToMinorUnits('100.00', currency: 'EUR'), 10000);
    });

    test('converts minor units to major units', () {
      expect(CurrencyFormatter.toMajor(1500000, currency: 'SYP'), 1500000.0);
      expect(CurrencyFormatter.toMajor(2550, currency: 'USD'), 25.5);
      expect(CurrencyFormatter.toMajor(10000, currency: 'EUR'), 100.0);
    });

    test('handles empty or zero inputs gracefully', () {
      expect(CurrencyFormatter.parseToMinorUnits(''), 0);
      expect(CurrencyFormatter.toMajor(0), 0.0);
    });
  });
}
