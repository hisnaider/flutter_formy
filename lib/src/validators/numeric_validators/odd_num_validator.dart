import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/flutter_formy_validators.dart';

/// A validator that checks if the value is odd.
///
/// The [OddNumValidator] can be used with [FieldController]s holding
/// values of type `int`. It ensures that the
/// value is odd.
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
///   validators:[OddNumValidator()],
/// );
///
/// // If field.value = 2, validation fails.
/// // If field.value = 3, validation passes.
/// // If field.value = 5, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class OddNumValidator extends FormyValidator<int> {
  OddNumValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<int> controller) =>
      ValidationResult(
        key: GenericValidators.oddNum.name,
        message: message,
        isValid: (controller.value ?? 1) % 2 != 0,
      );
}
