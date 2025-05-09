import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';

class FormySubGroupVisibility extends GroupSelector<bool> {
  FormySubGroupVisibility(
      {super.key, required super.control, required Widget child})
      : super(
          selector: (value) => value.state.isEnabled,
          child: (value) {
            return Visibility(visible: value, child: child);
          },
        );
}
