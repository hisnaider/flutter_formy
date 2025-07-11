import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the length of a value is equal to [exactLength].
///
/// The [ExactLengthValidator] can be used with [FieldController]s holding
/// values of types `String`, `List`, `Map` or `Set`. It ensures that the
/// length is equal to [exactLength].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [exactLength]: The exact allowed length for the value.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(key: 'name', validator:[ExactLengthValidator(3)]);
///
/// // If field.value = 'Maria', validation fails.
/// // If field.value = 'João Pedro', validation fails.
/// // If field.value = 'Ana', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class ExactLengthValidator<T> extends FormyValidator<T> {
  /// The exact allowed length for the value.
  final int exactLength;
  ExactLengthValidator(this.exactLength, {super.message});
  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length == exactLength;
      } else if (value is List) {
        isValid = value.length == exactLength;
      } else if (value is Map) {
        isValid = value.length == exactLength;
      } else if (value is Set) {
        isValid = value.length == exactLength;
      } else if (value is num) {
        isValid = value == exactLength;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.exactLength.name,
      message: message,
      isValid: isValid,
    );
  }
}
