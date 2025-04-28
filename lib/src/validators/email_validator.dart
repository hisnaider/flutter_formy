import 'package:flutter_formy/flutter_formy.dart';

class EmailValidator extends FormyValidator<String> {
  static final RegExp _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  ValidationResult onValidate(FieldController<String> control) {
    bool isValid = true;
    if (control.value != null &&
        control.value!.isNotEmpty &&
        !_emailRegex.hasMatch(control.value!)) {
      isValid = false;
    }
    return ValidationResult(
      key: GenericValidators.invalidEmail.name,
      isValid: isValid,
    );
  }
}
