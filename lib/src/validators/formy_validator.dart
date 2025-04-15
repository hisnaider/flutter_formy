import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/services/form_manager.dart';

abstract class FormyValidator<T> {
  ValidationResult onValidate(FieldControl<T> control);

  ValidationResult call(FieldControl<T> control) => onValidate(control);

  final FormManager formManager = FormManager();
}
