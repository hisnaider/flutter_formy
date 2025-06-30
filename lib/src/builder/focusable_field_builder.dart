part of '../models/field_instace_management/form_manager.dart';

typedef FocusableFieldWidgetBuilder<T> = Widget Function(
  BuildContext context,
  FieldController<T> field,
  FocusNode focusNode,
  Widget? child,
);

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

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.field, _focusNode, widget.child);
  }
}
