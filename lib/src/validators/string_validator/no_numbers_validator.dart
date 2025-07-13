import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value doesn't contain any number.
///
/// The [NoNumbersValidator] can be used with [FieldController]s holding
/// values of type `String`. It ensures that the
/// value is doesn't contain any number.
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
///   validators:[NoNumbersValidator()],
/// );
///
/// // If field.value = '123', validation fails.
/// // If field.value = 'h3!!0 w0r!d', validation fails.
/// // If field.value = 'hello world 2', validation fails.
/// // If field.value = 'hello world', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class NoNumbersValidator extends FormyValidator<String> {
  NoNumbersValidator({super.message});

  final RegExp _pattern = RegExp(r'[^[0-9]+$');

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
        key: GenericValidators.noNumbers.name,
        message: message,
        isValid: controller.value != null && controller.value!.isNotEmpty
            ? _pattern.hasMatch(controller.value!)
            : true,
      );
}
