import 'package:flutter/foundation.dart';
import 'package:flutter_formy/src/extensions/field_control_extensions.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/group_state.dart';

class GroupFields extends ChangeNotifier {
  GroupFields({
    required this.groupKey,
    required List<FieldControl<dynamic>> fields,
  })  : assert(fields.map((field) => field.key).toSet().length == fields.length,
            'Os keys dos FieldControl não podem ser duplicados no GroupFields.'),
        _fields = {for (FieldControl<dynamic> i in fields) i.key: i} {
    _registerListeners();
    _setState();
  }
  final String groupKey;
  final Map<String, FieldControl> _fields;
  late GroupState _state;

  GroupState get state => _state;
  Map<String, dynamic> get values =>
      _fields.map((key, value) => MapEntry(key, value.value));

  void _registerListeners() {
    for (final control in _fields.values) {
      control.addListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    final currentErrorMessages = _fieldsErrorMessages();
    if (!listEquals(currentErrorMessages, _state.errorMessages)) {
      _setState();
      debugPrint('[GroupFields] Estado do grupo atualizado.');
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

  void touchAndValidateAllFields() {
    for (var e in _fields.values) {
      e.update(touched: true);
    }
  }

  void resetAll() {
    for (final field in _fields.values) {
      field.reset();
    }
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

  void _setState() {
    _state = GroupState(
      errorMessages: _fieldsErrorMessages(),
      firstErrorFieldKey: _firstErrorFieldKey(),
      isValid: _allFieldsAreValid(),
      validCount: _validFieldCount(),
    );
  }

  String? _firstErrorFieldKey() {
    for (final entry in _fields.entries) {
      if (!entry.value.valid) return entry.key;
    }
    return null;
  }

  bool _allFieldsAreValid() => _fields.values.every((field) => field.valid);
  int _validFieldCount() => _fields.values.where((e) => e.valid).length;
  List<String> _fieldsErrorMessages() => _fields.values
      .map((field) => field.errorKeys)
      .expand((messages) => messages)
      .toList();
}
