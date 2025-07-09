import 'package:flutter_formy/flutter_formy.dart';

class NoNumbersValidator extends FormyValidator<String> {
  NoNumbersValidator({super.message});

  final RegExp _pattern = RegExp(r'[^[0-9]+$');

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
        key: GenericValidators.noNumbers.name,
        message: message,
        isValid: !_pattern.hasMatch(controller.value ?? ''),
      );
}
