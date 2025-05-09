part of 'field_controller.dart';

class GroupController extends ChangeNotifier {
  GroupController({
    required this.key,
    required List<FieldController> fields,
    List<SubGroupConfig> subGroups = const [],
  })  : assert(
            fields.map((field) => field.completeKey).toSet().length ==
                fields.length,
            'Os keys dos FieldController não podem ser duplicados no GroupControl.'),
        assert(!key.contains("/"), 'The key cannot contain "/".') {
    for (FieldController<dynamic> i in fields) {
      i._putInGroup(key);
      _fields[i._key] = i;
    }
    _initSubGroup(subGroups);
    _init();
  }
  String key;
  final Map<String, FieldController> _fields = {};
  final Map<String, GroupController> _subGroups = {};
  final List<_Dependency> _dependencies = [];
  late GroupState _state;

  GroupState get state => _state;
  Map<String, dynamic> get values =>
      _fields.map((key, value) => MapEntry(key, value.value));

  void _init() {
    _registerFieldListeners();
    _setState();
    _state = _state.copyWith(
        isEnabled:
            _dependencies.every((dep) => dep.enabledWhen(dep.controller)));
  }

  void _initSubGroup(List<SubGroupConfig> listConfig) {
    for (final config in listConfig) {
      final GroupController groupController = GroupController(
        key: config.key,
        fields: config.fields,
      ).._putInGroup(key);
      for (final dependency in config.dependsOn) {
        groupController._addDependency(
            field(dependency.fieldKey), dependency.enabledWhen);
        groupController._state = groupController.state.copyWith(
            isEnabled: dependency.enabledWhen(field(dependency.fieldKey)));
      }
      _subGroups[config.key] = groupController;
      _subGroups[config.key]!.addListener(_onFieldChanged);
    }
  }

  void _putInGroup(String fatherKey) {
    key = '$fatherKey/$key';
  }

  void _registerFieldListeners() {
    for (final control in _fields.values) {
      control.addListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    final validCount = _validCount();
    if (validCount != state.validCount) {
      _setState();
      debugPrint('[GroupControl] Estado do grupo atualizado.');
      notifyListeners();
    }
  }

  void _addDependency(
      FieldController controller, bool Function(FieldController) enabledWhen) {
    _state = _state.copyWith(
        isEnabled:
            _dependencies.every((dep) => dep.enabledWhen(dep.controller)));
    _dependencies.add(_Dependency(controller, enabledWhen));
    controller.addListener(_onDependencyChanged);
  }

  void _onDependencyChanged() {
    final isEnabled =
        _dependencies.every((dep) => dep.enabledWhen(dep.controller));
    if (isEnabled != state.isEnabled) {
      if (!isEnabled) resetAll();
      _state = _state.copyWith(isEnabled: isEnabled);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    for (final control in _fields.values) {
      control.removeListener(_onFieldChanged);
    }
    for (final dependency in _dependencies) {
      dependency.controller.removeListener(_onDependencyChanged);
    }
    for (final group in _subGroups.values) {
      group.removeListener(_onFieldChanged);
      group.dispose();
    }
    super.dispose();
  }

  void touchAndValidateAllFields() {
    for (var e in _fields.values) {
      e.markAsTouched();
    }
    for (var g in _subGroups.values) {
      g.touchAndValidateAllFields();
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
    final control = _fields[fieldKey];
    if (control is FieldController<T>) {
      return control;
    }
    throw Exception('Field $fieldKey not found or type mismatch');
  }

  GroupController subGroup<T>(String subGroupKey) {
    final control = _subGroups[subGroupKey];
    if (control is GroupController) {
      return control;
    }
    throw Exception('SubGroup $subGroupKey not found or type mismatch');
  }

  Map<String, dynamic> getFormData() {
    print(_subGroups.values.map((e) => e._state));
    return {
      for (final entry in _fields.entries) entry.key: entry.value.value,
      for (final entry in _subGroups.entries)
        entry.key: entry.value.getFormData(),
    };
  }

  void _setState() {
    _state = GroupState(
      errorMessages: _fieldsErrorMessages(),
      firstErrorFieldKey: _firstErrorFieldKey(),
      isValid: _fieldsValid() && _subGroupsValid(),
      validCount: _validCount(),
    );
  }

  String? _firstErrorFieldKey() {
    for (final entry in _fields.entries) {
      if (!entry.value.valid) return entry.key;
    }
    return null;
  }

  bool _fieldsValid() => _fields.values.every((field) => field.valid);
  bool _subGroupsValid() =>
      _subGroups.values.every((e) => e.state.isValid || !e.state.isEnabled);
  int _validCount() =>
      _fields.values.where((e) => e.valid).length +
      _subGroups.values
          .where((e) => e.state.isValid || !e.state.isEnabled)
          .length;
  List<String> _fieldsErrorMessages() => _fields.values
      .map((field) => field.errorKeys)
      .expand((messages) => messages)
      .toList();
}

class _Dependency {
  final FieldController controller;
  final bool Function(FieldController) enabledWhen;

  _Dependency(this.controller, this.enabledWhen);
}

class SubGroupConfig {
  SubGroupConfig({
    required this.key,
    this.dependsOn = const [],
    required this.fields,
  });
  final String key;
  final List<DependsOn> dependsOn;
  final List<FieldController> fields;
}

class DependsOn {
  const DependsOn({
    required this.fieldKey,
    required this.enabledWhen,
  });
  final String fieldKey;
  final bool Function(FieldController controller) enabledWhen;
}
