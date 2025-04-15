import 'package:flutter_formy/src/enum/generic_validators.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/validators/formy_validator.dart';

class TooShort extends FormyValidator<String> {
  TooShort(this.minLength);
  final int minLength;
  @override
  ValidationResult onValidate(FieldControl<String> control) {
    String? message;
    if (control.value != null &&
        control.value!.isNotEmpty &&
        control.value!.length < minLength) {
      message = "Too short, it must be at least $minLength characters";
    }
    return ValidationResult(
      key: GenericValidators.tooShort.name,
      isValid: message == null,
      message: message,
    );
  }
}
