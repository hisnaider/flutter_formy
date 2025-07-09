import 'package:flutter_formy/flutter_formy.dart';

class NegativeNumValidator extends FormyValidator<num> {
  NegativeNumValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.negativeNum.name,
        message: message,
        isValid: (controller.value ?? -1) < 0,
      );
}
