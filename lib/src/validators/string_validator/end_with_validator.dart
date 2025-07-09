import 'package:flutter_formy/flutter_formy.dart';

class EndWithValidator extends FormyValidator<String> {
  final String end;
  EndWithValidator(this.end, {super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
          key: GenericValidators.endWith.name,
          message: message,
          isValid: controller.value != null
              ? controller.value!.endsWith(end)
              : true);
}
