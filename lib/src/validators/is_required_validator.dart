import 'package:flutter_formy/flutter_formy.dart';

class IsRequired<T> extends FormyValidator<T> {
  @override
  ValidationResult onValidate(FieldController control) {
    bool isValid = true;

    if (control.value == null) {
      isValid = false;
    } else if (control.value is String && control.value!.trim().isEmpty) {
      isValid = false;
    } else if (control.value is Iterable && control.value!.isEmpty) {
      isValid = false;
    } else if (control.value is bool) {
      isValid = control.value;
    }

    return ValidationResult(
      key: GenericValidators.isRequired.name,
      isValid: isValid,
    );
  }
}
