class ValidationResult {
  ValidationResult({
    required this.key,
    this.isValid = false,
    this.message,
  });
  final String key;
  final bool isValid;
  final String? message;
}
