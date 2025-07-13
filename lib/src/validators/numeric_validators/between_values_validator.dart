import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value is between [minValue] and [maxValue].
///
/// The [BetweenValuesValidator] can be used with [FieldController]s holding
/// values of types `int` or `double`. It ensures that the
/// value is between [minValue] and [maxValue].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [minValue]: The minimum allowed for the value.
/// * [maxValue]: The maximum allowed for the value.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<int> field = FieldController(
///   key: 'number',
///   validators:[BetweenValuesValidator(minValue:4, maxValue:6)],
/// );
///
/// // If field.value = 3, validation fails.
/// // If field.value = 7, validation fails.
/// // If field.value = 5, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class BetweenValuesValidator extends FormyValidator<num> {
  /// The minimum allowed for the value.
  final num minValue;

  /// The maximum allowed for the value.
  final num maxValue;
  BetweenValuesValidator({
    super.message,
    required this.minValue,
    required this.maxValue,
  }) : assert(minValue <= maxValue,
            'minValue must be less than or equal to maxValue');

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.betweenValues.name,
        message: message,
        isValid: controller.value != null
            ? controller.value! >= minValue && controller.value! <= maxValue
            : true,
      );
}
