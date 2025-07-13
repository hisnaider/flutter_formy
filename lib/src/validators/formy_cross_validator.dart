import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/flutter_formy_validators.dart';

abstract class FormyCrossValidator<T> extends FormyValidator<T> {
  FormyCrossValidator({
    required super.message,
    required this.otherField,
  });
  final String otherField;
  FieldController? _otherController;

  FieldController get otherController => _otherController!;

  @override
  ValidationResult onValidate(FieldController<T> controller);

  @override
  ValidationResult call(FieldController<T> controller) {
    if (_otherController == null) _cachedOtherController(controller.groupRef);
    return onValidate(controller);
  }

  void _cachedOtherController(GroupController? groupRef) {
    if (groupRef == null) {
      throw Exception('Validator requires the field to belong to a group.');
    }
    final FieldController other = groupRef.field(otherField);
    _otherController = other;
  }
}
