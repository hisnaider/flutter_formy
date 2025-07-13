import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the age calculated from the value date is greater than or equal to [minAge].
///
/// The [MinAgeValidator] can be used with [FieldController]s holding
/// values of type `DateTime`. It ensures that the
/// calculated age is at least [minAge].
///
/// If the value is `null`, it is treated as valid by default.
///
/// ## Properties
///
/// * [minAge]: The minimum allowed age calculated from the value date.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<DateTime> field = FieldController(
///   key: 'birthDate',
///   initialValue: DateTime(2025, 7, 12)
///   validators: [MinAgeValidator(18)],
/// );
///
/// // If field.value = DateTime(2010, 7, 12), validation fails.
/// // If field.value = DateTime(2000, 7, 12), validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class MinAgeValidator extends FormyValidator<DateTime> {
  /// The minimum allowed age calculated from the value date.
  final int minAge;
  MinAgeValidator(this.minAge, {super.message});
  @override
  ValidationResult onValidate(FieldController<DateTime> controller) {
    bool isValid = true;
    if (controller.value != null) {
      final today = DateTime.now();
      int age = today.year - controller.value!.year;

      if (today.month < controller.value!.month ||
          (today.month == controller.value!.month &&
              today.day < controller.value!.day)) {
        age--;
      }
      isValid = age >= minAge;
    }
    return ValidationResult(
      key: GenericValidators.minAge.name,
      message: message,
      isValid: isValid,
    );
  }
}
