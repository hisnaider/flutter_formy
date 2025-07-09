import 'package:flutter_formy/flutter_formy.dart';

class AfterDateValidator extends FormyValidator<DateTime> {
  final DateTime date;
  AfterDateValidator(this.date, {super.message});
  @override
  ValidationResult onValidate(FieldController<DateTime> controller) =>
      ValidationResult(
        key: GenericValidators.afterDate.name,
        message: message,
        isValid:
            controller.value != null ? controller.value!.isAfter(date) : true,
      );
}
