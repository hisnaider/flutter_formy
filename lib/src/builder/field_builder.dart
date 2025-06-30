part of '../models/field_instace_management/form_manager.dart';

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

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.field, widget.child);
  }
}
