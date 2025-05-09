class ValidationResult {
  const ValidationResult({
    required this.key,
    this.isValid = false,
  });
  final String key;
  final bool isValid;

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
