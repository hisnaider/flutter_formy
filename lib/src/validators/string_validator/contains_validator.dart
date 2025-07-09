import 'package:flutter_formy/flutter_formy.dart';

class ContainsValidator extends FormyValidator {
  final dynamic value;
  ContainsValidator(this.value, {super.message});

  @override
  ValidationResult onValidate(FieldController controller) => ValidationResult(
        key: GenericValidators.contains.name,
        message: message,
        isValid: controller.value != null
            ? controller.value.toString().contains(value.toString())
            : true,
      );
}
