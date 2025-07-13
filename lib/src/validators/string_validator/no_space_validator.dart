import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_base_validators.dart';

/// A validator that checks if the value doesn't contain any space.
///
/// The [NoSpaceValidator] can be used with [FieldController]s holding
/// values of type `String`. It ensures that the
/// value is doesn't contain any space.
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(
///   key: 'string',
///   validators:[NoSpaceValidator()],
/// );
///
/// // If field.value = 'hello world', validation fails.
/// // If field.value = 'helloWorld', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class NoSpaceValidator extends FormyValidator<String> {
  NoSpaceValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
        key: GenericValidators.noSpaces.name,
        message: message,
        isValid: !(controller.value ?? '').contains(' '),
      );
}
