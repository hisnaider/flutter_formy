import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/field_builder.dart';
import 'package:flutter_formy/src/manager/form_manager.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FieldBuilder: call insert, remove and adds/removes listener',
      (tester) async {
    final controller = FieldController(key: 'test');
    final String key = controller.key;
    await tester.pumpWidget(
      MaterialApp(
        home: FieldBuilder(
          controller: controller,
          builder: (_, __, ___) {
            return const SizedBox();
          },
        ),
      ),
    );
    expect(FormyFormManager.instance.groups, isEmpty);
    expect(FormyFormManager.instance.fields, isNotEmpty);
    expect(FormyFormManager.instance.fields.containsKey(key), isTrue);
    expect(FormyFormManager.instance.fields[key], equals(controller));
    await tester.pumpWidget(const SizedBox());
    expect(FormyFormManager.instance.groups, isEmpty);
    expect(FormyFormManager.instance.fields, isEmpty);
  });
  testWidgets('FieldBuilder: build with initial state and updates on tap',
      (tester) async {
    final controller = FieldController(key: 'test');
    await tester.pumpWidget(
      MaterialApp(
        home: FieldBuilder(
          controller: controller,
          builder: (context, field, child) {
            return ElevatedButton(
                onPressed: () {
                  field.update((field.value ?? 0) + 1);
                },
                child: Text('count number: ${field.value ?? 0}'));
          },
        ),
      ),
    );
    expect(find.text('count number: 0'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('count number: 1'), findsOneWidget);
    expect(find.text('count number: 0'), findsNothing);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('count number: 2'), findsOneWidget);
  });
  testWidgets('FieldBuilder: render child', (tester) async {
    final controller = FieldController(key: 'test');
    await tester.pumpWidget(
      MaterialApp(
        home: FieldBuilder(
          controller: controller,
          child: const Text('child test'),
          builder: (context, field, child) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      field.update((field.value ?? 0) + 1);
                    },
                    child: Text('count number: ${field.value ?? 0}')),
                child!,
              ],
            );
          },
        ),
      ),
    );
    expect(find.text('child test'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('child test'), findsOneWidget);
  });
}
