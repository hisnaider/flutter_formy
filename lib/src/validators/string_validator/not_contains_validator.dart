import 'package:flutter_formy/flutter_formy.dart';

class NotContainsValidator extends FormyValidator {
  final dynamic value;
  NotContainsValidator(this.value, {super.message});

  @override
  ValidationResult onValidate(FieldController controller) => ValidationResult(
        key: GenericValidators.notContains.name,
        message: message,
        isValid: controller.value != null
            ? !controller.value.toString().contains(value.toString())
            : true,
      );
}
