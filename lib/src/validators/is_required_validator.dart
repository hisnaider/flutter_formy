import 'package:flutter_formy/src/enum/generic_validators.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/validators/formy_validator.dart';

class IsRequired<T> extends FormyValidator<T> {
  @override
  ValidationResult onValidate(FieldControl control) {
    bool invalid = false;

    if (control.value == null) {
      invalid = true;
    } else if (control.value is String && control.value!.trim().isEmpty) {
      invalid = true;
    } else if (control.value is Iterable && control.value!.isEmpty) {
      invalid = true;
    }

    return ValidationResult(
      key: GenericValidators.isRequired.name,
      isValid: !invalid,
      message: invalid ? "Required field" : '',
    );
  }
}
