import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/aditional_listener/focus_listener.dart';

class FormyDropdown<T> extends StatefulWidget {
  const FormyDropdown({
    super.key,
    required this.fieldControl,
    this.enabled = true,
    this.width,
    this.menuHeight,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.selectedTrailingIcon,
    this.enableFilter = false,
    this.enableSearch = true,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.inputDecorationTheme,
    this.menuStyle,
    this.controller,
    this.initialSelection,
    this.onSelected,
    this.focusNode,
    this.requestFocusOnTap,
    this.expandedInsets,
    this.filterCallback,
    this.searchCallback,
    required this.dropdownMenuEntries,
    this.inputFormatters,
    this.errorWidget,
  });
  final FieldControl<T> fieldControl;
  final bool enabled;
  final double? width;
  final double? menuHeight;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? selectedTrailingIcon;
  final bool enableFilter;
  final bool enableSearch;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final InputDecorationTheme? inputDecorationTheme;
  final MenuStyle? menuStyle;
  final TextEditingController? controller;
  final T? initialSelection;
  final ValueChanged<T?>? onSelected;
  final FocusNode? focusNode;
  final bool? requestFocusOnTap;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final EdgeInsets? expandedInsets;
  final FilterCallback<T>? filterCallback;
  final SearchCallback<T>? searchCallback;
  final List<TextInputFormatter>? inputFormatters;
  final Widget Function(FieldState fieldState, ValidationResult? firstError)?
      errorWidget;

  @override
  State<FormyDropdown<T>> createState() => _FormyDropdownState<T>();
}

class _FormyDropdownState<T> extends State<FormyDropdown<T>> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return FormySingleFieldBuilder(
      fieldControl: widget.fieldControl,
      aditionalListener: [FocusListener(_focusNode)],
      buildWhen: (oldState, currentState) =>
          oldState.value != currentState.value || !currentState.touched,
      fieldBuilder: (context, fieldState, firstValidation, onUpdateField) {
        return DropdownMenu(
          enabled: widget.enabled,
          width: widget.width,
          menuHeight: widget.menuHeight,
          leadingIcon: widget.leadingIcon,
          trailingIcon: widget.trailingIcon,
          label: widget.label,
          hintText: widget.hintText,
          helperText: widget.helperText,
          errorText: widget.errorText,
          selectedTrailingIcon: widget.selectedTrailingIcon,
          enableFilter: widget.enableFilter,
          enableSearch: widget.enableSearch,
          textStyle: widget.textStyle,
          textAlign: widget.textAlign,
          inputDecorationTheme: widget.inputDecorationTheme,
          menuStyle: widget.menuStyle,
          controller: widget.controller,
          initialSelection: widget.initialSelection,
          onSelected: (value) {
            widget.onSelected?.call(value);
            onUpdateField(value);
          },
          focusNode: _focusNode,
          requestFocusOnTap: widget.requestFocusOnTap,
          dropdownMenuEntries: widget.dropdownMenuEntries,
          expandedInsets: widget.expandedInsets,
          filterCallback: widget.filterCallback,
          searchCallback: widget.searchCallback,
          inputFormatters: widget.inputFormatters,
        );
      },
    );
  }
}
