import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/formy_builder.dart';

import 'package:flutter_formy/src/models/controller/field_controller.dart';
import 'package:flutter_formy/src/models/field_state.dart';

/// The type used by the [FocusableFieldBuilder]'s `builder` property.
typedef FocusableFieldWidgetBuilder<T> = Widget Function(
  BuildContext context,
  FieldController<T> field,
  FocusNode focusNode,
  Widget? child,
);

/// A widget that automatically rebuilds the interface based on changes
/// to the state of a [FieldController].
///
/// The [FocusableFieldBuilder] is a specialized version of [FieldBuilder]
/// focused on focusable widgets, such as [TextField].
/// It watches a [FieldController] and rebuilds whenever the field state changes.
///
/// This widget is useful for building complex interfaces that depend
/// on the state of a form field.
///
/// ## Properties
///
/// * [field]: The [FieldController] this widget will watch.
/// * [child]: A static widget that will not be rebuilt when the field state changes.
/// * [focusNode]: A [FocusNode] used to handle focus for the field.
/// * [builder]: A function that returns the widget to be rebuilt. It receives:
///   * `context`: The [BuildContext] from the widget tree.
///   * `field`: The [FieldController] being observed.
///   * `focusNode`: The [FocusNode] defined in the `focusNode` property.
///   * `child`: The static widget defined in the `child` property.
/// * [buildWhen]: An optional function that returns `true` if the widget
///   should rebuild. It receives:
///   * `oldState`: The previous [FieldState].
///   * `currentState`: The current [FieldState].
///
/// ## Example
/// ```dart
/// FocusableFieldBuilder(
///   field: nameController,
///   focusNode: FocusNode(),
///   builder: (context, field, focusNode, child) {
///     return TextField(
///       controller: TextEditingController(text: field.value),
///       focusNode: focusNode,
///       decoration: InputDecoration(
///         labelText: 'Name',
///         errorText: field.firstError,
///       ),
///       onChanged: field.update,
///     );
///   },
/// )
/// ```
///
/// ## See also
///
/// * [FieldController], which manages the state of a field.
/// * [FieldBuilder], a widget that rebuilds the interface based on changes to a [FieldController].
class FocusableFieldBuilder<T>
    extends FormyBuilder<FieldController<T>, FieldState<T>> {
  const FocusableFieldBuilder({
    super.key,
    required super.controller,
    super.buildWhen,
    super.child,
    this.focusNode,
    required this.builder,
  });

  ///A function that returns the widget to be rebuilt.
  final FocusableFieldWidgetBuilder<T> builder;

  /// A [FocusNode] used to handle focus for the field.
  final FocusNode? focusNode;
  @override
  State<StatefulWidget> createState() => _FocusableFieldBuilder<T>();
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
      widget.controller.markAsTouched();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  FieldState<T> getState() => widget.controller.state;

  @override
  void addListener() {
    widget.controller.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.controller.removeListener(triggerUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.controller, _focusNode, widget.child);
  }
}
