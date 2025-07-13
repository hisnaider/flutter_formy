import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value date is between [minDate] and [maxDate].
///
/// The [BetweenDatesValidator] can be used with [FieldController]s holding
/// values of type `DateTime`. It ensures that the
/// value is is between [minDate] and [maxDate].
///
/// If the value is `null`, it is treated as valid by default.
///
/// ## Properties
///
/// * [minDate]: The minimum allowed date for the value.
/// * [maxDate]: The maximum allowed date for the value.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<DateTime> field = FieldController(
///   key: 'date',
///   validators: [BetweenDatesValidator(minDate: DateTime(2025, 7, 12), maxDate: DateTime(2025, 7, 14))],
/// );
///
/// // If field.value = DateTime(2025, 7, 11), validation fails.
/// // If field.value = DateTime(2025, 7, 15), validation fails.
/// // If field.value = DateTime(2025, 7, 12), validation passes.
/// // If field.value = DateTime(2025, 7, 13), validation passes.
/// // If field.value = DateTime(2025, 7, 14), validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class BetweenDatesValidator extends FormyValidator<DateTime> {
  /// The minimum allowed date for the value.
  final DateTime minDate;

  /// The maximum allowed date for the value.
  final DateTime maxDate;
  BetweenDatesValidator(
      {required this.minDate, required this.maxDate, super.message});
  @override
  ValidationResult onValidate(FieldController<DateTime> controller) =>
      ValidationResult(
        key: GenericValidators.betweenDates.name,
        message: message,
        isValid: controller.value != null
            ? (controller.value!.isAfter(minDate) ||
                    controller.value!.isAtSameMomentAs(minDate)) &&
                (controller.value!.isBefore(maxDate) ||
                    controller.value!.isAtSameMomentAs(maxDate))
            : true,
      );
}
