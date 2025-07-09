import 'package:flutter_formy/flutter_formy.dart';

class UrlValidator extends FormyValidator<String> {
  UrlValidator({super.message});

  final RegExp _pattern =
      RegExp(r'^(https?:\/\/)?([\w\-]+\.)+[a-z]{2,6}(\/\S*)?$');

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
        key: GenericValidators.url.name,
        message: message,
        isValid: controller.value != null
            ? _pattern.hasMatch(controller.value!)
            : true,
      );
}
