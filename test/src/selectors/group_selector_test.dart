import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_generic_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GroupSelector Widget', () {
    late GroupController controller;

    setUp(() {
      controller = GroupController(key: 'group1', fields: [
        FieldConfig(key: 'field1', validators: [IsRequired()]),
        FieldConfig(key: 'field2', validators: [IsRequired()]),
      ]);
    });

    testWidgets('builds with initial selected value', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GroupSelector(
          controller: controller,
          selector: (ctrl) => ctrl.isValid,
          child: (isValid) => Text(isValid ? 'Valid' : 'Invalid',
              textDirection: TextDirection.ltr),
        ),
      ));

      expect(find.text('Invalid'), findsOneWidget);
    });

    testWidgets('rebuilds when controller notifies listeners and value changes',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GroupSelector(
          controller: controller,
          selector: (ctrl) => ctrl.isValid,
          child: (isValid) => Text(isValid ? 'Valid' : 'Invalid',
              textDirection: TextDirection.ltr),
        ),
      ));

      expect(find.text('Invalid'), findsOneWidget);

      controller.field('field1').update('a cool text');
      await tester.pump();
      expect(find.text('Invalid'), findsOneWidget);
      controller.field('field2').update('a cool text');
      await tester.pump();

      expect(find.text('Valid'), findsOneWidget);
    });

    testWidgets('adds and removes listeners correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GroupSelector(
          controller: controller,
          selector: (ctrl) => ctrl.isValid,
          child: (count) => Container(),
        ),
      ));

      expect(FormyFormManager.instance.groups, contains(controller.key));

      await tester.pumpWidget(Container());
      expect(FormyFormManager.instance.groups, isNot(contains(controller.key)));
    });
  });
}
