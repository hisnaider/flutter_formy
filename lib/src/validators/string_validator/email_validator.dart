import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value is a valid email.
///
/// The [EmailValidator] can be used with [FieldController]s holding
/// values of type `String`. It ensures that the
/// value is a valid email.
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
///   validators:[EmailValidator()],
/// );
///
/// // If field.value = 'test', validation fails.
/// // If field.value = 'test@.com', validation fails.
/// // If field.value = '.test@email.com', validation fails.
/// // If field.value = 'test.@email.com', validation fails.
/// // If field.value = 'test..2@email.com', validation fails.
/// // If field.value = 'teste@email.com', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class EmailValidator extends FormyValidator<String> {
  EmailValidator({super.message});
  static final RegExp _emailRegex = RegExp(
      r'^[a-zA-Z0-9]+([._%+-][a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$');
  @override
  ValidationResult onValidate(FieldController<String> controller) {
    bool isValid = true;
    if (controller.value != null &&
        controller.value!.isNotEmpty &&
        !_emailRegex.hasMatch(controller.value!)) {
      isValid = false;
    }
    return ValidationResult(
      key: GenericValidators.invalidEmail.name,
      message: message,
      isValid: isValid,
    );
  }
}
