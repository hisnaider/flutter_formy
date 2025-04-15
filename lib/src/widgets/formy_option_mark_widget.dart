import 'package:flutter/material.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/models/item_entry.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/widgets/formy_field_builder.dart';

class FormyOptionListMarkWidget<ItemType, FieldType> extends StatelessWidget {
  const FormyOptionListMarkWidget({
    super.key,
    required this.fieldControl,
    required this.optionMarkWidget,
    this.title,
    required this.itemsEntry,
    required this.layout,
    this.error,
  });
  final FieldControl<FieldType> fieldControl;
  final Widget Function(
    FieldType? value,
    void Function(ItemType value) onChanged,
    bool touched,
    ItemEntry<ItemType> item,
  ) optionMarkWidget;
  final Widget? title;
  final List<ItemEntry<ItemType>> itemsEntry;
  final Widget Function(List<Widget> children) layout;
  final Widget Function(ValidationResult? validation)? error;

  @override
  Widget build(BuildContext context) {
    return FormyFieldBuilder(
      fieldControl: fieldControl,
      buildWhen: (oldState, currentState) =>
          oldState.value != currentState.value,
      builder: (context, value, onChanged, firstValidationResult,
          validationResult, touched) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) title!,
            if (error != null) error!(firstValidationResult),
            layout(
              itemsEntry
                  .map<Widget>((e) => optionMarkWidget(
                        value,
                        onChanged,
                        touched,
                        e,
                      ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
