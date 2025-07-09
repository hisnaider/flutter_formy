import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/validators/formy_cross_validator.dart';

class MustNotMatchValidator<T> extends FormyCrossValidator<T> {
  MustNotMatchValidator({required super.otherField, super.message});
  @override
  ValidationResult onValidate(FieldController<T> controller) =>
      ValidationResult(
        key: GenericValidators.mustNotMatch.name,
        message: message,
        isValid: controller.value != null
            ? controller.value != otherController.value
            : true,
      );
}
