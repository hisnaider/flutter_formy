part of 'form_manager.dart';

typedef FocusableFieldWidgetBuilder<T> = Widget Function(
  BuildContext context,
  FieldController<T> field,
  FocusNode focusNode,
  Widget? child,
);

abstract class FormyBuilder<Controller, StateType> extends StatefulWidget {
  const FormyBuilder({
    super.key,
    required this.field,
    this.buildWhen,
    this.child,
  });

  final Controller field;
  final bool Function(StateType oldState, StateType currentState)? buildWhen;

  Widget formyBuilder(BuildContext context, Controller field, Widget? child);
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
  Widget build(BuildContext context) {
    return widget.formyBuilder(context, widget.field, widget.child);
  }

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

class FieldBuilder<T> extends FormyBuilder<FieldController<T>, FieldState<T>> {
  const FieldBuilder({
    super.key,
    required super.field,
    super.buildWhen,
    super.child,
    required this.builder,
  });

  final Widget Function(
      BuildContext context, FieldController<T> field, Widget? child) builder;

  @override
  State<StatefulWidget> createState() => _FieldBuilder<T>();

  @override
  void insertIntoFormManager() {
    FormManager.instance.insertField(field);
  }

  @override
  void removeFromFormManager() {
    FormManager.instance._removeField(field);
  }

  @override
  Widget formyBuilder(
          BuildContext context, FieldController<T> field, Widget? child) =>
      builder(context, field, child);
}

class _FieldBuilder<T>
    extends FormyBuilderState<FieldController, FieldState<T>, FieldBuilder<T>> {
  @override
  void addListener() {
    widget.field.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.field.removeListener(triggerUpdate);
  }

  @override
  FieldState<T> getState() => widget.field.state;
}

class FocusableFieldBuilder<T>
    extends FormyBuilder<FieldController<T>, FieldState<T>> {
  const FocusableFieldBuilder({
    super.key,
    required super.field,
    super.buildWhen,
    super.child,
    this.focusNode,
    required this.builder,
  });

  final FocusableFieldWidgetBuilder<T> builder;

  final FocusNode? focusNode;
  @override
  State<StatefulWidget> createState() => _FocusableFieldBuilder<T>();

  @override
  void insertIntoFormManager() {
    FormManager.instance.insertField(field);
  }

  @override
  void removeFromFormManager() {
    FormManager.instance._removeField(field);
  }

  @override
  Widget formyBuilder(
          BuildContext context, FieldController<T> field, Widget? child) =>
      builder(context, field, focusNode ?? FocusNode(), child);
}

class _FocusableFieldBuilder<T> extends FormyBuilderState<FieldController<T>,
    FieldState<T>, FocusableFieldBuilder<T>> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      widget.field.markAsTouched();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  FieldState<T> getState() => widget.field.state;

  @override
  void addListener() {
    widget.field.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.field.removeListener(triggerUpdate);
  }
}

class GroupBuilder extends FormyBuilder<GroupController, GroupState> {
  const GroupBuilder(
      {super.key,
      required super.field,
      super.buildWhen,
      super.child,
      required this.builder});

  final Widget Function(
      BuildContext context, GroupController group, Widget? child) builder;

  @override
  State<StatefulWidget> createState() => _GroupBuilder();

  @override
  void insertIntoFormManager() {
    FormManager.instance.insertGroup(field);
  }

  @override
  void removeFromFormManager() {
    FormManager.instance._removeGroup(field);
  }

  @override
  Widget formyBuilder(
          BuildContext context, GroupController field, Widget? child) =>
      builder(context, field, child);
}

class _GroupBuilder
    extends FormyBuilderState<GroupController, GroupState, GroupBuilder> {
  @override
  void addListener() {
    widget.field.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.field.removeListener(triggerUpdate);
  }

  @override
  GroupState getState() => widget.field.state;
}
