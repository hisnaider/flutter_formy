import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_base_validators.dart';

/// A validator that checks if the value date is less than [date].
///
/// The [BeforeDateValidator] can be used with [FieldController]s holding
/// values of type `DateTime`. It ensures that the
/// value is less than [date].
///
/// If the value is `null`, it is treated as valid by default.
///
/// ## Properties
///
/// * [date]: The date the value must be strictly less than.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<DateTime> field = FieldController(
///   key: 'date',
///   validators: [BeforeDateValidator(DateTime(2025, 7, 12))],
/// );
///
/// // If field.value = DateTime(2025, 7, 13), validation fails.
/// // If field.value = DateTime(2025, 7, 12), validation fails.
/// // If field.value = DateTime(2025, 7, 11), validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class BeforeDateValidator extends FormyValidator<DateTime> {
  /// The date the value must be strictly less than.
  final DateTime date;
  BeforeDateValidator(this.date, {super.message});
  @override
  ValidationResult onValidate(FieldController<DateTime> controller) =>
      ValidationResult(
        key: GenericValidators.beforeDate.name,
        message: message,
        isValid:
            controller.value != null ? controller.value!.isBefore(date) : true,
      );
}
