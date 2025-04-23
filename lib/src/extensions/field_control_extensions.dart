import 'package:flutter_formy/src/models/field_control.dart';

extension FieldControlX<T> on FieldControl<T> {
  String? get firstError => state.validationResults
      .where((v) => !v.isValid)
      .map((v) => v.key)
      .firstOrNull;
  List<String> get errorKeys => state.validationResults
      .where((v) => !v.isValid)
      .map((v) => v.key)
      .toList();
  bool get dirty => state.dirty;
  bool get touched => state.touched;
  bool get valid => state.validationResults.every((e) => e.isValid);
}
