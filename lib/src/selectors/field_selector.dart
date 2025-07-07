import 'package:flutter/material.dart';
import 'package:flutter_formy/src/models/controller/field_controller.dart';
import 'package:flutter_formy/src/selectors/formy_selector.dart';

/// A widget that rebuilds whenever a selected value from a [FieldController] changes.
///
/// The [FieldSelector] is a specialized version of [FormySelector] that
/// observes a [FieldController] and rebuilds only when the selected
/// portion of the field state (defined by the `selector`) changes.
///
/// This is useful to optimize performance by avoiding rebuilds when
/// unrelated parts of the field change.
///
/// ## Properties
///
/// * [controller]: The [FieldController] being observed.
/// * [selector]: Function that extracts the value to watch from the field.
/// * [child]: Builder that receives the selected value.
///
/// ## Example
/// ```dart
/// FieldSelector<bool>(
///   controller: myField,
///   selector: (field) => field.valid,
///   child: (isValid) => Icon(
///     isValid ? Icons.check : Icons.close,
///     color: isValid ? Colors.green : Colors.red,
///   ),
/// )
/// ```
///
/// ## See also
///
/// * [FieldController], which manages individual field state.
/// * [FormySelector], the generic base class that this widget extends.
class FieldSelector<T> extends FormySelector<FieldController, T> {
  /// Creates a [FieldSelector].
  ///
  /// * [controller]: The field controller to observe.
  /// * [selector]: Function that extracts the value to watch.
  /// * [child]: Builder that receives the selected value.
  const FieldSelector({
    super.key,
    required super.controller,
    required super.selector,
    required super.child,
  });

  @override
  State<FieldSelector<T>> createState() => _FieldSelectorState<T>();
}

/// The state class for [FieldSelector].
///
/// Handles listening to the [FieldController] and rebuilding
/// when the selected value changes.
class _FieldSelectorState<T>
    extends FormySelectorState<FieldController, T, FieldSelector<T>> {
  @override
  void addListener() {
    widget.controller.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.controller.removeListener(triggerUpdate);
  }
}
