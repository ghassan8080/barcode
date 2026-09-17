import 'package:billing_app/core/utils/barcode_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validScannedBarcode', () {
    test('rejects missing or blank scan values', () {
      expect(validScannedBarcode(null), isNull);
      expect(validScannedBarcode(''), isNull);
      expect(validScannedBarcode('   '), isNull);
    });

    test('preserves non-blank scan values', () {
      expect(validScannedBarcode('123456789'), '123456789');
      expect(validScannedBarcode(' 123456789 '), ' 123456789 ');
    });
  });
}
