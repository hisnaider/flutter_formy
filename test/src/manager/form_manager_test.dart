import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/field_builder.dart';
import 'package:flutter_formy/src/manager/form_manager.dart';
import 'package:flutter_formy/src/builder/group_builder.dart';
import 'package:flutter_formy/src/models/controller/field_controller.dart';
import 'package:flutter_formy/src/selectors/group_selector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FormyFormManager: independent fields management', () {
    testWidgets('should manage single field in a single widget',
        (tester) async {
      final field1 = FieldController(key: 'test1');
      final formManager = FormyFormManager.instance;
      addTearDown(() {
        formManager.forceReset();
      });

      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.fieldRefCount(field1.key), 0);
      expect(formManager.fields[field1.key], null);
      await tester.pumpWidget(
        FieldBuilder(
          controller: field1,
          builder: (context, field, child) => const SizedBox(),
        ),
      );
      expect(formManager.fields, isNot(isEmpty));
      expect(formManager.fields.length, 1);
      expect(formManager.fieldRefCount(field1.key), 1);
      expect(formManager.fields[field1.key], field1);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.fieldRefCount(field1.key), 0);
      expect(formManager.fields[field1.key], null);
    });
    testWidgets('should manage single field in multiple widgets',
        (tester) async {
      final field1 = FieldController(key: 'test1');
      final formManager = FormyFormManager.instance;

      addTearDown(() {
        formManager.forceReset();
      });
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.fieldRefCount(field1.key), 0);
      expect(formManager.fields[field1.key], null);
      await tester.pumpWidget(
        Column(
          children: [
            FieldBuilder(
              controller: field1,
              builder: (context, field, child) => const SizedBox(),
            ),
            FieldBuilder(
              controller: field1,
              builder: (context, field, child) => const SizedBox(),
            ),
          ],
        ),
      );
      expect(formManager.fields, isNot(isEmpty));
      expect(formManager.fields.length, 1);
      expect(formManager.fieldRefCount(field1.key), 2);
      expect(formManager.fields[field1.key], field1);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.fieldRefCount(field1.key), 0);
      expect(formManager.fields[field1.key], null);
    });
    testWidgets('should manage two fields in multiple widgets', (tester) async {
      final field1 = FieldController(key: 'test1');
      final field2 = FieldController(key: 'test2');
      final formManager = FormyFormManager.instance;
      addTearDown(() {
        formManager.forceReset();
      });
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.fieldRefCount(field1.key), 0);
      expect(formManager.fieldRefCount(field2.key), 0);
      expect(formManager.fields[field1.key], null);
      expect(formManager.fields[field2.key], null);
      await tester.pumpWidget(
        Column(
          children: [
            FieldBuilder(
              controller: field1,
              builder: (context, field, child) => const SizedBox(),
            ),
            FieldBuilder(
              controller: field1,
              builder: (context, field, child) => const SizedBox(),
            ),
            FieldBuilder(
              controller: field2,
              builder: (context, field, child) => const SizedBox(),
            ),
          ],
        ),
      );
      expect(formManager.fields, isNot(isEmpty));
      expect(formManager.fields.length, 2);
      expect(formManager.fieldRefCount(field1.key), 2);
      expect(formManager.fieldRefCount(field2.key), 1);
      expect(formManager.fields[field1.key], field1);
      expect(formManager.fields[field2.key], field2);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.fieldRefCount(field1.key), 0);
      expect(formManager.fieldRefCount(field2.key), 0);
      expect(formManager.fields[field1.key], null);
      expect(formManager.fields[field2.key], null);
    });
  });

  group('FormyFormManager: groups management', () {
    testWidgets('should manage a single group', (tester) async {
      final group = GroupController(key: 'test1', fields: [
        const FieldConfig(key: 'field1'),
        const FieldConfig(key: 'field2'),
      ]);
      final formManager = FormyFormManager.instance;
      addTearDown(() {
        formManager.forceReset();
      });

      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.groups, isEmpty);
      expect(formManager.groups.length, 0);
      expect(formManager.groupRefCount(group.key), 0);
      expect(formManager.getGroup(group.key), null);
      await tester.pumpWidget(
        Column(
          children: [
            FieldBuilder(
              controller: group.field('field1'),
              builder: (context, field, child) => const SizedBox(),
            ),
            FieldBuilder(
              controller: group.field('field2'),
              builder: (context, field, child) => const SizedBox(),
            ),
            GroupBuilder(
              controller: group,
              builder: (context, group, child) => const SizedBox(),
            )
          ],
        ),
      );
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.groups, isNot(isEmpty));
      expect(formManager.groups.length, 1);
      expect(formManager.groupRefCount(group.key), 1);
      expect(formManager.getGroup(group.key), group);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.groups, isEmpty);
      expect(formManager.groups.length, 0);
      expect(formManager.groupRefCount(group.key), 0);
      expect(formManager.getGroup(group.key), null);
    });
    testWidgets('should manage single group in multiple widgets',
        (tester) async {
      final group = GroupController(key: 'test1', fields: [
        const FieldConfig(key: 'field1'),
        const FieldConfig(key: 'field2'),
      ]);
      final formManager = FormyFormManager.instance;
      addTearDown(() {
        formManager.forceReset();
      });

      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.groups, isEmpty);
      expect(formManager.groups.length, 0);
      expect(formManager.groupRefCount(group.key), 0);
      expect(formManager.getGroup(group.key), null);
      await tester.pumpWidget(
        Column(
          children: [
            GroupSelector(
              controller: group,
              selector: (value) => value.state.errorMessages,
              child: (value) => const SizedBox(),
            ),
            FieldBuilder(
              controller: group.field('field1'),
              builder: (context, field, child) => const SizedBox(),
            ),
            FieldBuilder(
              controller: group.field('field2'),
              builder: (context, field, child) => const SizedBox(),
            ),
            GroupBuilder(
              controller: group,
              builder: (context, group, child) => const SizedBox(),
            )
          ],
        ),
      );
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.groups, isNot(isEmpty));
      expect(formManager.groups.length, 1);
      expect(formManager.groupRefCount(group.key), 2);
      expect(formManager.getGroup(group.key), group);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.groups, isEmpty);
      expect(formManager.groups.length, 0);
      expect(formManager.groupRefCount(group.key), 0);
      expect(formManager.getGroup(group.key), null);
    });
    testWidgets('should manage two groups in multiple widgets', (tester) async {
      final group = GroupController(key: 'test1', fields: [
        const FieldConfig(key: 'field1'),
        const FieldConfig(key: 'field2'),
      ]);
      final group2 = GroupController(key: 'test2', fields: [
        const FieldConfig(key: 'field3'),
        const FieldConfig(key: 'field4'),
      ]);
      final formManager = FormyFormManager.instance;
      addTearDown(() {
        formManager.forceReset();
      });

      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.groups, isEmpty);
      expect(formManager.groups.length, 0);
      expect(formManager.groupRefCount(group.key), 0);
      expect(formManager.getGroup(group.key), null);
      expect(formManager.groupRefCount(group2.key), 0);
      expect(formManager.getGroup(group2.key), null);
      await tester.pumpWidget(
        Column(
          children: [
            Column(
              children: [
                GroupSelector(
                  controller: group,
                  selector: (value) => value.state.errorMessages,
                  child: (value) => const SizedBox(),
                ),
                FieldBuilder(
                  controller: group.field('field1'),
                  builder: (context, field, child) => const SizedBox(),
                ),
                FieldBuilder(
                  controller: group.field('field2'),
                  builder: (context, field, child) => const SizedBox(),
                ),
                GroupBuilder(
                  controller: group,
                  builder: (context, group, child) => const SizedBox(),
                )
              ],
            ),
            Column(
              children: [
                FieldBuilder(
                  controller: group.field('field1'),
                  builder: (context, field, child) => const SizedBox(),
                ),
                FieldBuilder(
                  controller: group.field('field2'),
                  builder: (context, field, child) => const SizedBox(),
                ),
                GroupBuilder(
                  controller: group2,
                  builder: (context, group, child) => const SizedBox(),
                )
              ],
            ),
          ],
        ),
      );
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.groups, isNot(isEmpty));
      expect(formManager.groups.length, 2);
      expect(formManager.groupRefCount(group.key), 2);
      expect(formManager.getGroup(group.key), group);
      expect(formManager.groupRefCount(group2.key), 1);
      expect(formManager.getGroup(group2.key), group2);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.groups, isEmpty);
      expect(formManager.groups.length, 0);
      expect(formManager.groupRefCount(group.key), 0);
      expect(formManager.getGroup(group.key), null);
      expect(formManager.groupRefCount(group2.key), 0);
      expect(formManager.getGroup(group2.key), null);
    });
  });
}
