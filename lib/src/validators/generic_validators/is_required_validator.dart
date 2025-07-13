import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value is not null, empty nor false.
///
/// The [IsRequired] can be used with [FieldController]s holding
/// values of types `String`, `Iterable`, `Map` or `bool`. It ensures that the
/// value is not null, empty nor false.
///
/// ## Properties
///
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(
///   key: 'name',
///   validators:[IsRequired()],
/// );
///
/// // If field.value = null, validation fails.
/// // If field.value = '', validation fails.
/// // If field.value = 'Ana', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class IsRequired<T> extends FormyValidator<T> {
  IsRequired({super.message});
  @override
  ValidationResult onValidate(FieldController controller) {
    bool isValid = true;

    if (controller.value == null) {
      isValid = false;
    } else if (controller.value is String && controller.value!.trim().isEmpty) {
      isValid = false;
    } else if (controller.value is Iterable && controller.value!.isEmpty) {
      isValid = false;
    } else if (controller.value is Map && controller.value!.isEmpty) {
      isValid = false;
    } else if (controller.value is bool) {
      isValid = controller.value;
    }

    return ValidationResult(
      key: GenericValidators.isRequired.name,
      message: message,
      isValid: isValid,
    );
  }
}
