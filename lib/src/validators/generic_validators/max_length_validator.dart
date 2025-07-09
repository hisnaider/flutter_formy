import 'package:flutter_formy/flutter_formy.dart';

class MaxLengthValidator<T> extends FormyValidator<T> {
  MaxLengthValidator(this.maxLength, {super.message});
  final int maxLength;
  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length <= maxLength;
      } else if (value is List) {
        isValid = value.length <= maxLength;
      } else if (value is Map) {
        isValid = value.length <= maxLength;
      } else if (value is Set) {
        isValid = value.length <= maxLength;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.maxLength.name,
      message: message,
      isValid: isValid,
    );
  }
}
