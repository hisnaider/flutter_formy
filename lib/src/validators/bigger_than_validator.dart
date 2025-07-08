import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/validators/formy_cross_validator.dart';

class BiggerThanValidator extends FormyCrossValidator {
  BiggerThanValidator({required super.otherField, super.message});

  @override
  ValidationResult onValidate(FieldController controller) {
    final value = controller.value;
    final otherValue = otherController.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length <= otherValue.lenght;
      } else if (value is List) {
        isValid = value.length <= otherValue.lenght;
      } else if (value is Map) {
        isValid = value.length <= otherValue.lenght;
      } else if (value is Set) {
        isValid = value.length <= otherValue.lenght;
      } else if (value is num) {
        isValid = value <= otherValue;
      } else if (value is DateTime) {
        isValid = value.isAfter(otherValue);
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.biggerThan.name,
      message: message,
      isValid: isValid,
    );
  }
}
