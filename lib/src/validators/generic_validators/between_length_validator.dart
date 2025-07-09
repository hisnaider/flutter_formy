import 'package:flutter_formy/flutter_formy.dart';

class BetweenLengthValidator<T> extends FormyValidator<T> {
  final int minLength;
  final int maxLength;
  BetweenLengthValidator({
    super.message,
    required this.minLength,
    required this.maxLength,
  });

  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length >= minLength && value.length <= maxLength;
      } else if (value is List) {
        isValid = value.length >= minLength && value.length <= maxLength;
      } else if (value is Map) {
        isValid = value.length >= minLength && value.length <= maxLength;
      } else if (value is Set) {
        isValid = value.length >= minLength && value.length <= maxLength;
      } else {
        isValid = false;
      }
    }
    return ValidationResult(
      key: GenericValidators.betweenLength.name,
      message: message,
      isValid: isValid,
    );
  }
}
