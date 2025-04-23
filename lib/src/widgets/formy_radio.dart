import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';

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
          builder: FormySingleFieldBuilder<T>(
            fieldControl: fieldControl,
            fieldBuilder:
                (context, fieldState, firstValidation, onUpdateField) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null) title,
                  Visibility(
                    visible: firstValidation != null,
                    child: error?.call(firstValidation) ??
                        Text(
                          firstValidation?.key ?? "",
                          style:
                              Theme.of(context).inputDecorationTheme.errorStyle,
                        ),
                  ),
                  layout(
                    itemsEntry
                        .map<Widget>(
                          (e) => Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio<T>(
                                value: e.value,
                                onChanged: e.enabled
                                    ? (radioValue) {
                                        onUpdateField(e.value);
                                        onSelect?.call(radioValue);
                                      }
                                    : null,
                                groupValue: fieldState.value,
                              ),
                              e.text,
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
            },
          ),
        );
  final ValueChanged<T?>? onSelect;
}
