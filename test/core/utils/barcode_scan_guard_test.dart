import 'package:billing_app/core/utils/barcode_scan_guard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BarcodeScanGuard', () {
    final start = DateTime(2026, 1, 1);

    test('accepts the first detection', () {
      final guard = BarcodeScanGuard();

      expect(guard.shouldProcess('123', now: start), isTrue);
    });

    test('rejects a rapid repeat detection', () {
      final guard = BarcodeScanGuard();

      expect(guard.shouldProcess('123', now: start), isTrue);
      expect(
        guard.shouldProcess('123', now: start.add(const Duration(seconds: 1))),
        isFalse,
      );
    });

    test('slides the window on every detection, including suppressed ones', () {
      final guard = BarcodeScanGuard();

      expect(guard.shouldProcess('123', now: start), isTrue);
      expect(
        guard.shouldProcess('123', now: start.add(const Duration(seconds: 1))),
        isFalse,
      );
      expect(
        guard.shouldProcess('123', now: start.add(const Duration(seconds: 2))),
        isFalse,
      );
      expect(
        guard.shouldProcess('123', now: start.add(const Duration(seconds: 3))),
        isFalse,
      );
      expect(
        guard.shouldProcess('123', now: start.add(const Duration(seconds: 5))),
        isTrue,
      );
    });

    test('accepts again at the cooldown boundary', () {
      final guard = BarcodeScanGuard();

      expect(guard.shouldProcess('123', now: start), isTrue);
      expect(
        guard.shouldProcess('123', now: start.add(const Duration(seconds: 2))),
        isTrue,
      );
    });

    test('tracks different barcodes independently', () {
      final guard = BarcodeScanGuard();

      expect(guard.shouldProcess('123', now: start), isTrue);
      expect(
        guard.shouldProcess('456',
            now: start.add(const Duration(milliseconds: 100))),
        isTrue,
      );
      expect(
        guard.shouldProcess('123',
            now: start.add(const Duration(milliseconds: 200))),
        isFalse,
      );
    });
  });
}
