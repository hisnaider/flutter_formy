import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';

/// The type used by the [TextFieldBuilder]'s `builder` property.
///
/// Receives:
/// - `context`: The [BuildContext].
/// - `field`: The [FieldController] being observed.
/// - `focusNode`: The [FocusNode] to handle focus.
/// - `textEditingController`: The [TextEditingController] managing the text value.
/// - `child`: A static widget passed through the `child` property of [TextFieldBuilder].
typedef TextFieldWidgetBuilder<T> = Widget Function(
  BuildContext context,
  FieldController<T> field,
  FocusNode focusNode,
  TextEditingController textEditingController,
  Widget? child,
);

/// A widget that rebuilds based on changes to a [FieldController]
/// and provides a [FocusNode] and [TextEditingController] to integrate with Flutter's [TextField].
///
/// The [TextFieldBuilder] is a specialized version of [FieldBuilder]
/// focused on text field widget, such as [TextField].
/// It watches a [FieldController] and rebuilds whenever the field state changes.
///
/// ## Properties
///
/// * [controller]: The [FieldController] this widget will watch.
/// * [child]: A static widget that will not be rebuilt when the field state changes.
/// * [focusNode]: The [FocusNode] used to handle focus for the field.
/// * [textEditingController]: The [TextEditingController] to manage the text input.
/// * [builder]: A function that returns the widget to be rebuilt. It receives:
///   * `context`: The [BuildContext] from the widget tree.
///   * `field`: The [FieldController] being observed.
///   * `focusNode`: The [FocusNode] defined in the `focusNode` property.
///   * `textEditingController`: The [TextEditingController] defined in the `focustextEditingControllerNode` property.
///   * `child`: The static widget defined in the `child` property.
/// * [buildWhen]: An optional function that returns `true` if the widget
///   should rebuild. It receives:
///   * `oldState`: The previous [FieldState].
///   * `currentState`: The current [FieldState].
///
/// ## Example
/// ```dart
/// TextFieldBuilder(
///   controller: FieldController<String>(key: 'name'),
///   builder: (context, field, focusNode, textController, child) {
///     return TextField(
///       controller: textController,
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
/// * [FieldController], which manages the state of a single field.
/// * [FormyBuilder], the generic base class this widget extends.
class TextFieldBuilder
    extends FormyBuilder<FieldController<String>, FieldState<String>> {
  const TextFieldBuilder({
    super.key,
    required super.controller,
    super.buildWhen,
    super.child,
    this.focusNode,
    this.textEditingController,
    required this.builder,
  });

  ///A function that returns the widget to be rebuilt.
  final TextFieldWidgetBuilder<String> builder;

  /// The [FocusNode] used to handle focus for the field.
  final FocusNode? focusNode;

  /// The [TextEditingController] to manage the text input.
  final TextEditingController? textEditingController;
  @override
  State<StatefulWidget> createState() => _TextFieldBuilder();
}

class _TextFieldBuilder extends FormyBuilderState<FieldController<String>,
    FieldState<String>, TextFieldBuilder> {
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _textEditingController = (widget.textEditingController ??
        TextEditingController())
      ..text = widget.controller.value ?? '';
    _textEditingController.addListener(
      () {
        final String value = widget.controller.value ?? '';
        if (oldState == getState()) {
          widget.controller.update(_textEditingController.text);
        } else if (_textEditingController.text != value) {
          _textEditingController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(
              offset: value.length,
            ),
          );
        }
      },
    );
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
    _textEditingController.dispose();
  }

  @override
  FieldState<String> getState() => widget.controller.state;

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.controller, _focusNode,
        _textEditingController, widget.child);
  }
}
