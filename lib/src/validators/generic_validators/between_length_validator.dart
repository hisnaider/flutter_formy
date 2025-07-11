import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the length of a value is between [minLength] and [maxLength].
///
/// The [BetweenLengthValidator] can be used with [FieldController]s holding
/// values of types `String`, `List`, `Map` or `Set`. It ensures that the
/// length is between [minLength] and [maxLength].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [minLength]: The minimum allowed length for the value.
/// * [maxLength]: The maximum allowed length for the value.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(key: 'name', validator:[BetweenLengthValidator(minLength:4, maxLength:6)]);
///
/// // If field.value = 'Ana', validation fails.
/// // If field.value = 'João Pedro', validation fails.
/// // If field.value = 'Maria', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class BetweenLengthValidator<T> extends FormyValidator<T> {
  /// The minimum allowed length for the value.
  final int minLength;

  /// The maximum allowed length for the value.
  final int maxLength;
  BetweenLengthValidator({
    super.message,
    required this.minLength,
    required this.maxLength,
  }) : assert(minLength <= maxLength,
            'minLength must be less than or equal to maxLength');

  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length >= minLength && value.length <= maxLength;
      } else if (value is List) {
        isValid = value.length >= minLength && value.length <= maxLength;
      } else if (value is Map) {
        isValid = value.length >= minLength && value.length <= maxLength;
      } else if (value is Set) {
        isValid = value.length >= minLength && value.length <= maxLength;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.betweenLength.name,
      message: message,
      isValid: isValid,
    );
  }
}
