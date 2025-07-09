import 'package:flutter_formy/flutter_formy.dart';

class MinValueValidator extends FormyValidator<num> {
  final num minValue;
  MinValueValidator(this.minValue, {super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.minValue.name,
        message: message,
        isValid: controller.value != null ? controller.value! > minValue : true,
      );
}
