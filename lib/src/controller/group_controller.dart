part of 'field_controller.dart';

class GroupController extends ChangeNotifier {
  factory GroupController({
    required String key,
    required List<FieldConfig> fields,
    List<SubGroupConfig> subGroups = const [],
  }) {
    assert(fields.map((field) => field.key).toSet().length == fields.length,
        'Os keys dos FieldController não podem ser duplicados no GroupControl.');
    assert(!key.contains("/"), 'The key cannot contain "/".');
    final GroupController group =
        GroupController._internal(key, fields, subGroups, [], null);
    group._initSubGroup(subGroups);
    return group;
  }

  GroupController._internal(
    this._key,
    List<FieldConfig> fields,
    List<SubGroupConfig> subGroups,
    List<DependsOn> dependencies,
    this._parentGroup,
  ) {
    _initFields(fields);
    _initDependencies(dependencies);

    _init();
  }

  String _key;
  String get key => _key;
  String get completeKey =>
      _parentGroup == null ? _key : '${_parentGroup!.key}/$_key';
  final Map<String, FieldController> _fields = {};
  final Map<String, GroupController> _subGroups = {};
  final Map<String, String> _fieldsDependencies = {};
  final List<_Dependency> _dependencies = [];
  late GroupState _state;

  GroupController? _parentGroup;
  GroupController? get parentGroup => _parentGroup;

  GroupState get state => _state;

  void _init() {
    _setState();
    _state = _state.copyWith(
        isEnabled:
            _dependencies.every((dep) => dep.enabledWhen(dep.controller)));
  }

  void _initFields(List<FieldConfig> fields) {
    for (FieldConfig config in fields) {
      config.validators.whereType<FormyCrossValidator>().forEach(
            (element) => _fieldsDependencies[element.otherField] = config.key,
          );
      _fields[config.key] = config._initField(
        this,
      );
      _fields[config.key]!.addListener(() => _onFieldChanged(config.key));
    }
  }

  void _initSubGroup(List<SubGroupConfig> listConfig) {
    for (final config in listConfig) {
      _subGroups[config.key] = GroupController._internal(
        config.key,
        config.fields,
        config.subGroups,
        config.dependsOn,
        _parentGroup ?? this,
      );
      _subGroups[config.key]!.addListener(_onGroupStateChanged);
    }
  }

  void _initDependencies(List<DependsOn> dependencies) {
    for (DependsOn dependency in dependencies) {
      final FieldController controller =
          parentGroup!.findFieldByCompleteKey(dependency.fieldKey)!;
      _dependencies.add(_Dependency(
        controller,
        dependency.enabledWhen,
      ));
      controller.addListener(_onDependencyChanged);
    }
  }

  void _onFieldChanged(String fieldKey) {
    if (_fields[_fieldsDependencies[fieldKey]] != null) {}
    _fields[_fieldsDependencies[fieldKey]]?.update(null);
    _onGroupStateChanged();
  }

  void _onGroupStateChanged() {
    final validCount = _validCount();
    if (validCount != state.validCount) {
      _setState();
      debugPrint(
          '\x1B[38;5;43m[FORMY] GroupController: "$completeKey" state has been updated\x1B[0m');
      notifyListeners();
    }
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
      control.removeListener(() => _onFieldChanged(control.key));
      control.dispose();
    }
    for (final dependency in _dependencies) {
      dependency.controller.removeListener(_onDependencyChanged);
    }
    for (final group in _subGroups.values) {
      group.removeListener(_onGroupStateChanged);
      group.dispose();
    }
    super.dispose();
    debugPrint(
        '\x1B[38;5;43m[FORMY] GroupController: "$completeKey" has been \x1B[31mDISPOSED\x1B[0m');
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

  FieldController? findFieldByCompleteKey(String completeKey) {
    final parts = completeKey.split('/');
    if (parts.length == 1) {
      return _fields[parts[0]];
    }
    final head = parts.first;
    final tail = parts.sublist(1).join('/');
    final subGroup = _subGroups[head];
    if (subGroup == null) return null;
    return subGroup.findFieldByCompleteKey(tail);
  }

  GroupController? findSubGroupByCompleteKey(String completeKey) {
    final parts = completeKey.split('/');
    if (parts.isEmpty) return null;

    final head = parts.first;
    final tail = parts.sublist(1).join('/');

    final subGroup = _subGroups[head];
    if (subGroup == null) return null;

    return tail.isEmpty ? subGroup : subGroup.findSubGroupByCompleteKey(tail);
  }

  GroupController subGroup<T>(String subGroupKey) {
    final control = _subGroups[subGroupKey];
    if (control is GroupController) {
      return control;
    }
    throw Exception('SubGroup $subGroupKey not found or type mismatch');
  }

  Map<String, dynamic> getFormData() {
    return {
      for (final entry in _fields.entries) entry.key: entry.value.value,
      for (final entry in _subGroups.entries)
        entry.key: entry.value.getFormData(),
    };
  }

  void setInitialValues() {
    for (final entry in _fields.entries) {
      entry.value._setInitialValue();
    }
  }

  void _setState() {
    _state = GroupState(
      errorMessages: _fieldsErrorMessages(),
      firstErrorField: _firstErrorField(),
      isValid: _fieldsValid() && _subGroupsValid(),
      validCount: _validCount(),
    );
  }

  String? _firstErrorField() {
    for (final entry in _fields.entries) {
      if (!entry.value.valid) return entry.key;
    }
    return null;
  }

  bool get isValid => _state.isValid;
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
