import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_base_validators.dart';

/// A validator that checks if the value is greater than or equal to the value of [otherField].
///
/// The [BiggerThanValidator] can be used with [FieldController]s holding
/// values of type `num`, `String`, `List`, `Map`, or `Set`. It ensures that
/// the value is greater than or equal to the value of [otherField].
///
/// For `String`, `List`, `Map`, and `Set`, the comparison is done based on length.
/// For `num`, the comparison is done directly on the numeric value.
///
/// If the value is `null`, it is treated as valid by default.
///
/// ## Properties
///
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
///GroupController group = GroupController(
///  key: 'num',
///  fields: [
///    FieldConfig<int>(key: 'num1'),
///    FieldConfig<int>(key: 'num2', validators: [BiggerThanValidator(otherField: 'num1')]),
///  ],
///);
///
/// // If 'num1' value = 10 and 'num2' value = 5, validation fails.
/// // If 'num1' value = 5 and 'num2' value = 10, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyCrossValidator], the base class for cross-field validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.

class BiggerThanValidator<T> extends FormyCrossValidator<T> {
  BiggerThanValidator({required super.otherField, super.message});

  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    final otherValue = otherController.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length >= otherValue.length;
      } else if (value is List) {
        isValid = value.length >= otherValue.length;
      } else if (value is Map) {
        isValid = value.length >= otherValue.length;
      } else if (value is Set) {
        isValid = value.length >= otherValue.length;
      } else if (value is num) {
        isValid = value >= otherValue;
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
