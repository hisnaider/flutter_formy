import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value is equal or greater than [minValue].
///
/// The [MinValueValidator] can be used with [FieldController]s holding
/// values of types `int` or `double`. It ensures that the
/// value is equal or greater than [minValue].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [minValue]: The minimum allowed for the value.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<int> field = FieldController(key: 'name', validator:[MinValueValidator(6)]);
///
/// // If field.value = 5, validation fails.
/// // If field.value = 6, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class MinValueValidator extends FormyValidator<num> {
  /// The minimum allowed for the value.
  final num minValue;
  MinValueValidator(this.minValue, {super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.minValue.name,
        message: message,
        isValid: controller.value != null ? controller.value! > minValue : true,
      );
}
