import 'package:flutter_formy/flutter_formy.dart';

class MinAgeValidator extends FormyValidator<DateTime> {
  final int minAge;
  MinAgeValidator(this.minAge, {super.message});
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
      isValid = age >= minAge;
    }
    return ValidationResult(
      key: GenericValidators.minAge.name,
      message: message,
      isValid: isValid,
    );
  }
}
