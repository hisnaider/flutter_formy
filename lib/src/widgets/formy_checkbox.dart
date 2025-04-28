import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';

class FormyCheckbox extends StatelessWidget {
  const FormyCheckbox({
    super.key,
    required this.fieldController,
    required this.title,
    this.onChanged,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.textDirection = TextDirection.ltr,
  });
  final FieldController<bool> fieldController;
  final Widget title;
  final ValueChanged<bool?>? onChanged;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return FieldBuilder<bool>(
      field: fieldController,
      builder: (context, field, child, _) {
        return Row(
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          textDirection: textDirection,
          children: [
            Checkbox(
              value: field.value ?? false,
              onChanged: (value) {
                field.update(value!);
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
