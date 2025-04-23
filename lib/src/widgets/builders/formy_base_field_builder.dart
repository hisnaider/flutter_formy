import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/aditional_listener/formy_aditional_listener.dart';

abstract class FormyBaseFieldBuilder<ValueType, FieldType>
    extends StatefulWidget {
  const FormyBaseFieldBuilder({
    super.key,
    required this.fieldControl,
    this.aditionalListener = const [],
    this.buildWhen,
    required this.fieldBuilder,
    this.decorateField,
  });

  final FieldControl<FieldType> fieldControl;
  final List<FormyAditionalListener> aditionalListener;

  final Function(
          FieldState<FieldType> oldState, FieldState<FieldType> currentState)?
      buildWhen;

  final Widget Function(
      BuildContext context,
      FieldState<FieldType> fieldState,
      ValidationResult? firstValidation,
      Function(ValueType? newValue) onUpdateField) fieldBuilder;

  final Widget Function(BuildContext context, FieldState<FieldType> fieldState,
      ValidationResult? firstValidation, Widget fieldBuilder)? decorateField;
}

abstract class FormyBaseFieldBuilderState<ValueType, FieldType>
    extends State<FormyBaseFieldBuilder<ValueType, FieldType>> {
  late FieldState<FieldType> _oldState;
  late ValidationResult? _firstValidation;
  int numberOfRebuilds = 0;

  @override
  void initState() {
    super.initState();
    _updateLocalValues();
    _initListener();
  }

  @override
  Widget build(BuildContext context) {
    final buildField = widget.fieldBuilder(
        context,
        widget.fieldControl.state,
        widget.fieldControl.state.touched ? _firstValidation : null,
        updateFieldValue);
    return widget.decorateField?.call(
            context, widget.fieldControl.state, _firstValidation, buildField) ??
        buildField;
  }

  void updateFieldValue(ValueType? newValue);

  void debugLog() {}

  void _updateLocalValues() {
    _oldState = widget.fieldControl.state;
    _firstValidation = widget.fieldControl.validationResults
        .where((v) => !v.isValid)
        .map((v) => v)
        .firstOrNull;
  }

  void _listener() {
    final shouldRebuild =
        widget.buildWhen?.call(_oldState, widget.fieldControl.state) ?? true;

    debugLog();
    _updateLocalValues();
    if (shouldRebuild) {
      setState(() {});
      numberOfRebuilds++;
    }
  }

  void _initListener() {
    widget.fieldControl.addListener(_listener);
    for (var e in widget.aditionalListener) {
      e(widget.fieldControl);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.fieldControl.removeListener(_listener);
    for (var e in widget.aditionalListener) {
      e.dispose();
    }
  }
}
