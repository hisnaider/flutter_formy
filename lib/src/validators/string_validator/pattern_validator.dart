import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value matches [pattern].
///
/// The [PatternValidator] can be used with [FieldController]s holding
/// values of type `String`. It ensures that the
/// value matches [pattern].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [pattern]: The pattern that the field should match.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(
///   key: 'string',
///   validators:[PatternValidator(RegExp(r'^[a-z]+$'))],
/// );
///
/// // If field.value = 'Hello123!', validation fails.
/// // If field.value = 'hello', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class PatternValidator extends FormyValidator<String> {
  /// The pattern that the field should match.
  final RegExp pattern;
  PatternValidator(this.pattern, {super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
          key: GenericValidators.pattern.name,
          message: message,
          isValid: controller.value != null
              ? pattern.hasMatch(controller.value!)
              : true);
}
