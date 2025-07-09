import 'package:flutter_formy/flutter_formy.dart';

class PositiveNumValidator extends FormyValidator<num> {
  PositiveNumValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.positiveNum.name,
        message: message,
        isValid: (controller.value ?? 1) > 0,
      );
}
