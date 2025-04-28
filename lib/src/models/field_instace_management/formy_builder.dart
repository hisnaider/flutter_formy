part of 'form_manager.dart';

abstract class FormyBuilder<Controller, StateType> extends StatefulWidget {
  const FormyBuilder(
      {super.key,
      required this.field,
      this.buildWhen,
      required this.builder,
      this.child,
      this.aditionalListener = const []});

  final List<AdditionalListener> aditionalListener;

  final Controller field;
  final bool Function(StateType oldState, StateType currentState)? buildWhen;
  final Widget Function(BuildContext context, Controller field, Widget? child,
      List<AdditionalListener> listeners) builder;
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
    return widget.builder(
        context, widget.field, widget.child, widget.aditionalListener);
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

class FieldBuilder<T>
    extends FormyBuilder<FieldController<dynamic>, FieldState<dynamic>> {
  const FieldBuilder(
      {super.key,
      required super.field,
      super.buildWhen,
      super.child,
      required super.builder,
      super.aditionalListener});

  @override
  State<StatefulWidget> createState() => _FieldBuilder<T>();

  @override
  void insertIntoFormManager() {
    FormManager.instance._insertField(field);
  }

  @override
  void removeFromFormManager() {
    FormManager.instance._removeField(field);
  }
}

class _FieldBuilder<T> extends FormyBuilderState<FieldController,
    FieldState<dynamic>, FieldBuilder<dynamic>> {
  @override
  void addListener() {
    widget.field.addListener(triggerUpdate);
    for (var e in widget.aditionalListener) {
      e.attach(widget.field, this);
    }
  }

  @override
  void removeListener() {
    widget.field.removeListener(triggerUpdate);
    for (var e in widget.aditionalListener) {
      e.detach();
    }
  }

  @override
  FieldState<dynamic> getState() => widget.field.state;
}

class GroupBuilder extends FormyBuilder<GroupController, GroupState> {
  const GroupBuilder(
      {super.key,
      required super.field,
      super.buildWhen,
      super.child,
      required super.builder});

  @override
  State<StatefulWidget> createState() => _GroupBuilder();

  @override
  void insertIntoFormManager() {
    FormManager.instance._insertGroup(field);
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
}

// class FieldBuilder<T> extends StatefulWidget {
//   const FieldBuilder({
//     super.key,
//     required this.controller,
//     this.buildWhen,
//     required this.builder,
//     this.child,
//   });
//   final FieldController<T> controller;
//   final bool Function(
//     FieldState<T> oldState,
//     FieldState<T> currentState,
//   )? buildWhen;
//   final Widget Function(
//     BuildContext context,
//     FieldController<T> controller,
//     Widget? child,
//   ) builder;
//   final Widget? child;

//   @override
//   State<FieldBuilder<T>> createState() => _FieldBuilderState<T>();
// }

// class _FieldBuilderState<T> extends State<FieldBuilder<T>> {
//   late FieldState<T> oldState;
//   @override
//   void initState() {
//     super.initState();
//     oldState = widget.controller.state;
//     FormManager.instance._insertField(widget.controller);
//     widget.controller.addListener(_listener);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_listener);
//     FormManager.instance._removeField(widget.controller);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context, widget.controller, widget.child);
//   }

//   void _listener() {
//     final bool shouldBuild =
//         widget.buildWhen?.call(oldState, widget.controller.state) ?? true;
//     if (shouldBuild) {
//       setState(() {
//         oldState = widget.controller.state;
//       });
//     }
//   }
// }

// class GroupBuilder extends StatefulWidget {
//   const GroupBuilder({
//     super.key,
//     required this.controller,
//     this.buildWhen,
//     required this.builder,
//     this.child,
//   });
//   final GroupController controller;
//   final bool Function(
//     GroupState oldState,
//     GroupState currentState,
//   )? buildWhen;
//   final Widget Function(
//     BuildContext context,
//     GroupController controller,
//     Widget? child,
//   ) builder;
//   final Widget? child;

//   @override
//   State<GroupBuilder> createState() => _GroupBuilderState();
// }

// class _GroupBuilderState<T> extends State<GroupBuilder> {
//   late GroupState oldState;
//   @override
//   void initState() {
//     super.initState();
//     oldState = widget.controller.state;
//     FormManager.instance._insertGroup(widget.controller);
//     widget.controller.addListener(_listener);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_listener);
//     FormManager.instance._removeGroup(widget.controller);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context, widget.controller, widget.child);
//   }

//   void _listener() {
//     final bool shouldBuild =
//         widget.buildWhen?.call(oldState, widget.controller.state) ?? true;
//     if (shouldBuild) {
//       setState(() {
//         oldState = widget.controller.state;
//       });
//     }
//   }
// }
