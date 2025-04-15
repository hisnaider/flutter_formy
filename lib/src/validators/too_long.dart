import 'package:flutter_formy/src/enum/generic_validators.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/validators/formy_validator.dart';

class TooLong extends FormyValidator<String> {
  TooLong(this.maxLength);
  final int maxLength;
  @override
  ValidationResult onValidate(FieldControl<String> control) {
    String? message;
    if (control.value != null &&
        control.value!.isNotEmpty &&
        control.value!.length > maxLength) {
      message = "Too long, it must be less than $maxLength characters";
    }
    return ValidationResult(
      key: GenericValidators.tooLong.name,
      isValid: message == null,
      message: message,
    );
  }
}
