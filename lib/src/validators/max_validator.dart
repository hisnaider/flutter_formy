import 'package:flutter_formy/flutter_formy.dart';

class MaxValidator<T> extends FormyValidator<T> {
  MaxValidator(this.max, {super.message});
  final int max;
  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length <= max;
      } else if (value is List) {
        isValid = value.length <= max;
      } else if (value is Map) {
        isValid = value.length <= max;
      } else if (value is Set) {
        isValid = value.length <= max;
      } else if (value is num) {
        isValid = value <= max;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.max.name,
      message: message,
      isValid: isValid,
    );
  }
}
