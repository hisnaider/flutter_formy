import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/flutter_formy_validators.dart';

/// A validator that checks if the value is negative.
///
/// The [NegativeNumValidator] can be used with [FieldController]s holding
/// values of types `int` or `double`. It ensures that the
/// value is negative.
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
///   validators:[NegativeNumValidator()],
/// );
///
/// // If field.value = 3, validation fails.
/// // If field.value = -3, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class NegativeNumValidator extends FormyValidator<num> {
  NegativeNumValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.negativeNum.name,
        message: message,
        isValid: (controller.value ?? -1) < 0,
      );
}
