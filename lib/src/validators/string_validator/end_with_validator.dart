import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_base_validators.dart';

/// A validator that checks if the value ends with [end].
///
/// The [EndWithValidator] can be used with [FieldController]s holding
/// values of type `String`. It ensures that the
/// value ends with [end].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [end]: The value that the field should end with.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(
///   key: 'string',
///   validators:[EndWithValidator('world!')],
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
class EndWithValidator extends FormyValidator<String> {
  /// The value that the field should end with.
  final String end;
  EndWithValidator(this.end, {super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
          key: GenericValidators.endWith.name,
          message: message,
          isValid: controller.value != null
              ? controller.value!.endsWith(end)
              : true);
}
