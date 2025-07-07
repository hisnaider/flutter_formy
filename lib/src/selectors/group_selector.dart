import 'package:flutter/material.dart';
import 'package:flutter_formy/src/models/controller/field_controller.dart';
import 'package:flutter_formy/src/selectors/formy_selector.dart';

/// A widget that rebuilds whenever a selected value from a [GroupController] changes.
///
/// The [GroupSelector] is a specialized version of [FormySelector] that
/// observes a [GroupController] and rebuilds only when the selected
/// portion of the group state (defined by the `selector`) changes.
///
/// This allows you to build efficient UIs that react only to
/// specific parts of a group state.
///
/// ## Properties
///
/// * [controller]: The [GroupController] being observed.
/// * [selector]: Function that extracts the value to watch from the group.
/// * [child]: Builder that receives the selected value.
///
/// ## Example
/// ```dart
/// GroupSelector<bool>(
///   controller: myGroup,
///   selector: (group) => group.isValid,
///   child: (isValid) => Text(
///     isValid ? 'Group is valid' : 'Group has errors',
///     style: TextStyle(color: isValid ? Colors.green : Colors.red),
///   ),
/// )
/// ```
///
/// ## See also
///
/// * [GroupController], which manages multiple fields as a group.
/// * [FormySelector], the generic base class that this widget extends.
class GroupSelector<T> extends FormySelector<GroupController, T> {
  /// Creates a [GroupSelector].
  ///
  /// * [controller]: The group controller to observe.
  /// * [selector]: Function that extracts the value to watch.
  /// * [child]: Builder that receives the selected value.
  const GroupSelector({
    super.key,
    required super.controller,
    required super.selector,
    required super.child,
  });

  @override
  State<GroupSelector<T>> createState() => _GroupSelectorState<T>();
}

/// The state class for [GroupSelector].
///
/// Listens to the [GroupController] and rebuilds
/// when the selected value changes.
class _GroupSelectorState<T>
    extends FormySelectorState<GroupController, T, GroupSelector<T>> {
  @override
  void addListener() {
    widget.controller.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.controller.removeListener(triggerUpdate);
  }
}
