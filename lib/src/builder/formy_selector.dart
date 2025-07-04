part of 'form_manager.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child(_value);
  }

  void triggerUpdate() => _onChanged();
}

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
    _FormyFormManager._instance.insertGroup(widget.controller);
    widget.controller.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.controller.removeListener(triggerUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _FormyFormManager._instance.removeGroup(widget.controller);
  }
}

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
    _FormyFormManager._instance.insertField(widget.controller);
    widget.controller.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.controller.removeListener(triggerUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _FormyFormManager._instance.removeField(widget.controller);
  }
}
