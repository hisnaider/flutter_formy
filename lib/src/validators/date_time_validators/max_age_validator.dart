import 'package:flutter_formy/flutter_formy.dart';

class MaxAgeValidator extends FormyValidator<DateTime> {
  final int maxAge;
  MaxAgeValidator(this.maxAge, {super.message});
  @override
  ValidationResult onValidate(FieldController<DateTime> controller) {
    bool isValid = true;
    if (controller.value != null) {
      final today = DateTime.now();
      int age = today.year - controller.value!.year;

      if (today.month < controller.value!.month ||
          (today.month == controller.value!.month &&
              today.day < controller.value!.day)) {
        age--;
      }
      isValid = age <= maxAge;
    }
    return ValidationResult(
      key: GenericValidators.maxAge.name,
      message: message,
      isValid: isValid,
    );
  }
}
