import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GroupBuilder: call insert, remove and adds/removes listener',
      (tester) async {
    final controller = GroupController(key: 'test', fields: [
      FieldConfig(key: 'fieldTest1', validators: [IsRequired()]),
      FieldConfig(key: 'fieldTest2', validators: [IsRequired()])
    ]);
    final String key = controller.key;
    await tester.pumpWidget(
      MaterialApp(
        home: GroupBuilder(
          field: controller,
          builder: (_, __, ___) {
            return const SizedBox();
          },
        ),
      ),
    );
    expect(FormManager.instance.fields, isEmpty);
    expect(FormManager.instance.groups, isNotEmpty);
    expect(FormManager.instance.groups.containsKey(key), isTrue);
    expect(FormManager.instance.groups[key], equals(controller));
    await tester.pumpWidget(const SizedBox());
    expect(FormManager.instance.groups, isEmpty);
    expect(FormManager.instance.fields, isEmpty);
  });
  testWidgets('GroupBuilder: build with initial state and updates when valid',
      (tester) async {
    final group = GroupController(key: 'test', fields: [
      FieldConfig(key: 'fieldTest1', validators: [IsRequired()]),
      FieldConfig(key: 'fieldTest2', validators: [IsRequired()])
    ]);
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            FieldBuilder(
              field: group.field('fieldTest1'),
              builder: (context, field, child) {
                return ElevatedButton(
                  key: const Key('button1'),
                  onPressed: () {
                    field.update(!(field.value ?? false));
                  },
                  child: const SizedBox(),
                );
              },
            ),
            FieldBuilder(
              field: group.field('fieldTest2'),
              builder: (context, field, child) {
                return ElevatedButton(
                  key: const Key('button2'),
                  onPressed: () {
                    field.update(!(field.value ?? false));
                  },
                  child: const SizedBox(),
                );
              },
            ),
            GroupBuilder(
              field: group,
              builder: (context, group, child) {
                return Text('Group is valid: ${group.state.isValid}');
              },
            ),
          ],
        ),
      ),
    );
    expect(find.text('Group is valid: false'), findsOneWidget);
    await tester.tap(find.byKey(const Key('button1')));
    await tester.pump();
    expect(find.text('Group is valid: false'), findsOneWidget);
    await tester.tap(find.byKey(const Key('button2')));
    await tester.pump();
    expect(find.text('Group is valid: true'), findsOneWidget);
    await tester.tap(find.byKey(const Key('button2')));
    await tester.pump();
    expect(find.text('Group is valid: false'), findsOneWidget);
    await tester.tap(find.byKey(const Key('button1')));
    await tester.pump();
    expect(find.text('Group is valid: false'), findsOneWidget);
  });
  testWidgets('FieldBuilder: render child', (tester) async {
    final group = GroupController(key: 'test', fields: [
      FieldConfig(key: 'fieldTest1', validators: [IsRequired()]),
    ]);
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            FieldBuilder(
              field: group.field('fieldTest1'),
              builder: (context, field, child) {
                return ElevatedButton(
                  key: const Key('button1'),
                  onPressed: () {
                    field.update(!(field.value ?? false));
                  },
                  child: const SizedBox(),
                );
              },
            ),
            GroupBuilder(
              field: group,
              child: const Text('child test'),
              builder: (context, group, child) {
                return Column(
                  children: [
                    Text('Group is valid: ${group.state.isValid}'),
                    child!,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
    expect(find.text('child test'), findsOneWidget);
    await tester.tap(find.byKey(const Key('button1')));
    await tester.pump();
    expect(find.text('child test'), findsOneWidget);
  });
}
