import 'package:flutter_formy/flutter_formy.dart';

class ContainsValidator<T> extends FormyValidator<T> {
  final dynamic value;

  ContainsValidator(this.value, {super.message});

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

  bool _contains(dynamic container) {
    if (container is String) {
      return value is String && container.contains(value);
    } else if (container is Iterable) {
      return container.contains(value);
    } else if (container is Map) {
      return container.containsKey(value);
    }
    // fallback: compara igualdade direta
    return container == value;
  }
}
