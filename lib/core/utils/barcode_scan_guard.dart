class BarcodeScanGuard {
  BarcodeScanGuard({this.cooldown = const Duration(seconds: 2)});

  final Duration cooldown;
  final Map<String, DateTime> _lastDetectionTimes = {};

  bool shouldProcess(String barcode, {DateTime? now}) {
    final detectedAt = now ?? DateTime.now();
    final previousDetection = _lastDetectionTimes[barcode];
    _lastDetectionTimes[barcode] = detectedAt;

    return previousDetection == null ||
        detectedAt.difference(previousDetection) >= cooldown;
  }
}
