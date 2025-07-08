import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/validators/formy_cross_validator.dart';

class MustMatchValidator extends FormyCrossValidator<String> {
  MustMatchValidator({required super.otherField, super.message});
  @override
  ValidationResult onValidate(FieldController controller) {
    bool isValid = true;
    if (controller.value != null && controller.value!.isNotEmpty) {
      isValid = controller.value == otherController.value;
    }
    return ValidationResult(
      key: GenericValidators.mustMatch.name,
      message: message,
      isValid: isValid,
    );
  }
}
