import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/form_manager.dart';
import 'package:flutter_formy/src/models/controller/field_controller.dart';
import 'package:flutter_formy/src/selectors/formy_selector.dart';

class FieldSelector<T> extends FormySelector<FieldController, T> {
  const FieldSelector({
    super.key,
    required super.controller,
    required super.selector,
    required super.child,
  });

  @override
  State<FieldSelector<T>> createState() => _FieldSelectorState<T>();
}

class _FieldSelectorState<T>
    extends FormySelectorState<FieldController, T, FieldSelector<T>> {
  @override
  void addListener() {
    widget.controller.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.controller.removeListener(triggerUpdate);
  }
}
