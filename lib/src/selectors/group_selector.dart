import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/form_manager.dart';
import 'package:flutter_formy/src/models/controller/field_controller.dart';
import 'package:flutter_formy/src/selectors/formy_selector.dart';

class GroupSelector<T> extends FormySelector<GroupController, T> {
  const GroupSelector({
    super.key,
    required super.controller,
    required super.selector,
    required super.child,
  });

  @override
  State<GroupSelector<T>> createState() => _GroupSelectorState<T>();
}

class _GroupSelectorState<T>
    extends FormySelectorState<GroupController, T, GroupSelector<T>> {
  @override
  void addListener() {
    widget.controller.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.controller.removeListener(triggerUpdate);
  }
}
