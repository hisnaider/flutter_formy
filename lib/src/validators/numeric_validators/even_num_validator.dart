import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_base_validators.dart';

/// A validator that checks if the value is even.
///
/// The [EvenNumValidator] can be used with [FieldController]s holding
/// values of type `int`. It ensures that the
/// value is even.
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
///   validators:[EvenNumValidator()],
/// );
///
/// // If field.value = 3, validation fails.
/// // If field.value = 2, validation passes.
/// // If field.value = 4, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class EvenNumValidator extends FormyValidator<int> {
  EvenNumValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<int> controller) =>
      ValidationResult(
        key: GenericValidators.evenNum.name,
        message: message,
        isValid: (controller.value ?? 2) % 2 == 0,
      );
}
