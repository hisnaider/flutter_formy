import 'package:flutter_formy/flutter_formy.dart';

class BetweenValuesValidator extends FormyValidator<num> {
  final num minValue;
  final num maxValue;
  BetweenValuesValidator({
    super.message,
    required this.minValue,
    required this.maxValue,
  });

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.betweenValues.name,
        message: message,
        isValid: controller.value != null
            ? controller.value! >= minValue && controller.value! <= maxValue
            : true,
      );
}
