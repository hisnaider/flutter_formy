part of '../models/field_instace_management/form_manager.dart';

abstract class FormyBuilder<Controller, StateType> extends StatefulWidget {
  const FormyBuilder({
    super.key,
    required this.field,
    this.buildWhen,
    this.child,
  });

  final Controller field;
  final bool Function(StateType oldState, StateType currentState)? buildWhen;

  final Widget? child;

  void insertIntoFormManager();
  void removeFromFormManager();
}

abstract class FormyBuilderState<TController, TStateType,
        TWidget extends FormyBuilder<TController, TStateType>>
    extends State<TWidget> {
  late TStateType oldState;

  @override
  void initState() {
    super.initState();
    oldState = getState();
    widget.insertIntoFormManager();
    addListener();
  }

  void addListener();
  void removeListener();

  @override
  void dispose() {
    removeListener();
    widget.removeFromFormManager();
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
