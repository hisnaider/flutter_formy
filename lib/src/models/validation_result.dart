class ValidationResult {
  ValidationResult({
    required this.key,
    this.isValid = false,
  });
  final String key;
  final bool isValid;
}
