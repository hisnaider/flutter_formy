import 'package:flutter_formy/flutter_formy.dart';

class BetweenDatesValidator extends FormyValidator<DateTime> {
  final DateTime minDate;
  final DateTime maxDate;
  BetweenDatesValidator(
      {required this.minDate, required this.maxDate, super.message});
  @override
  ValidationResult onValidate(FieldController<DateTime> controller) =>
      ValidationResult(
        key: GenericValidators.betweenDates.name,
        message: message,
        isValid: controller.value != null
            ? (controller.value!.isAfter(minDate) ||
                    controller.value!.isAtSameMomentAs(minDate)) &&
                (controller.value!.isBefore(maxDate) ||
                    controller.value!.isAtSameMomentAs(maxDate))
            : true,
      );
}
