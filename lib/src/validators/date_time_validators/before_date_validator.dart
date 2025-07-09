import 'package:flutter_formy/flutter_formy.dart';

class BeforeValidator extends FormyValidator<DateTime> {
  final DateTime date;
  BeforeValidator(this.date, {super.message});
  @override
  ValidationResult onValidate(FieldController<DateTime> controller) =>
      ValidationResult(
        key: GenericValidators.beforeDate.name,
        message: message,
        isValid:
            controller.value != null ? controller.value!.isBefore(date) : true,
      );
}
