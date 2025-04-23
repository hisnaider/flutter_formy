import 'package:flutter/material.dart';
import 'package:flutter_formy/src/widgets/builders/formy_list_field_builder.dart';
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
          builder: FormyListFieldBuilder<T, List<T>>(
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
                  layout(itemsEntry
                      .map<Widget>(
                        (e) => Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                value:
                                    (fieldState.value ?? []).contains(e.value),
                                onChanged: e.enabled
                                    ? (value) {
                                        onUpdateField(e.value);
                                        onSelect?.call(value ?? false);
                                      }
                                    : null),
                            e.text,
                          ],
                        ),
                      )
                      .toList()),
                ],
              );
            },
          ),
        );

  final ValueChanged<bool>? onSelect;
}
