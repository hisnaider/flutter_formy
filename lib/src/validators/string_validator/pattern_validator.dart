import 'package:flutter_formy/flutter_formy.dart';

class PatternValidator extends FormyValidator<String> {
  final RegExp pattern;
  PatternValidator(this.pattern, {super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
          key: GenericValidators.pattern.name,
          message: message,
          isValid: controller.value != null
              ? pattern.hasMatch(controller.value!)
              : true);
}
