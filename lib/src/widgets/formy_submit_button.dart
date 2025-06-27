import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/field_instace_management/form_manager.dart';

class FormySubmitButton extends GroupSelector<bool> {
  FormySubmitButton({
    super.key,
    required Widget child,
    required super.control,
    VoidCallback? onPressed,
  }) : super(
            selector: (control) => control.state.isValid,
            child: (value) => ElevatedButton(
                  onPressed: value ? onPressed : null,
                  child: child,
                ));
}
