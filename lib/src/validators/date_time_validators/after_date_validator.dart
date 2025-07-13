import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_base_validators.dart';

/// A validator that checks if the value date is greater than [date].
///
/// The [AfterDateValidator] can be used with [FieldController]s holding
/// values of type `DateTime`. It ensures that the
/// value is greater than [date].
///
/// If the value is `null`, it is treated as valid by default.
///
/// ## Properties
///
/// * [date]: The date the value must be strictly greater than.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<DateTime> field = FieldController(
///   key: 'date',
///   validators: [AfterDateValidator(DateTime(2025, 7, 12))],
/// );
///
/// // If field.value = DateTime(2025, 7, 11), validation fails.
/// // If field.value = DateTime(2025, 7, 12), validation fails.
/// // If field.value = DateTime(2025, 7, 13), validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class AfterDateValidator extends FormyValidator<DateTime> {
  /// The date the value must be strictly greater than.
  final DateTime date;
  AfterDateValidator(this.date, {super.message});
  @override
  ValidationResult onValidate(FieldController<DateTime> controller) =>
      ValidationResult(
        key: GenericValidators.afterDate.name,
        message: message,
        isValid:
            controller.value != null ? controller.value!.isAfter(date) : true,
      );
}
