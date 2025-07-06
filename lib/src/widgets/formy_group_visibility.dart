import 'package:flutter/material.dart';
import 'package:flutter_formy/src/selectors/group_selector.dart';

class FormyGroupVisibility extends GroupSelector<bool> {
  FormyGroupVisibility(
      {super.key, required super.controller, required Widget child})
      : super(
          selector: (value) => value.state.isEnabled,
          child: (value) {
            return Visibility(visible: value, child: child);
          },
        );
}
