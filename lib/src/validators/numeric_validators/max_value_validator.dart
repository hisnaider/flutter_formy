import 'package:flutter_formy/flutter_formy.dart';

class MaxValueValidator extends FormyValidator<num> {
  final num maxValue;
  MaxValueValidator(this.maxValue, {super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.maxValue.name,
        message: message,
        isValid: controller.value != null ? controller.value! < maxValue : true,
      );
}
