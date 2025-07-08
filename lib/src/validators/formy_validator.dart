import 'package:flutter_formy/flutter_formy.dart';

abstract class FormyValidator<T> {
  FormyValidator({required this.message});
  final String? message;
  ValidationResult onValidate(FieldController<T> controller);

  ValidationResult call(FieldController<T> controller) =>
      onValidate(controller);
}
