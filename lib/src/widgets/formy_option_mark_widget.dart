import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/item_entry.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/widgets/builders/formy_list_field_builder.dart';

class FormyOptionListMarkWidget<ValueType, FieldType> extends StatelessWidget {
  const FormyOptionListMarkWidget({
    super.key,
    required this.fieldControl,
    this.title,
    required this.itemsEntry,
    required this.layout,
    this.error,
    required this.builder,
  });
  final FieldControl<FieldType> fieldControl;

  final Widget? title;
  final List<ItemEntry<ValueType>> itemsEntry;
  final Widget Function(List<Widget> children) layout;
  final Widget Function(ValidationResult? validation)? error;
  final FormyBaseFieldBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder;
  }
}
