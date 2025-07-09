import 'package:flutter_formy/flutter_formy.dart';

class OddNumValidator extends FormyValidator<num> {
  OddNumValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.oddNum.name,
        message: message,
        isValid: (controller.value ?? 1) % 2 != 0,
      );
}
