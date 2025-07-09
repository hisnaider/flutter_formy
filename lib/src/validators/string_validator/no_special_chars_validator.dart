import 'package:flutter_formy/flutter_formy.dart';

class NoSpecialCharsValidator extends FormyValidator<String> {
  NoSpecialCharsValidator({super.message});

  final RegExp _pattern = RegExp(r'[^[a-zA-Z0-9]+$');

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
        key: GenericValidators.noSpecialChars.name,
        message: message,
        isValid: _pattern.hasMatch(controller.value ?? ''),
      );
}
