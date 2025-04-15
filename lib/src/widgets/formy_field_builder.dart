import 'package:flutter/material.dart';
import 'package:flutter_formy/src/extensions/field_control_extensions.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/field_state.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/services/form_manager.dart';

class FormyFieldBuilder<T> extends StatefulWidget {
  const FormyFieldBuilder({
    super.key,
    required this.fieldControl,
    this.buildWhen,
    required this.builder,
  });

  final FieldControl<T> fieldControl;

  final Function(FieldState<T> oldState, FieldState<T> currentState)? buildWhen;

  final Widget Function(
    BuildContext context,
    T? value,
    void Function(dynamic value) onChanged,
    ValidationResult? firstValidationResult,
    List<ValidationResult> validationResult,
    bool touched,
  ) builder;

  @override
  State<FormyFieldBuilder<T>> createState() => _FormyFieldBuilderState<T>();
}

class _FormyFieldBuilderState<T> extends State<FormyFieldBuilder<T>> {
  late FieldState<T> _oldState;
  bool _isRegistered = false;
  @override
  void initState() {
    super.initState();
    _oldState = widget.fieldControl.state;
    if (widget.fieldControl.key.isNotEmpty && !_isRegistered) {
      FormManager().insertField(widget.fieldControl);
      _isRegistered = true;
    }
    widget.fieldControl.addListener(_listener);
  }

  @override
  void dispose() {
    if (_isRegistered) {
      FormManager().removeField(widget.fieldControl);
    }
    widget.fieldControl.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstValidationResult = widget.fieldControl.validationResults
        .where((v) => !v.isValid)
        .map((v) => v)
        .firstOrNull;

    return widget.builder(
      context,
      widget.fieldControl.value,
      (newValue) {
        if (widget.fieldControl is FieldListControl) {
          _handleListValue(newValue);
        } else {
          _handleSingleValue(newValue);
        }
      },
      widget.fieldControl.state.touched ? firstValidationResult : null,
      widget.fieldControl.validationResults,
      widget.fieldControl.touched,
    );
  }

  void _handleListValue(dynamic value) {
    final newList = (widget.fieldControl.state.value as List<dynamic>).toList();
    if (newList.contains(value)) {
      newList.remove(value);
    } else {
      newList.add(value);
    }
    widget.fieldControl.update(newList as T);
  }

  void _handleSingleValue(T value) {
    widget.fieldControl.update(value);
  }

  void _listener() {
    final currentState = widget.fieldControl.state;
    final shouldRebuild =
        widget.buildWhen?.call(_oldState, currentState) ?? true;

    _debugLog();

    if (shouldRebuild) {
      setState(() {
        _oldState = currentState;
      });
    } else {
      _oldState = currentState;
    }
  }

  void _debugLog() {
    assert(() {
      final key = widget.fieldControl.key;
      debugPrint('\n\x1B[36m==================================\x1B[0m');
      debugPrint(
          '\x1B[36m[FieldBuilder:$key] ${widget.fieldControl.state.value}');
      debugPrint(
          '\x1B[36m[FieldBuilder:$key] isDirty ${widget.fieldControl.state.dirty}');
      debugPrint(
          '\x1B[36m[FieldBuilder:$key] isTouched ${widget.fieldControl.state.touched}');

      if (widget.fieldControl.valid) {
        debugPrint('\x1B[32m[FieldBuilder:$key] Valid \x1B[0m');
      } else {
        debugPrint(
            '\x1B[31m[FieldBuilder:$key] Invalid ${widget.fieldControl.errorKeys} \x1B[0m');
      }

      debugPrint('\x1B[36m==================================\x1B[0m\n');
      return true;
    }());
  }
}
