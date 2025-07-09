import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/field_builder.dart';
import 'package:flutter_formy/src/manager/form_manager.dart';
import 'package:flutter_formy/src/builder/group_builder.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';
import 'package:flutter_formy/src/validators/generic_validators/is_required_validator.dart';
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
          controller: controller,
          builder: (_, __, ___) {
            return const SizedBox();
          },
        ),
      ),
    );
    expect(FormyFormManager.instance.fields, isEmpty);
    expect(FormyFormManager.instance.groups, isNotEmpty);
    expect(FormyFormManager.instance.groups.containsKey(key), isTrue);
    expect(FormyFormManager.instance.groups[key], equals(controller));
    await tester.pumpWidget(const SizedBox());
    expect(FormyFormManager.instance.groups, isEmpty);
    expect(FormyFormManager.instance.fields, isEmpty);
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
              controller: group.field('fieldTest1'),
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
              controller: group.field('fieldTest2'),
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
              controller: group,
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
              controller: group.field('fieldTest1'),
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
              controller: group,
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
