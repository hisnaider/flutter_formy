import 'package:flutter_formy/flutter_formy.dart';

class MinLengthValidator<T> extends FormyValidator<T> {
  MinLengthValidator(this.minLength, {super.message});
  final int minLength;
  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length >= minLength;
      } else if (value is List) {
        isValid = value.length >= minLength;
      } else if (value is Map) {
        isValid = value.length >= minLength;
      } else if (value is Set) {
        isValid = value.length >= minLength;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.minLength.name,
      message: message,
      isValid: isValid,
    );
  }
}
