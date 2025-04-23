import 'package:flutter_formy/flutter_formy.dart';

abstract class FormyAditionalListener {
  FormyAditionalListener();
  bool _initialized = false;

  late final FieldControl field;

  void init();

  void call(FieldControl field) {
    if (_initialized) return;
    _initialized = true;
    this.field = field;
    init();
  }

  void listener();

  void dispose();
}
