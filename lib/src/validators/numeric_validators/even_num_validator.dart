import 'package:flutter_formy/flutter_formy.dart';

class EvenNumValidator extends FormyValidator<num> {
  EvenNumValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.evenNum.name,
        message: message,
        isValid: (controller.value ?? 2) % 2 == 0,
      );
}
