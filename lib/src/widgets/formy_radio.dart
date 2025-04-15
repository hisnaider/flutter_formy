import 'package:flutter/material.dart';
import 'package:flutter_formy/src/widgets/formy_option_mark_widget.dart';

class FormyRadio<T> extends FormyOptionListMarkWidget<T, T> {
  FormyRadio({
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
                Radio<T>(
                  value: item.value,
                  onChanged: item.enabled
                      ? (radioValue) {
                          onChanged(item.value);
                          onSelect?.call(radioValue);
                        }
                      : null,
                  groupValue: value,
                ),
                item.text,
              ],
            );
          },
        );

  final ValueChanged<T?>? onSelect;
}
