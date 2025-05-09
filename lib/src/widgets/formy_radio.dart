import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';

class FormyRadio<T> extends FormyOptionListMarkWidget<T, T> {
  FormyRadio({
    super.key,
    required super.fieldController,
    required super.itemsEntry,
    required super.layout,
    super.title,
    this.onSelect,
    super.error,
  }) : super(
          builder: FieldBuilder<T>(
            field: fieldController,
            buildWhen: (oldState, currentState) =>
                oldState.value != currentState.value,
            builder: (context, field, child, _) {
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
                  layout(
                    itemsEntry.map<Widget>((e) {
                      final Widget radio = Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio<T>(
                            value: e.value,
                            onChanged: e.enabled
                                ? (radioValue) {
                                    field.update(e.value);
                                    onSelect?.call(radioValue);
                                  }
                                : null,
                            groupValue: field.state.value,
                          ),
                          e.text,
                        ],
                      );
                      return e.child != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [radio, e.child!],
                            )
                          : radio;
                    }).toList(),
                  ),
                ],
              );
            },
            child: title,
          ),
        );
  final ValueChanged<T?>? onSelect;
}
