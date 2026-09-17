String? validScannedBarcode(String? rawValue) {
  if (rawValue == null || rawValue.trim().isEmpty) {
    return null;
  }

  return rawValue;
}
