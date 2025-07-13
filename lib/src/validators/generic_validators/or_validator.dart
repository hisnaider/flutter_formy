import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value passes in at least one [FormyValidator].
///
/// The [OrValidator] can be used with [FieldController]s holding
/// values of any types. It ensures that the
/// value passes in at least one [FormyValidator]
///
/// ## Properties
///
/// * [validators]: List of [FormyValidator] that the value must pass in at least one.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(
///   key: 'name',
///   validators:[
///     PatternValidator(RegExp(r'[^[0-9]+$')),
///     EmailValidator(),
///   ]
/// );
///
/// // If field.value = 'Maria', validation fails.
/// // If field.value = 'maria@email.com', validation passes.
/// // If field.value = '123456', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
/// * [EmailValidator], which validates email.
/// * [PatternValidator], which validates a pattern.
class OrValidator extends FormyValidator {
  /// List of [FormyValidator] that the value must pass in at least one.
  final List<FormyValidator> validators;
  OrValidator(this.validators, {required super.message});

  @override
  ValidationResult onValidate(FieldController controller) {
    for (FormyValidator validator in validators) {
      final ValidationResult result = validator(controller);
      if (result.isValid) {
        return result;
      }
    }
    return ValidationResult(
        key: GenericValidators.or.name, message: message, isValid: false);
  }
}
