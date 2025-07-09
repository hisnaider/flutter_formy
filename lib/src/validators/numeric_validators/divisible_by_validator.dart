import 'package:flutter_formy/flutter_formy.dart';

class DivisibleByValidator extends FormyValidator<num> {
  final int denominator;
  DivisibleByValidator(this.denominator, {super.message});

  @override
  ValidationResult onValidate(FieldController<num> controller) =>
      ValidationResult(
        key: GenericValidators.divisibleBy.name,
        message: message,
        isValid: (controller.value ?? denominator) % denominator == 0,
      );
}
