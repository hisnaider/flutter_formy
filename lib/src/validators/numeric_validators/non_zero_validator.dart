import 'package:flutter_formy/flutter_formy.dart';

class NonZeroValidator extends FormyValidator<num> {
  NonZeroValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.nonZeroNum.name,
        message: message,
        isValid: (controller.value ?? 1) != 0,
      );
}
