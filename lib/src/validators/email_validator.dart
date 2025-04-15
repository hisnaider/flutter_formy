import 'package:flutter_formy/src/validators/formy_validator.dart';
import 'package:flutter_formy/src/enum/generic_validators.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/validators/formy_validator.dart';

class EmailValidator extends FormyValidator<String> {
  static final RegExp _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  ValidationResult onValidate(FieldControl<String> control) {
    String? message;
    if (control.value != null &&
        control.value!.isNotEmpty &&
        !_emailRegex.hasMatch(control.value!)) {
      message = "Invalid email";
    }
    return ValidationResult(
      key: GenericValidators.invalidEmail.name,
      isValid: message == null,
      message: message,
    );
  }
}
