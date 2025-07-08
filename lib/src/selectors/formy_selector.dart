import 'package:flutter/material.dart';
import 'package:flutter_formy/src/manager/form_manager.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';

/// A widget that rebuilds whenever a selected part of a [FieldController] or [GroupController] changes.
///
/// The [FormySelector] is a base class to build specialized widgets
/// that watch a form controller (field or group) and rebuild only when
/// a derived value (selected via the `selector`) changes.
///
/// This allows you to optimize rebuilds, avoiding unnecessary widget updates
/// when unrelated parts of the controller state change.
///
/// ## Properties
///
/// * [controller]: The controller being observed. Can be a [FieldController] or [GroupController].
/// * [selector]: A function that selects the piece of data to watch from the controller.
/// * [child]: A builder function that receives the selected value and returns the widget.
///
/// ## Example
/// ```dart
/// class MyTextWatcher extends FormySelector<FieldController, String> {
///   const MyTextWatcher({
///     super.key,
///     required super.controller,
///     required super.selector,
///     required super.child,
///   });
/// }
///
/// class _MyTextWatcherState extends FormySelectorState<FieldController, String, MyTextWatcher> {
///   @override
///   void addListener() {
///     widget.controller.addListener(triggerUpdate);
///   }
///
///   @override
///   void removeListener() {
///     widget.controller.removeListener(triggerUpdate);
///   }
/// }
/// ```
///
/// ## See also
///
/// * [FieldController], which manages single field state.
/// * [GroupController], for managing grouped fields.
/// * [FormyFormManager], which keeps track of all fields and groups.
abstract class FormySelector<Control, Value> extends StatefulWidget {
  /// Creates a [FormySelector].
  ///
  /// * [controller]: The field or group controller to observe.
  /// * [selector]: Function that extracts the value to track from the controller.
  /// * [child]: Builder that receives the selected value.
  const FormySelector({
    super.key,
    required this.controller,
    required this.selector,
    required this.child,
  });

  /// The controller being observed.
  final Control controller;

  /// Function that selects the data to watch from the controller.
  final Value Function(Control value) selector;

  /// Builder function that receives the selected value.
  final Widget Function(Value value) child;
}

/// The base state for [FormySelector].
///
/// Handles listening to the controller, computing the selected value,
/// and rebuilding only when the selected value changes.
abstract class FormySelectorState<TValue, TSelected,
    TWidget extends FormySelector<TValue, TSelected>> extends State<TWidget> {
  /// The last selected value. Used to compare changes.
  late TSelected _value;

  @override
  void initState() {
    super.initState();
    _value = widget.selector(widget.controller);
    if (widget.controller is FieldController) {
      FormyFormManager.instance
          .insertField(widget.controller as FieldController);
    } else if (widget.controller is GroupController) {
      FormyFormManager.instance
          .insertGroup(widget.controller as GroupController);
    }
    addListener();
  }

  /// Adds a listener to the controller.
  ///
  /// Must be implemented by subclasses.
  void addListener();

  /// Removes the listener from the controller.
  ///
  /// Must be implemented by subclasses.
  void removeListener();

  /// Called when the controller notifies a change.
  ///
  /// Checks if the selected value actually changed,
  /// and rebuilds if necessary.
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
  Widget build(BuildContext context) {
    return widget.child(_value);
  }

  /// Forces a check of the selected value and triggers a rebuild if changed.
  void triggerUpdate() => _onChanged();
}
