import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/field_instace_management/form_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  testWidgets('FieldBuilder: call insert, remove and adds/removes listener',
      (tester) async {
    final controller = FieldController(key: 'test');
    final int createdTimestamp = controller.createdTimestamp;
    await tester.pumpWidget(
      MaterialApp(
        home: FieldBuilder(
          field: controller,
          builder: (_, __, ___) {
            return const SizedBox();
          },
        ),
      ),
    );
    expect(FormManager.instance.fields, isNotEmpty);
    expect(FormManager.instance.fields.containsKey(createdTimestamp), isTrue);
    expect(FormManager.instance.fields[createdTimestamp], equals(controller));
    await tester.pumpWidget(const SizedBox());
    expect(FormManager.instance.fields, isEmpty);
  });
  testWidgets('FieldBuilder: build with initial state and updates on tap',
      (tester) async {
    final controller = FieldController(key: 'test');
    await tester.pumpWidget(
      MaterialApp(
        home: FieldBuilder(
          field: controller,
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
          field: controller,
          child: Text('child test'),
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
