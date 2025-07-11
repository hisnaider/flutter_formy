import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the length of a value is equal or greater than [minLength].
///
/// The [MinLengthValidator] can be used with [FieldController]s holding
/// values of types `String`, `List`, `Map` or `Set`. It ensures that the
/// length is equal or greater than [minLength].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [minLength]: The minimum allowed length for the value.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(key: 'name', validator:[MinLengthValidator(6)]);
///
/// // If field.value = 'Maria', validation fails.
/// // If field.value = 'João Pedro', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class MinLengthValidator<T> extends FormyValidator<T> {
  /// The minimum allowed length for the value.
  final int minLength;
  MinLengthValidator(this.minLength, {super.message});
  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length >= minLength;
        print(isValid);
      } else if (value is List) {
        isValid = value.length >= minLength;
      } else if (value is Map) {
        isValid = value.length >= minLength;
      } else if (value is Set) {
        isValid = value.length >= minLength;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.minLength.name,
      message: message,
      isValid: isValid,
    );
  }
}
