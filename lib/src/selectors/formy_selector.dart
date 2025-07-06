import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/form_manager.dart';
import 'package:flutter_formy/src/models/controller/field_controller.dart';

abstract class FormySelector<Control, Value> extends StatefulWidget {
  const FormySelector({
    super.key,
    required this.controller,
    required this.selector,
    required this.child,
  });

  final Control controller;
  final Value Function(Control value) selector;
  final Widget Function(Value value) child;
}

abstract class FormySelectorState<TValue, TSelected,
    TWidget extends FormySelector<TValue, TSelected>> extends State<TWidget> {
  late TSelected _value;

  @override
  void initState() {
    super.initState();
    _value = widget.selector(widget.controller);
    if (widget.controller is FieldController) {
      FormyFormManager.instance
          .insertField(widget.controller as FieldController);
    } else if (widget.controller is GroupController) {
      FormyFormManager.instance
          .insertGroup(widget.controller as GroupController);
    }
    addListener();
  }

  void addListener();
  void removeListener();

  void _onChanged() {
    final newValue = widget.selector(widget.controller);
    if (newValue != _value) {
      setState(() {
        _value = newValue;
      });
    }
  }

  @override
  void dispose() {
    removeListener();
    if (widget.controller is FieldController) {
      FormyFormManager.instance
          .removeField(widget.controller as FieldController);
    } else if (widget.controller is GroupController) {
      FormyFormManager.instance
          .removeGroup(widget.controller as GroupController);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child(_value);
  }

  void triggerUpdate() => _onChanged();
}
