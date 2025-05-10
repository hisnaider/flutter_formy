import 'package:flutter_formy/flutter_formy.dart';

class MustMatchValidator extends FormyValidator<String> {
  MustMatchValidator({required this.otherController});
  final String otherController;
  @override
  ValidationResult onValidate(FieldController control) {
    bool isValid = true;
    if (control.value != null && control.value!.isNotEmpty) {
      isValid = control.value == control.groupRef?.field(otherController).value;
      control.groupRef?.field(otherController).update(null);
    }
    return ValidationResult(
      key: GenericValidators.mustMatch.name,
      isValid: isValid,
    );
  }
}
