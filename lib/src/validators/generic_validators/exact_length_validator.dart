import 'package:flutter_formy/flutter_formy.dart';

class ExactLengthValidator<T> extends FormyValidator<T> {
  ExactLengthValidator(this.exact, {super.message});
  final int exact;
  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final value = controller.value;
    bool isValid = true;
    if (controller.value != null) {
      if (value is String) {
        isValid = value.length == exact;
      } else if (value is List) {
        isValid = value.length == exact;
      } else if (value is Map) {
        isValid = value.length == exact;
      } else if (value is Set) {
        isValid = value.length == exact;
      } else if (value is num) {
        isValid = value == exact;
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
