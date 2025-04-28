part of 'field_controller.dart';

class GroupController extends ChangeNotifier {
  GroupController({
    required this.key,
    required List<FieldController<dynamic>> fields,
  }) : assert(fields.map((field) => field.key).toSet().length == fields.length,
            'Os keys dos FieldControl não podem ser duplicados no GroupControl.') {
    _fields = {};
    for (FieldController<dynamic> i in fields) {
      i._putInGroup(key);
      _fields[i._key] = i;
    }
    init();
  }
  final String key;
  late final Map<String, FieldController> _fields;
  late GroupState _state;

  GroupState get state => _state;
  Map<String, dynamic> get values =>
      _fields.map((key, value) => MapEntry(key, value.value));

  void init() {
    print("_fields: ${_fields["teste/email"]?.valid}}");
    _registerListeners();
    _setState();
  }

  void _registerListeners() {
    for (final control in _fields.values) {
      control.addListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    final validCount = _validFieldCount();
    if (validCount != state.validCount) {
      _setState();
      debugPrint('[GroupControl] Estado do grupo atualizado.');
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
      e.markAsTouched();
    }
  }

  void resetAll() {
    for (final field in _fields.values) {
      field.reset();
    }
  }

  List<FieldController> getAllFields() {
    return _fields.values.toList();
  }

  FieldController<T> field<T>(String fieldKey) {
    final control = _fields["$key/$fieldKey"];
    if (control is FieldController<T>) {
      return control;
    }
    throw Exception('Field $fieldKey not found or type mismatch');
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
