import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_generic_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FieldSelector Widget', () {
    late FieldController controller;

    setUp(() {
      controller = FieldController(key: 'field1', validators: [IsRequired()]);
    });

    testWidgets('builds with initial selected value', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: FieldSelector(
          controller: controller,
          selector: (ctrl) => ctrl.valid,
          child: (isValid) => Text(isValid ? 'Valid' : 'Invalid',
              textDirection: TextDirection.ltr),
        ),
      ));
      expect(find.text('Invalid'), findsOneWidget);
    });

    testWidgets('rebuilds when controller notifies listeners and value changes',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: FieldSelector(
          controller: controller,
          selector: (ctrl) => ctrl.valid,
          child: (isValid) => Text(isValid ? 'Valid' : 'Invalid',
              textDirection: TextDirection.ltr),
        ),
      ));

      expect(find.text('Invalid'), findsOneWidget);

      controller.update('a cool text');

      await tester.pump();

      expect(find.text('Valid'), findsOneWidget);
    });

    testWidgets('adds and removes listeners correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: FieldSelector(
          controller: controller,
          selector: (ctrl) => ctrl.valid,
          child: (isValid) => Container(),
        ),
      ));

      // At this point, listener should have been added
      expect(FormyFormManager.instance.fields, contains(controller.key));

      // Remove the widget to trigger dispose and removal of listener
      await tester.pumpWidget(Container());
      expect(FormyFormManager.instance.fields, isNot(contains(controller.key)));
    });
  });
}
