import 'package:flutter_formy/flutter_formy.dart';

class NoSpaceValidator extends FormyValidator<String> {
  NoSpaceValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
        key: GenericValidators.noSpaces.name,
        message: message,
        isValid: !(controller.value ?? '').contains(' '),
      );
}
