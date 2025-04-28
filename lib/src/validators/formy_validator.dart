import 'package:flutter_formy/flutter_formy.dart';

abstract class FormyValidator<T> {
  ValidationResult onValidate(FieldController<T> control);

  ValidationResult call(FieldController<T> control) => onValidate(control);

  final FormManager formManager = FormManager();
}
