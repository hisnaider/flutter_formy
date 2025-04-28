import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

class FormyTextField extends StatelessWidget {
  const FormyTextField({
    super.key,
    required this.fieldController,
    this.controller,
    this.focusNode,
    this.undoController,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.ignorePointers,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
  });
  final FieldController<String> fieldController;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? Function(FieldState fieldState, String? firstError)?
      decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final bool? showCursor;
  static const int noMaxLength = -1;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? ignorePointers;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback? onTap;
  final bool onTapAlwaysCalled;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final bool canRequestFocus;
  final UndoHistoryController? undoController;

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  final SpellCheckConfiguration? spellCheckConfiguration;

  @override
  Widget build(BuildContext context) {
    return FieldBuilder<String>(
      field: fieldController,
      buildWhen: (oldState, currentState) => oldState != currentState,
      aditionalListener: [
        AdditionalListener<FocusNode>(
          listenerType: focusNode,
          createListener: focusNode == null ? () => FocusNode() : null,
          lifecycle: focusNode != null
              ? ListenerLifecycle.manual
              : ListenerLifecycle.autoDispose,
          onListen: (listener, controller) {
            final hasFocus = listener.hasFocus;
            if (!hasFocus) {
              controller.markAsTouched();
            }
          },
        )
      ],
      builder: (context, field, child, listeners) {
        final FocusNode focusNode = listeners.first.listener as FocusNode;
        final InputDecoration inputDecoration =
            decoration?.call(fieldController.state, field.firstError) ??
                const InputDecoration();
        return TextField(
          controller: controller,
          focusNode: focusNode,
          undoController: undoController,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          textDirection: textDirection,
          readOnly: readOnly,
          showCursor: showCursor,
          autofocus: autofocus,
          obscuringCharacter: obscuringCharacter,
          obscureText: obscureText,
          autocorrect: autocorrect,
          smartDashesType: smartDashesType,
          smartQuotesType: smartQuotesType,
          enableSuggestions: enableSuggestions,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforcement,
          onChanged: (value) {
            onChanged?.call(value);
            field.update(value);
          },
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          onAppPrivateCommand: onAppPrivateCommand,
          inputFormatters: inputFormatters,
          enabled: enabled,
          ignorePointers: ignorePointers,
          cursorWidth: cursorWidth,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorColor: cursorColor,
          cursorErrorColor: cursorErrorColor,
          selectionHeightStyle: selectionHeightStyle,
          selectionWidthStyle: selectionWidthStyle,
          keyboardAppearance: keyboardAppearance,
          scrollPadding: scrollPadding,
          dragStartBehavior: dragStartBehavior,
          enableInteractiveSelection: enableInteractiveSelection,
          selectionControls: selectionControls,
          onTap: onTap,
          onTapAlwaysCalled: onTapAlwaysCalled,
          onTapOutside: onTapOutside,
          mouseCursor: mouseCursor,
          buildCounter: buildCounter,
          scrollController: scrollController,
          scrollPhysics: scrollPhysics,
          autofillHints: autofillHints,
          contentInsertionConfiguration: contentInsertionConfiguration,
          clipBehavior: clipBehavior,
          restorationId: restorationId,
          scribbleEnabled: scribbleEnabled,
          enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
          contextMenuBuilder: contextMenuBuilder,
          canRequestFocus: canRequestFocus,
          spellCheckConfiguration: spellCheckConfiguration,
          magnifierConfiguration: magnifierConfiguration,
          decoration: InputDecoration(
            icon: inputDecoration.icon,
            iconColor: inputDecoration.iconColor,
            label: inputDecoration.label,
            labelText: inputDecoration.labelText,
            labelStyle: inputDecoration.labelStyle,
            floatingLabelStyle: inputDecoration.floatingLabelStyle,
            helper: inputDecoration.helper,
            helperText: inputDecoration.helperText,
            helperStyle: inputDecoration.helperStyle,
            helperMaxLines: inputDecoration.helperMaxLines,
            hintText: inputDecoration.hintText,
            hintStyle: inputDecoration.hintStyle,
            hintTextDirection: inputDecoration.hintTextDirection,
            hintMaxLines: inputDecoration.hintMaxLines,
            hintFadeDuration: inputDecoration.hintFadeDuration,
            error: inputDecoration.error,
            errorText: inputDecoration.error != null
                ? null
                : inputDecoration.errorText ?? field.firstError,
            errorStyle: inputDecoration.errorStyle,
            errorMaxLines: inputDecoration.errorMaxLines,
            floatingLabelBehavior: inputDecoration.floatingLabelBehavior,
            floatingLabelAlignment: inputDecoration.floatingLabelAlignment,
            isCollapsed: inputDecoration.isCollapsed,
            isDense: inputDecoration.isDense,
            contentPadding: inputDecoration.contentPadding,
            prefixIcon: inputDecoration.prefixIcon,
            prefixIconConstraints: inputDecoration.prefixIconConstraints,
            prefix: inputDecoration.prefix,
            prefixText: inputDecoration.prefixText,
            prefixStyle: inputDecoration.prefixStyle,
            prefixIconColor: inputDecoration.prefixIconColor,
            suffixIcon: inputDecoration.suffixIcon,
            suffix: inputDecoration.suffix,
            suffixText: inputDecoration.suffixText,
            suffixStyle: inputDecoration.suffixStyle,
            suffixIconColor: inputDecoration.suffixIconColor,
            suffixIconConstraints: inputDecoration.suffixIconConstraints,
            counter: inputDecoration.counter,
            counterText: inputDecoration.counterText,
            counterStyle: inputDecoration.counterStyle,
            filled: inputDecoration.filled,
            fillColor: inputDecoration.fillColor,
            focusColor: inputDecoration.focusColor,
            hoverColor: inputDecoration.hoverColor,
            errorBorder: inputDecoration.errorBorder,
            focusedBorder: inputDecoration.focusedBorder,
            focusedErrorBorder: inputDecoration.focusedErrorBorder,
            disabledBorder: inputDecoration.disabledBorder,
            enabledBorder: inputDecoration.enabledBorder,
            border: inputDecoration.border,
            enabled: inputDecoration.enabled,
            semanticCounterText: inputDecoration.semanticCounterText,
            alignLabelWithHint: inputDecoration.alignLabelWithHint,
            constraints: inputDecoration.constraints,
          ),
        );
      },
    );
  }
}
