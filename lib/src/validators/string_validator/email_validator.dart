import 'package:flutter_formy/flutter_formy.dart';

class EmailValidator extends FormyValidator<String> {
  EmailValidator({super.message});
  static final RegExp _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  ValidationResult onValidate(FieldController<String> controller) {
    bool isValid = true;
    if (controller.value != null &&
        controller.value!.isNotEmpty &&
        !_emailRegex.hasMatch(controller.value!)) {
      isValid = false;
    }
    return ValidationResult(
      key: GenericValidators.invalidEmail.name,
      message: message,
      isValid: isValid,
    );
  }
}
