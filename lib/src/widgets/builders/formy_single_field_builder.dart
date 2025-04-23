import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_formy/flutter_formy.dart';

class FormySingleFieldBuilder<T> extends FormyBaseFieldBuilder<T, T> {
  const FormySingleFieldBuilder({
    super.key,
    required super.fieldControl,
    required super.fieldBuilder,
    super.decorateField,
    super.aditionalListener,
    super.buildWhen,
  });

  @override
  FormySingleFieldBuilderState<T> createState() =>
      FormySingleFieldBuilderState<T>();
}

class FormySingleFieldBuilderState<T> extends FormyBaseFieldBuilderState<T, T> {
  @override
  void updateFieldValue(T? newValue) {
    widget.fieldControl.update(value: newValue);
  }

  @override
  debugLog() {
    assert(() {
      final key = widget.fieldControl.key;
      debugPrint(
          '\n\x1B[36m===Rebuild number $numberOfRebuilds===============\x1B[0m');
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

      debugPrint(
          '\x1B[36m====================================================\x1B[0m\n');
      return true;
    }());
  }
}
