import 'package:flutter/foundation.dart';
import 'package:flutter_formy/src/extensions/field_control_extensions.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/field_state.dart';

class GroupFields extends ChangeNotifier {
  GroupFields({
    required this.groupId,
    required List<FieldControl<dynamic>> fields,
  })  : assert(fields.map((field) => field.key).toSet().length == fields.length,
            'Os keys dos FieldControl não podem ser duplicados no GroupFields.'),
        _fields = {for (FieldControl<dynamic> i in fields) i.key: i} {
    _registerListeners();
  }
  final String groupId;
  final Map<String, FieldControl> _fields;

  bool get isValid => _fields.values.every((field) => field.valid);
  bool _lastIsValid = false;

  void _registerListeners() {
    for (final control in _fields.values) {
      control.addListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    final currentIsValid = isValid;
    if (currentIsValid != _lastIsValid) {
      _lastIsValid = currentIsValid;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    for (final control in _fields.values) {
      control.removeListener(_onFieldChanged);
    }
    super.dispose();
  }

  void validateAllFields() {
    for (var e in _fields.values) {
      e.validate();
    }
  }

  void updateAField<T>(String key, T value) {
    _fields[key]?.update(value);
  }

  void resetAll() {
    for (final field in _fields.values) {
      field.reset();
    }
  }

  void touchAllFields() {
    for (final field in _fields.values) {
      field.touch();
    }
  }

  void addNewField(FieldControl field) {
    _fields[field.key] = field;
  }

  void removeField(String key) {
    _fields.remove(key);
  }

  List<FieldControl> getAllFields() {
    return _fields.values.toList();
  }

  FieldControl<T> field<T>(String key) {
    final control = _fields[key];
    if (control is FieldControl<T>) {
      return control;
    }
    throw Exception('Field $key not found or type mismatch');
  }

  Map<String, dynamic> getFormData() =>
      _fields.map((key, value) => MapEntry(key, value.state.value));
}

extension FieldGroupX<T> on GroupFields {
  Map<String, dynamic> get values =>
      _fields.map((key, value) => MapEntry(key, value.value));
  List<String> get errorMessages => _fields.values
      .map((field) => field.errorMessages)
      .expand((messages) => messages)
      .toList();

  bool get isTouched => _fields.values.any((field) => field.touched);
  bool get isDirty => _fields.values.any((field) => field.dirty);

  Map<String, FieldState> get fieldsState =>
      _fields.map((key, value) => MapEntry(key, value.state));
}
