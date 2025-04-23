import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/aditional_listener/formy_aditional_listener.dart';

class FocusListener extends FormyAditionalListener {
  FocusListener(this.focusNode);
  final FocusNode focusNode;

  @override
  void init() {
    focusNode.addListener(listener);
  }

  @override
  void listener() {
    final hasFocus = focusNode.hasFocus;
    print("aaaaaaaaaaaaaaaaaaaaa: $hasFocus");
    if (field.state.hasFocus != hasFocus) {
      field.update(hasFocus: hasFocus, touched: hasFocus ? null : true);
    }
  }

  @override
  void dispose() {
    field.update(hasFocus: false);
    focusNode.removeListener(listener);
    focusNode.dispose();
  }
}
