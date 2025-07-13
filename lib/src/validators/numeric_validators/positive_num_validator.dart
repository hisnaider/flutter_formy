import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value is positive.
///
/// The [PositiveNumValidator] can be used with [FieldController]s holding
/// values of types `int` or `double`. It ensures that the
/// value is positive.
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<int> field = FieldController(
///   key: 'number',
///   validators:[PositiveNumValidator()],
/// );
///
/// // If field.value = -3, validation fails.
/// // If field.value = 3, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class PositiveNumValidator extends FormyValidator<num> {
  PositiveNumValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.positiveNum.name,
        message: message,
        isValid: (controller.value ?? 1) > 0,
      );
}
