import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/validators/formy_cross_validator.dart';

/// A validator that checks if the value is not equal to the value of [otherField].
///
/// The [MustNotMatchValidator] can be used with [FieldController]s holding
/// values of type [T]. It ensures that the value is not equal to the value
/// of [otherField].
///
/// If the value is `null`, it is treated as valid by default.
///
/// ## Properties
///
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
///GroupController group = GroupController(
///  key: 'string',
///  fields: [
///    FieldConfig<string>(key: 'string1'),
///    FieldConfig<string>(key: 'string2', validators: [MustNotMatchValidator(otherField: 'string1')]),
///  ],
///);
///
/// // If 'string1' value = 'abc' and 'string2' value = 'abc', validation fails.
/// // If 'string1' value = 'abc' and 'string2' value = '123, validation passes.
/// ```
///
/// ## See also
///
/// * [FormyCrossValidator], the base class for cross-field validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class MustNotMatchValidator<T> extends FormyCrossValidator<T> {
  MustNotMatchValidator({required super.otherField, super.message});
  @override
  ValidationResult onValidate(FieldController<T> controller) =>
      ValidationResult(
        key: GenericValidators.mustNotMatch.name,
        message: message,
        isValid: controller.value != null
            ? controller.value != otherController.value
            : true,
      );
}
