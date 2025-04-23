import 'package:flutter/material.dart';
import 'package:flutter_formy/src/models/group_state.dart';
import 'package:flutter_formy/src/widgets/builders/formy_base_group_builder.dart';

enum ButtonType {
  enabledOnlyIfValid,
  alwaysEnabledThenValidate,
}

class FormyButton extends FormyBaseGroupBuilder {
  FormyButton({
    super.key,
    required super.groupFields,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior,
    this.statesController,
    this.iconAlignment = IconAlignment.start,
    required this.child,
    this.type = ButtonType.enabledOnlyIfValid,
  }) : super(
          buidChild: (builder) => builder,
        );
  final Function(Map<String, dynamic> values)? onPressed;
  final Function(Map<String, dynamic> values)? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final Clip? clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final WidgetStatesController? statesController;
  final IconAlignment iconAlignment;
  final Widget child;
  final ButtonType type;

  @override
  Widget builder(
    BuildContext context,
    VoidCallback touchAndValidateAllFields,
    VoidCallback resetAll,
    GroupState groupState,
    Map<String, dynamic> values,
  ) {
    final bool canBePressed =
        type != ButtonType.enabledOnlyIfValid || groupState.isValid;

    late final VoidCallback? pressed = canBePressed
        ? () {
            if (type == ButtonType.alwaysEnabledThenValidate) {
              touchAndValidateAllFields();
              final newState = groupFields.state;
              if (newState.isValid) {
                onPressed?.call(values);
              }
            } else {
              onPressed?.call(values);
            }
          }
        : null;

    late final VoidCallback? longPress = canBePressed
        ? () {
            if (type == ButtonType.alwaysEnabledThenValidate) {
              touchAndValidateAllFields();
              final newState = groupFields.state;
              if (newState.isValid) {
                onLongPress?.call(values);
              }
            } else {
              onLongPress?.call(values);
            }
          }
        : null;

    return ElevatedButton(
      onPressed: pressed,
      onLongPress: longPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      statesController: statesController,
      iconAlignment: iconAlignment,
      child: child,
    );
  }
}
