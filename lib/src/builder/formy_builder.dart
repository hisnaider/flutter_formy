import 'package:flutter/material.dart';
import 'package:flutter_formy/src/manager/form_manager.dart';
import 'package:flutter_formy/src/models/controller/field_controller.dart';

abstract class FormyBuilder<Controller, StateType> extends StatefulWidget {
  const FormyBuilder({
    super.key,
    required this.controller,
    this.buildWhen,
    this.child,
  });

  ///The [FieldController] that this widget will watch.
  final Controller controller;

  ///An optional function that returns `true` if the widget should rebuild.
  final bool Function(StateType oldState, StateType currentState)? buildWhen;

  ///A static widget that will not be rebuilt when the field state changes.
  final Widget? child;
}

abstract class FormyBuilderState<TController, TStateType,
        TWidget extends FormyBuilder<TController, TStateType>>
    extends State<TWidget> {
  late TStateType oldState;

  @override
  void initState() {
    super.initState();
    oldState = getState();
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
  Widget build(BuildContext context);

  void _onChanged() {
    final shouldBuild = widget.buildWhen?.call(oldState, getState()) ?? true;
    if (shouldBuild) {
      setState(() {
        oldState = getState();
      });
    }
  }

  void triggerUpdate() => _onChanged();

  TStateType getState();
}
