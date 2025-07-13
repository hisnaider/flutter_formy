import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/flutter_formy_validators.dart';

/// A validator that checks if the length of a value is equal or less than [maxLength].
///
/// The [MaxLengthValidator] can be used with [FieldController]s holding
/// values of types `String`, `List`, `Map` or `Set`. It ensures that the
/// length is equal or less than [maxLength].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [maxLength]: The maximun allowed length for the value.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(
///   key: 'name',
///   validators:[MaxLengthValidator(6)],
/// );
///
/// // If field.value = 'João Pedro', validation fails.
/// // If field.value = 'Maria', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class MaxLengthValidator<T> extends FormyValidator<T> {
  /// The maximun allowed length for the value.
  final int maxLength;
  MaxLengthValidator(this.maxLength, {super.message});
  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length <= maxLength;
      } else if (value is List) {
        isValid = value.length <= maxLength;
      } else if (value is Map) {
        isValid = value.length <= maxLength;
      } else if (value is Set) {
        isValid = value.length <= maxLength;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.maxLength.name,
      message: message,
      isValid: isValid,
    );
  }
}
