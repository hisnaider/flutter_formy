import 'package:flutter/material.dart';
import 'package:flutter_formy/src/models/field_control.dart';
import 'package:flutter_formy/src/widgets/builders/formy_single_field_builder.dart';

class FormyCheckbox extends StatelessWidget {
  const FormyCheckbox({
    super.key,
    required this.fieldControl,
    required this.title,
    this.onChanged,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.textDirection = TextDirection.ltr,
  });
  final FieldControl<bool> fieldControl;
  final Widget title;
  final ValueChanged<bool?>? onChanged;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return FormySingleFieldBuilder<bool>(
      fieldControl: fieldControl,
      buildWhen: (oldState, currentState) => true,
      fieldBuilder: (context, fieldState, firstValidation, onUpdateFieldd) {
        return Row(
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          textDirection: textDirection,
          children: [
            Checkbox(
              value: fieldState.value ?? false,
              onChanged: (value) {
                onUpdateFieldd(value!);
                onChanged?.call(value);
              },
            ),
            title,
          ],
        );
      },
    );
  }
}
