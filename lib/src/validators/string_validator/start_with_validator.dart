import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value starts with [start].
///
/// The [StartWithValidator] can be used with [FieldController]s holding
/// values of type `String`. It ensures that the
/// value starts with [start].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [start]: The value that the field should start with.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(
///   key: 'string',
///   validators:[StartWithValidator('hello')],
/// );
///
/// // If field.value = 'world, hello!', validation fails.
/// // If field.value = 'hello world!', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class StartWithValidator extends FormyValidator<String> {
  /// The value that the field should start with.
  final String start;
  StartWithValidator(this.start, {super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
          key: GenericValidators.startWith.name,
          message: message,
          isValid: controller.value != null
              ? controller.value!.startsWith(start)
              : true);
}
