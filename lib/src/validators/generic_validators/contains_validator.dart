import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value contains [contain].
///
/// The [ContainsValidator] can be used with [FieldController]s holding
/// values of types `String`, `Iterable` or `Map`. It ensures that the
/// value contains [contain].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [contain]: The value that the field should contain.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<int> field = FieldController(
///   key: 'name',
///   validators:[ContainsValidator('Hello')],
/// );
///
/// // If field.value = 'Bye World :( )', validation fails.
/// // If field.value = 'Hello World :) )', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class ContainsValidator<T> extends FormyValidator<T> {
  /// The value that the field value should contain.
  final dynamic contain;

  ContainsValidator(this.contain, {super.message});

  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final data = controller.value;

    final isValid = data == null || _contains(data);

    return ValidationResult(
      key: GenericValidators.contains.name,
      message: message,
      isValid: isValid,
    );
  }

  bool _contains(T container) {
    if (container is String) {
      return container.contains(contain);
    } else if (container is Iterable) {
      return container.contains(contain);
    } else if (container is Map) {
      return container.containsKey(contain);
    }
    // fallback: compara igualdade direta
    return container == contain;
  }
}
