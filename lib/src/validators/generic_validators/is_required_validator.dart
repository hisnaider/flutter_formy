import 'package:flutter_formy/flutter_formy.dart';

class IsRequired<T> extends FormyValidator<T> {
  IsRequired({super.message});
  @override
  ValidationResult onValidate(FieldController controller) {
    bool isValid = true;

    if (controller.value == null) {
      isValid = false;
    } else if (controller.value is String && controller.value!.trim().isEmpty) {
      isValid = false;
    } else if (controller.value is Iterable && controller.value!.isEmpty) {
      isValid = false;
    } else if (controller.value is bool) {
      isValid = controller.value;
    }

    return ValidationResult(
      key: GenericValidators.isRequired.name,
      message: message,
      isValid: isValid,
    );
  }
}
