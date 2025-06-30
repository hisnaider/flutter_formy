part of '../models/field_instace_management/form_manager.dart';

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

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.field, widget.child);
  }
}
