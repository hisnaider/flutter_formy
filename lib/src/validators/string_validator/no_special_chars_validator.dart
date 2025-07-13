import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/flutter_formy_validators.dart';

/// A validator that checks if the value doesn't contain any special characters.
///
/// The [NoSpecialCharsValidator] can be used with [FieldController]s holding
/// values of type `String`. It ensures that the
/// value is doesn't contain any special characters.
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
///   validators:[NoSpecialCharsValidator()],
/// );
///
/// // If field.value = '#hello_world', validation fails.
/// // If field.value = 'hello world', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class NoSpecialCharsValidator extends FormyValidator<String> {
  NoSpecialCharsValidator({super.message});

  final RegExp _pattern = RegExp(r'^[a-zA-Z0-9]+$');

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
        key: GenericValidators.noSpecialChars.name,
        message: message,
        isValid: _pattern.hasMatch(controller.value ?? ''),
      );
}
