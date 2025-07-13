import 'package:flutter_formy/flutter_formy.dart';

/// A base class for creating custom field validators.
///
/// The [FormyValidator] can be used with [FieldController]s holding
/// values of type `T`. It provides an interface to implement validation
/// logic by overriding [onValidate].
///
/// If you implement a custom validator, override the [onValidate]
/// method to define your specific validation rules.
///
/// ## Properties
///
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// class PositiveNumberValidator extends FormyValidator<int> {
///   PositiveNumberValidator({super.message});
///
///   @override
///   ValidationResult onValidate(FieldController<int> controller) {
///     final value = controller.value;
///     return ValidationResult(
///       key: 'positive',
///       message: message,
///       isValid: value != null ? value > 0 : true,
///     );
///   }
/// }
///
/// FieldController<int> field = FieldController(
///   key: 'amount',
///   validators: [PositiveNumberValidator()],
/// );
/// ```
///
/// ## See also
///
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
abstract class FormyValidator<T> {
  FormyValidator({required this.message});
  final String? message;
  ValidationResult onValidate(FieldController<T> controller);

  ValidationResult call(FieldController<T> controller) =>
      onValidate(controller);
}
