part of 'form_manager.dart';

abstract class FormyBuilder<Controller, StateType> extends StatefulWidget {
  const FormyBuilder({
    super.key,
    required this.field,
    this.buildWhen,
    this.child,
  });

  ///The [FieldController] that this widget will watch.
  final Controller field;

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
    if (widget.field is FieldController) {
      _FormManager._instance.insertField(widget.field as FieldController);
    } else if (widget.field is GroupController) {
      _FormManager._instance.insertGroup(widget.field as GroupController);
    }
    addListener();
  }

  void addListener();
  void removeListener();

  @override
  void dispose() {
    removeListener();
    if (widget.field is FieldController) {
      _FormManager._instance.removeField(widget.field as FieldController);
    } else if (widget.field is GroupController) {
      _FormManager._instance.removeGroup(widget.field as GroupController);
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
