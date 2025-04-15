import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/group_fields.dart';

class FormManager {
  static final FormManager _instance = FormManager._();
  factory FormManager() => _instance;
  FormManager._();

  final Map<int, FieldControl<dynamic>> _fields = {};
  final Map<String, GroupFields> _groups = {};
  Map<int, FieldControl<dynamic>> get fields => _fields;
  Map<String, GroupFields> get groups => _groups;

  void insertField(FieldControl field, {String? groupKey}) {
    if (groupKey != null) {
      if (_groups[groupKey] == null) {
        _insertGroup(GroupFields(groupId: groupKey, fields: [field]));
        return;
      }
      _groups[groupKey]!.addNewField(field);
      return;
    }
    _fields[field.id] = field;
  }

  void _insertGroup(GroupFields group) {
    _groups[group.groupId] = group;
  }

  FieldControl? getField({required String key, String? groupId}) {
    if (groupId != null) return _getFieldOfGroup(key, groupId);
    for (FieldControl field in fields.values) {
      if (field.key == key) return field;
    }

    for (final group in _groups.values) {
      for (final field in group.getAllFields()) {
        if (field.key == key) {
          return field;
        }
      }
    }
    return null;
  }

  FieldControl? _getFieldOfGroup(String key, String groupId) {
    if (_groups[groupId] == null) return null;
    for (FieldControl i in _groups[groupId]!.getAllFields()) {
      if (i.key == key) return i;
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

  void removeField(FieldControl field) {
    for (GroupFields groups in _groups.values) {
      groups.removeField(field.key);
    }
    _fields.remove(field.id);
  }

  void removeGroup(String groupId) {
    _groups.remove(groupId);
  }

  bool isGroupValid(String groupId) {
    final group = _groups[groupId];
    if (group == null) return false;
    return group.isValid;
  }

  bool groupsAreValid(List<String> groupsId) {
    for (final id in groupsId) {
      final group = _groups[id];
      if (group == null) {
        return false;
      }
      if (!group.isValid) return false;
    }
    return true;
  }
}
