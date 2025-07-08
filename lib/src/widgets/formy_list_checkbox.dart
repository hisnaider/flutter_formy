import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/field_builder.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';
import 'package:flutter_formy/src/widgets/formy_option_mark_widget.dart';

class FormyListCheckbox<T> extends FormyOptionListMarkWidget<T, List<T>> {
  FormyListCheckbox({
    super.key,
    required super.fieldController,
    required super.itemsEntry,
    required super.layout,
    super.title,
    this.onSelect,
    super.error,
  }) : super(
          builder: FieldBuilder<List<T>>(
            controller: fieldController,
            buildWhen: (oldState, currentState) =>
                oldState.value?.length != currentState.value?.length,
            builder: (context, field, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (child != null) child,
                  Visibility(
                    visible: field.firstError != null,
                    child: error?.call(field.firstError) ??
                        Text(
                          field.firstError ?? "",
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
                                    (field.state.value ?? []).contains(e.value),
                                onChanged: e.enabled
                                    ? (value) {
                                        final List<T> newValue = List<T>.from(
                                            field.state.value ?? []);
                                        if (value ?? false) {
                                          newValue.add(e.value);
                                        } else {
                                          newValue.remove(e.value);
                                        }
                                        field.update(newValue);
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
            child: title,
          ),
        );

  final ValueChanged<bool>? onSelect;
}
