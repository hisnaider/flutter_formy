import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/aditional_listener/focus_listener.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

class FormyTextField extends StatefulWidget {
  const FormyTextField({
    super.key,
    required this.fieldControl,
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
  final FieldControl<String> fieldControl;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? Function(
      FieldState fieldState, ValidationResult? firstError)? decoration;
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
  State<FormyTextField> createState() => _FormyTextFieldState();
}

class _FormyTextFieldState extends State<FormyTextField> {
  bool get selectionEnabled => widget.enableInteractiveSelection;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormySingleFieldBuilder(
      buildWhen: (oldState, currentState) => oldState != currentState,
      fieldControl: widget.fieldControl,
      aditionalListener: [
        FocusListener(_focusNode),
      ],
      fieldBuilder: (
        context,
        fieldState,
        firstValidation,
        onUpdateField,
      ) {
        final InputDecoration inputDecoration = widget.decoration
                ?.call(widget.fieldControl.state, firstValidation) ??
            const InputDecoration();
        return TextField(
          controller: _controller,
          focusNode: _focusNode,
          undoController: widget.undoController,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          style: widget.style,
          strutStyle: widget.strutStyle,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          textDirection: widget.textDirection,
          readOnly: widget.readOnly,
          showCursor: widget.showCursor,
          autofocus: widget.autofocus,
          obscuringCharacter: widget.obscuringCharacter,
          obscureText: widget.obscureText,
          autocorrect: widget.autocorrect,
          smartDashesType: widget.smartDashesType,
          smartQuotesType: widget.smartQuotesType,
          enableSuggestions: widget.enableSuggestions,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          expands: widget.expands,
          maxLength: widget.maxLength,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          onChanged: (value) {
            widget.onChanged?.call(value);
            onUpdateField(value);
          },
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          onAppPrivateCommand: widget.onAppPrivateCommand,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          ignorePointers: widget.ignorePointers,
          cursorWidth: widget.cursorWidth,
          cursorHeight: widget.cursorHeight,
          cursorRadius: widget.cursorRadius,
          cursorOpacityAnimates: widget.cursorOpacityAnimates,
          cursorColor: widget.cursorColor,
          cursorErrorColor: widget.cursorErrorColor,
          selectionHeightStyle: widget.selectionHeightStyle,
          selectionWidthStyle: widget.selectionWidthStyle,
          keyboardAppearance: widget.keyboardAppearance,
          scrollPadding: widget.scrollPadding,
          dragStartBehavior: widget.dragStartBehavior,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          selectionControls: widget.selectionControls,
          onTap: widget.onTap,
          onTapAlwaysCalled: widget.onTapAlwaysCalled,
          onTapOutside: widget.onTapOutside,
          mouseCursor: widget.mouseCursor,
          buildCounter: widget.buildCounter,
          scrollController: widget.scrollController,
          scrollPhysics: widget.scrollPhysics,
          autofillHints: widget.autofillHints,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          clipBehavior: widget.clipBehavior,
          restorationId: widget.restorationId,
          scribbleEnabled: widget.scribbleEnabled,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          contextMenuBuilder: widget.contextMenuBuilder,
          canRequestFocus: widget.canRequestFocus,
          spellCheckConfiguration: widget.spellCheckConfiguration,
          magnifierConfiguration: widget.magnifierConfiguration,
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
                : inputDecoration.errorText ?? firstValidation?.key,
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
