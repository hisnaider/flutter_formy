import 'dart:collection';

import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/group_fields.dart';

class FormManager {
  static final FormManager _instance = FormManager._();
  factory FormManager() => _instance;
  FormManager._();

  final Map<int, FieldControl<dynamic>> _fields = {};
  final Map<String, GroupFields> _groups = {};
  static FormManager get instance => _instance;

  UnmodifiableMapView<int, FieldControl<dynamic>> get fields =>
      UnmodifiableMapView(_fields);

  UnmodifiableMapView<String, GroupFields> get groups =>
      UnmodifiableMapView(_groups);

  /// Insere um [FieldControl] independente no formulário.
  /// Campos pertencentes a grupos (com key no formato "grupo/campo") serão ignorados.
  void insertField(FieldControl field) {
    if (field.key.contains("/")) {
      throw 'Campos de grupos devem ser gerenciados via GroupFields e não diretamente no FormManager. Se for um campo independente, tiro o "/" da key';
    }
    _fields[field.id] = field;
  }

  /// Insere um grupo de campos identificado por [GroupFields.groupKey].
  /// Se já houver um grupo com a mesma key, um `assert` será disparado em debug.
  void insertGroup(GroupFields group) {
    if (_groups.containsKey(group.groupKey)) {
      assert(false, 'Já existe um grupo com a key "${group.groupKey}"');
      return;
    }
    _groups[group.groupKey] = group;
  }

  FieldControl? getField({required String key}) {
    final List<String> keyParts = key.split("/");
    if (keyParts.length > 1) {
      final group = _groups[keyParts[0]];
      return group?.field(keyParts[1]);
    }
    for (FieldControl field in _fields.values) {
      if (field.key == key) return field;
    }
    return null;
  }

  GroupFields? getGroupFields(String key) {
    final group = _groups[key];
    if (group is GroupFields) {
      return group;
    }
    return null;
  }

  FieldControl? getClosestField(String key, int referenceId) {
    final List<FieldControl> fieldsFound =
        _fields.values.where((e) => e.key == key).toList();
    if (fieldsFound.isEmpty) {
      return null;
    }
    if (fieldsFound.length == 1) {
      return fieldsFound.first;
    }
    fieldsFound.sort((a, b) =>
        (a.id - referenceId).abs().compareTo((b.id - referenceId).abs()));

    return fieldsFound.first;
  }

  void removeField(FieldControl control) {
    _fields.removeWhere((key, value) => key == control.id);
  }

  void removeGroup(GroupFields group) {
    _groups.removeWhere((key, value) => key == group.groupKey);
  }

  bool groupsAreValid(List<String> groupsKey) {
    for (final id in groupsKey) {
      final group = _groups[id];
      if (group == null || !group.state.isValid) return false;
    }
    return true;
  }
}
