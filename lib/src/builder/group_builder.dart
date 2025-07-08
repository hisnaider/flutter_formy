import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/formy_builder.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';
import 'package:flutter_formy/src/models/group_state.dart';

/// A widget that automatically rebuilds the interface based on changes
/// to the state of a [GroupController].
///
/// The [GroupBuilder] is similar to a `ValueListenableBuilder`, but is
/// specifically for managing groups of fields in Formy. It watches a
/// [GroupController] and rebuilds the widget whenever the group state changes.
///
/// This widget is useful for building complex interfaces that depend on
/// the state of a group of form fields.
///
/// ## Properties
///
/// * [controller]: The [GroupController] this widget will watch.
/// * [child]: A static widget that will not be rebuilt when the group state changes.
/// * [builder]: A function that returns the widget to be rebuilt. It receives:
///   * `context`: The [BuildContext] from the widget tree.
///   * `group`: The [GroupController] being observed.
///   * `child`: The static widget defined in the `child` property.
/// * [buildWhen]: An optional function that returns `true` if the widget
///   should rebuild. It receives:
///   * `oldState`: The previous [GroupState].
///   * `currentState`: The current [GroupState].
///
/// ## Example
/// ```dart
/// GroupBuilder(
///   controller: GroupController(
///     key: 'key',
///     fields: [
///       FieldConfig(key: 'field1', validators: [IsRequired()]),
///       FieldConfig(key: 'field2', validators: [IsRequired()]),
///     ],
///   ),
///   builder: (context, group, child) {
///     return Column(
///       children: [
///         TestForm(group: group),
///         Column(
///           children:
///               List.generate(group.state.errorMessages.length, (index) {
///             return Text(group.state.errorMessages[index]);
///           }),
///         ),
///         ElevatedButton(
///           onPressed: group.touchAndValidateAllFields,
///           child: const Text('Press'),
///         ),
///       ],
///     );
///   },
/// );
/// ```
///
/// ## See also
///
/// * [GroupController], which manages the state of a group.
class GroupBuilder extends FormyBuilder<GroupController, GroupState> {
  const GroupBuilder(
      {super.key,
      required super.controller,
      super.buildWhen,
      super.child,
      required this.builder});

  ///A function that returns the widget to be rebuilt.
  final Widget Function(
      BuildContext context, GroupController group, Widget? child) builder;

  @override
  State<StatefulWidget> createState() => _GroupBuilder();
}

class _GroupBuilder
    extends FormyBuilderState<GroupController, GroupState, GroupBuilder> {
  @override
  GroupState getState() => widget.controller.state;

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.controller, widget.child);
  }
}
