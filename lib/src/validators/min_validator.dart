import 'package:flutter_formy/flutter_formy.dart';

class MinValidator<T> extends FormyValidator<T> {
  MinValidator(this.min);
  final int min;
  @override
  ValidationResult onValidate(FieldController<T> control) {
    final value = control.value;
    bool isValid = true;
    if (control.value != null) {
      if (value is String) {
        isValid = value.length >= min;
      } else if (value is List) {
        isValid = value.length >= min;
      } else if (value is Map) {
        isValid = value.length >= min;
      } else if (value is Set) {
        isValid = value.length >= min;
      } else if (value is num) {
        isValid = value >= min;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.min.name,
      isValid: isValid,
    );
  }
}
