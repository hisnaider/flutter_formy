import 'package:flutter_formy/src/enum/generic_validators.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/validators/formy_validator.dart';

class IsRequired<T> extends FormyValidator<T> {
  @override
  ValidationResult onValidate(FieldControl control) {
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
