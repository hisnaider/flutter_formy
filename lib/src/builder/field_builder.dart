part of 'form_manager.dart';

/// A widget that automatically rebuilds the interface based on changes
/// to the state of a [FieldController].
///
/// The [FieldBuilder] is similar to a `ValueListenableBuilder`, but is
/// specific for managing Formy fields. It watches a [FieldController]
/// and rebuilds the widget whenever the field state changes.
///
/// This widget is useful to build complex interfaces that depend on the
/// state of a form field.
///
/// ## Properties
///
/// * [field]: The [FieldController] this widget will watch.
/// * [child]: A static widget that will not be rebuilt when the field state changes.
/// * [builder]: A function that returns the widget to be rebuilt. It receives:
///   * `context`: The [BuildContext] from the widget tree.
///   * `field`: The [FieldController] being observed.
///   * `child`: The static widget defined in the `child` property.
/// * [buildWhen]: An optional function that returns `true` if the widget
///   should rebuild. It receives:
///   * `oldState`: The previous [FieldState].
///   * `currentState`: The current [FieldState].
///
/// ## Example
/// ```dart
/// FieldBuilder<String>(
///   field: FieldController(key: 'key'),
///   builder: (context, field, child) {
///     return TextField(
///       controller: TextEditingController(text: field.value),
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
class FieldBuilder<T> extends FormyBuilder<FieldController<T>, FieldState<T>> {
  const FieldBuilder({
    super.key,
    required super.field,
    super.buildWhen,
    super.child,
    required this.builder,
  });

  ///A function that returns the widget to be rebuilt.
  final Widget Function(
      BuildContext context, FieldController<T> field, Widget? child) builder;

  @override
  State<StatefulWidget> createState() => _FieldBuilder<T>();
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
