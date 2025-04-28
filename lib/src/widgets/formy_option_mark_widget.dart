import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';

class FormyOptionListMarkWidget<ValueType, FieldType> extends StatelessWidget {
  const FormyOptionListMarkWidget({
    super.key,
    required this.fieldController,
    this.title,
    required this.itemsEntry,
    required this.layout,
    this.error,
    required this.builder,
  });
  final FieldController<FieldType> fieldController;

  final Widget? title;
  final List<ItemEntry<ValueType>> itemsEntry;
  final Widget Function(List<Widget> children) layout;
  final Widget Function(String? validation)? error;
  final FieldBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder;
  }
}
