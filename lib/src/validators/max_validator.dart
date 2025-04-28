import 'package:flutter_formy/flutter_formy.dart';

class MaxValidator<T> extends FormyValidator<T> {
  MaxValidator(this.max);
  final int max;
  @override
  ValidationResult onValidate(FieldController<T> control) {
    final value = control.value;
    bool isValid = true;
    if (control.value != null) {
      if (value is String) {
        isValid = value.length <= max;
      } else if (value is List) {
        isValid = value.length <= max;
      } else if (value is Map) {
        isValid = value.length <= max;
      } else if (value is Set) {
        isValid = value.length <= max;
      } else if (value is num) {
        isValid = value <= max;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.max.name,
      isValid: isValid,
    );
  }
}
