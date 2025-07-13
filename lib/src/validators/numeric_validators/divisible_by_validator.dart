import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value is divisible by [denominator].
///
/// The [DivisibleByValidator] can be used with [FieldController]s holding
/// values of type `int`. It ensures that the
/// value is divisible by [denominator].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [denominator]: The denominator of the division.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<int> field = FieldController(
///   key: 'number',
///   validators:[DivisibleByValidator(4)],
/// );
///
/// // If field.value = 3, validation fails.
/// // If field.value = 4, validation passes.
/// // If field.value = 8, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class DivisibleByValidator extends FormyValidator<int> {
  /// The denominator of the division.
  final int denominator;
  DivisibleByValidator(this.denominator, {super.message})
      : assert(denominator != 0, 'denominator cannot be 0');

  @override
  ValidationResult onValidate(FieldController<int> controller) =>
      ValidationResult(
        key: GenericValidators.divisibleBy.name,
        message: message,
        isValid: (controller.value ?? denominator) % denominator == 0,
      );
}
