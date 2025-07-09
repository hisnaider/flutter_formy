import 'package:flutter_formy/flutter_formy.dart';

class StartWithValidator extends FormyValidator<String> {
  final String start;
  StartWithValidator(this.start, {super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
          key: GenericValidators.startWith.name,
          message: message,
          isValid: controller.value != null
              ? controller.value!.startsWith(start)
              : true);
}
