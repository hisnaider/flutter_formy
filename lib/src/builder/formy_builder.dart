import 'package:flutter/material.dart';
import 'package:flutter_formy/src/manager/form_manager.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';

/// A widget that rebuilds based on changes to a [FieldController] or [GroupController]
/// using a customizable condition.
///
/// The [FormyBuilder] is a flexible widget similar to `ValueListenableBuilder`,
/// but specialized for watching [FieldController] or [GroupController] instances.
/// It rebuilds whenever the controller's state changes and the optional [buildWhen]
/// function returns `true`.
///
/// This allows you to control precisely when the UI should rebuild,
/// optimizing performance in complex forms.
///
/// ## Properties
///
/// * [controller]: The [FieldController] or [GroupController] to observe.
/// * [buildWhen]: An optional function that decides whether to rebuild,
///   receiving the previous and current state.
/// * [child]: A static widget that will not be rebuilt.
///
/// ## Typically used to
///
/// * Rebuild portions of a form when the value or validation state of a controller changes.
/// * Optimize form rebuilds by specifying a [buildWhen] condition.
///
/// ## See also
///
/// * [FieldController], which manages single field state.
/// * [GroupController], which manages multiple fields.
/// * [FormyFormManager], which keeps track of all controllers.
abstract class FormyBuilder<Controller, StateType> extends StatefulWidget {
  /// Creates a [FormyBuilder].
  ///
  /// * [controller]: The field or group controller to observe.
  /// * [buildWhen]: Optional function to decide if the widget should rebuild.
  /// * [child]: A static child widget that does not rebuild.
  const FormyBuilder({
    super.key,
    required this.controller,
    this.buildWhen,
    this.child,
  });

  /// The [FieldController] or [GroupController] that this widget will watch.
  final Controller controller;

  /// An optional function that returns `true` if the widget should rebuild.
  ///
  /// Receives the previous and current state.
  final bool Function(StateType oldState, StateType currentState)? buildWhen;

  /// A static widget that will not be rebuilt when the state changes.
  final Widget? child;
}

/// The base state class for [FormyBuilder].
///
/// Manages adding and removing listeners on the controller,
/// deciding when to rebuild based on the `buildWhen` callback,
/// and provides an abstract [getState] to retrieve the controller state.
abstract class FormyBuilderState<TController, TStateType,
        TWidget extends FormyBuilder<TController, TStateType>>
    extends State<TWidget> {
  /// Holds the last known state for comparison.
  late TStateType oldState;

  @override
  void initState() {
    super.initState();
    oldState = getState();
    if (widget.controller is FieldController) {
      FormyFormManager.instance
          .insertField(widget.controller as FieldController);
      (widget.controller as FieldController).addListener(_onChanged);
    } else if (widget.controller is GroupController) {
      FormyFormManager.instance
          .insertGroup(widget.controller as GroupController);
      (widget.controller as GroupController).addListener(_onChanged);
    }
  }

  @override
  void dispose() {
    if (widget.controller is FieldController) {
      FormyFormManager.instance
          .removeField(widget.controller as FieldController);
      (widget.controller as FieldController).removeListener(_onChanged);
    } else if (widget.controller is GroupController) {
      FormyFormManager.instance
          .removeGroup(widget.controller as GroupController);
      (widget.controller as GroupController).removeListener(_onChanged);
    }
    super.dispose();
  }

  /// Must be overridden to build the UI.
  @override
  Widget build(BuildContext context);

  /// Called when the controller changes.
  ///
  /// Checks the [buildWhen] condition and triggers rebuild if needed.
  void _onChanged() {
    final shouldBuild = widget.buildWhen?.call(oldState, getState()) ?? true;
    if (shouldBuild) {
      setState(() {
        oldState = getState();
      });
    }
  }

  /// Calls [_onChanged] method outside this file.
  void triggerUpdate() => _onChanged();

  /// Returns the current state from the controller.
  ///
  /// Must be implemented by subclasses.
  TStateType getState();
}
