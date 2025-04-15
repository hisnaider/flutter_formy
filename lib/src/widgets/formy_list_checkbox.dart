import 'package:flutter/material.dart';
import 'package:flutter_formy/src/widgets/formy_option_mark_widget.dart';

class FormyListCheckbox<T> extends FormyOptionListMarkWidget<T, List<T>> {
  FormyListCheckbox({
    super.key,
    required super.fieldControl,
    required super.itemsEntry,
    required super.layout,
    super.title,
    this.onSelect,
    super.error,
  }) : super(
          optionMarkWidget: (value, onChanged, touched, item) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: (value ?? []).contains(item.value),
                    onChanged: item.enabled
                        ? (value) {
                            onChanged(item.value);
                            onSelect?.call(value ?? false);
                          }
                        : null),
                item.text,
              ],
            );
          },
        );

  final ValueChanged<bool>? onSelect;
}
