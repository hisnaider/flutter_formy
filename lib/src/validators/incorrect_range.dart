import 'package:flutter_formy/src/enum/generic_validators.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/validators/formy_validator.dart';

class IncorrectRange extends FormyValidator {
  IncorrectRange(this.min, this.max);
  final int min;
  final int max;
  @override
  ValidationResult onValidate(FieldControl control) {
    String? message;
    if (control.value < min) {
      message = "It must be higher than $min";
    } else if (control.value > max) {
      message = "It must be lower than $max";
    }
    return ValidationResult(
      key: GenericValidators.incorrectRange.name,
      isValid: message == null,
      message: message,
    );
  }
}
