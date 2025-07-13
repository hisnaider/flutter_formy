import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_base_validators.dart';

/// A validator that checks if the value is equal or less than [maxValue].
///
/// The [MaxValueValidator] can be used with [FieldController]s holding
/// values of types `int` or `double`. It ensures that the
/// value is equal or less than [maxValue].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [maxValue]: The maximun allowed for the value.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<int> field = FieldController(
///   key: 'name',
///   validators:[MaxValueValidator(6)],
/// );
///
/// // If field.value = 7, validation fails.
/// // If field.value = 6, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class MaxValueValidator extends FormyValidator<num> {
  /// The maximun allowed for the value.
  final num maxValue;
  MaxValueValidator(this.maxValue, {super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.maxValue.name,
        message: message,
        isValid:
            controller.value != null ? controller.value! <= maxValue : true,
      );
}
