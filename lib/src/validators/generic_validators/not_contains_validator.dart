import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value NOT contains [notContain].
///
/// The [NotContainsValidator] can be used with [FieldController]s holding
/// values of types `String`, `Iterable` or `Map`. It ensures that the
/// value NOT contains [notContain].
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [notContain]: The value that the field should NOT contain.
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<int> field = FieldController(
///   key: 'name',
///   validators:[NotContainsValidator('Bye')],
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
class NotContainsValidator<T> extends FormyValidator<T> {
  /// The value that the field value should NOT contain.
  final dynamic notContain;

  NotContainsValidator(this.notContain, {super.message});

  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final data = controller.value;

    final isValid = data == null || !_contains(data);

    return ValidationResult(
      key: GenericValidators.notContains.name,
      message: message,
      isValid: isValid,
    );
  }

  bool _contains(T container) {
    if (container is String) {
      return container.contains(notContain);
    } else if (container is Iterable) {
      return container.contains(notContain);
    } else if (container is Map) {
      return container.containsKey(notContain);
    }
    return container == notContain;
  }
}
