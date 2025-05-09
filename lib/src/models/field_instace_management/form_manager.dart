import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/additional_listener.dart';
import 'package:flutter_formy/src/models/group_state.dart';

part 'formy_selector.dart';
part 'formy_builder.dart';

class FormManager {
  static final FormManager _instance = FormManager._();
  factory FormManager() => _instance;
  FormManager._();

  final Map<int, FieldController<dynamic>> _fields = {};
  final Map<int, int> _fieldCountRef = {};
  final Map<String, GroupController> _groups = {};
  final Map<String, int> _groupCountRef = {};

  static FormManager get instance => _instance;

  UnmodifiableMapView<int, FieldController<dynamic>> get fields =>
      UnmodifiableMapView(_fields);

  UnmodifiableMapView<String, GroupController> get groups =>
      UnmodifiableMapView(_groups);

  FieldController? getField({required String key}) {
    final List<String> keyParts = key.split("/");
    if (keyParts.length > 1) {
      final group = _groups[keyParts[0]];
      return group?.field(keyParts[1]);
    }
    for (FieldController field in _fields.values) {
      if (field.completeKey == key) return field;
    }
    return null;
  }

  GroupController? getGroup(String key) {
    final group = _groups[key];
    if (group is GroupController) {
      return group;
    }
    return null;
  }

  FieldController? getClosestField(String key, int referenceId) {
    final List<FieldController> fieldsFound =
        _fields.values.where((e) => e.completeKey == key).toList();
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

  bool groupsAreValid(List<String> groupsKey) {
    for (final id in groupsKey) {
      final group = _groups[id];
      if (group == null || !group.state.isValid) return false;
    }
    return true;
  }

  /// Insere um [FieldController] independente no formulário.
  /// Campos pertencentes a grupos (com key no formato "grupo/campo") serão ignorados.
  void _insertField(FieldController field) {
    if (_isInsideGroup(field.completeKey)) return;
    _fieldCountRef[field.id] = 1 + (_fieldCountRef[field.id] ?? 0);
    if (!field.completeKey.contains("/")) {
      _fields[field.id] = field;
      _debugLog('Field "${field.completeKey}" has been \x1B[32mCREATED\x1B[0m');
    }
    _debugLog(
        'Field "${field.completeKey}" ref count: ${_fieldCountRef[field.id]}');
  }

  /// Insere um grupo de campos identificado por [GroupController.key].
  /// Se já houver um grupo com a mesma key, o `_groupCountRef` referente a esse group sera crementado.
  void _insertGroup(GroupController group) {
    if (_isInsideGroup(group.key)) return;
    _groupCountRef[group.key] = 1 + (_groupCountRef[group.key] ?? 0);
    if (!_groups.containsKey(group.key)) {
      _groups[group.key] = group;
      _debugLog('Group "${group.key}" has been \x1B[32mCREATED\x1B[0m');
    }
    _debugLog('Group "${group.key}" ref count: ${_groupCountRef[group.key]}');
  }

  void _removeField(FieldController field) {
    if (_isInsideGroup(field.completeKey)) return;
    if (_fieldCountRef[field.id] != null && _fieldCountRef[field.id]! > 1) {
      _fieldCountRef[field.id] = _fieldCountRef[field.id]! - 1;
    } else {
      _fields.remove(field.id);
      _fieldCountRef.remove(field.id);
      _debugLog('Field "${field.completeKey}" has been \x1B[31mREMOVED\x1B[0m');
    }

    _debugLog(
        'Field "${field.completeKey}" ref count: ${_fieldCountRef[field.id] ?? '\x1B[31mDELETED\x1B[0m'}');

    if (!field.completeKey.contains("/")) {
      _fields.removeWhere((key, value) => key == field.id);
    }
  }

  void _removeGroup(GroupController group) {
    if (_isInsideGroup(group.key)) return;
    if (_groupCountRef[group.key] != null && _groupCountRef[group.key]! > 1) {
      _groupCountRef[group.key] = _groupCountRef[group.key]! - 1;
    } else {
      _groups.remove(group.key);
      _groupCountRef.remove(group.key);
      _debugLog('Group "${group.key}" has been \x1B[31mREMOVED\x1B[0m');
    }

    _debugLog(
        'Group "${group.key}" ref count: ${_groupCountRef[group.key] ?? '\x1B[31mDELETED\x1B[0m'}');
  }

  void _debugLog(String message) {
    debugPrint('\x1B[38;5;43m[FORMY] FormManager: $message\x1B[0m');
  }

  bool _isInsideGroup(String key) => key.contains("/");
}
