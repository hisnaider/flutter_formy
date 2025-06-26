class ValidationResult {
  const ValidationResult({
    required this.key,
    this.message,
    this.isValid = false,
  });
  final String key;
  final String? message;
  final bool isValid;

  ValidationResult.error({required String key, required String message})
      : this(key: key, message: message, isValid: false);
  ValidationResult.ok({required String key}) : this(key: key, isValid: true);

  @override
  String toString() {
    return 'ValidationResult(key: $key, isValid: $isValid)';
  }

  @override
  bool operator ==(covariant ValidationResult other) {
    if (identical(this, other)) return true;

    return other.key == key && other.isValid == isValid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ isValid.hashCode;
  }
}
