import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FormManager: independent fields management', () {
    testWidgets('should manage single field in a single widget',
        (tester) async {
      final field1 = FieldController(key: 'test1');
      final formManager = FormManager.instance;
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
          builder: (context, field, child) => SizedBox(),
        ),
      );
      expect(formManager.fields, isNot(isEmpty));
      expect(formManager.fields.length, 1);
      expect(formManager.fieldRefCount(field1.key), 1);
      expect(formManager.fields[field1.key], field1);
      await tester.pumpWidget(SizedBox());
      await tester.pumpAndSettle();
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.fieldRefCount(field1.key), 0);
      expect(formManager.fields[field1.key], null);
    });
    testWidgets('should manage single field in multiple widgets',
        (tester) async {
      final field1 = FieldController(key: 'test1');
      final formManager = FormManager.instance;

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
              builder: (context, field, child) => SizedBox(),
            ),
            FieldBuilder(
              controller: field1,
              builder: (context, field, child) => SizedBox(),
            ),
          ],
        ),
      );
      expect(formManager.fields, isNot(isEmpty));
      expect(formManager.fields.length, 1);
      expect(formManager.fieldRefCount(field1.key), 2);
      expect(formManager.fields[field1.key], field1);
      await tester.pumpWidget(SizedBox());
      await tester.pumpAndSettle();
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.fieldRefCount(field1.key), 0);
      expect(formManager.fields[field1.key], null);
    });
    testWidgets('should manage two fields in multiple widgets', (tester) async {
      final field1 = FieldController(key: 'test1');
      final field2 = FieldController(key: 'test2');
      final formManager = FormManager.instance;
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
              builder: (context, field, child) => SizedBox(),
            ),
            FieldBuilder(
              controller: field1,
              builder: (context, field, child) => SizedBox(),
            ),
            FieldBuilder(
              controller: field2,
              builder: (context, field, child) => SizedBox(),
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
      await tester.pumpWidget(SizedBox());
      await tester.pumpAndSettle();
      expect(formManager.fields, isEmpty);
      expect(formManager.fields.length, 0);
      expect(formManager.fieldRefCount(field1.key), 0);
      expect(formManager.fieldRefCount(field2.key), 0);
      expect(formManager.fields[field1.key], null);
      expect(formManager.fields[field2.key], null);
    });
  });

  group('FormManager: groups management', () {
    testWidgets('should manage a single group', (tester) async {
      final group = GroupController(key: 'test1', fields: [
        FieldConfig(key: 'field1'),
        FieldConfig(key: 'field2'),
      ]);
      final formManager = FormManager.instance;
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
              builder: (context, field, child) => SizedBox(),
            ),
            FieldBuilder(
              controller: group.field('field2'),
              builder: (context, field, child) => SizedBox(),
            ),
            GroupBuilder(
              controller: group,
              builder: (context, group, child) => SizedBox(),
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
      await tester.pumpWidget(SizedBox());
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
        FieldConfig(key: 'field1'),
        FieldConfig(key: 'field2'),
      ]);
      final formManager = FormManager.instance;
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
              child: (value) => SizedBox(),
            ),
            FieldBuilder(
              controller: group.field('field1'),
              builder: (context, field, child) => SizedBox(),
            ),
            FieldBuilder(
              controller: group.field('field2'),
              builder: (context, field, child) => SizedBox(),
            ),
            GroupBuilder(
              controller: group,
              builder: (context, group, child) => SizedBox(),
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
      await tester.pumpWidget(SizedBox());
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
        FieldConfig(key: 'field1'),
        FieldConfig(key: 'field2'),
      ]);
      final group2 = GroupController(key: 'test2', fields: [
        FieldConfig(key: 'field3'),
        FieldConfig(key: 'field4'),
      ]);
      final formManager = FormManager.instance;
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
                  child: (value) => SizedBox(),
                ),
                FieldBuilder(
                  controller: group.field('field1'),
                  builder: (context, field, child) => SizedBox(),
                ),
                FieldBuilder(
                  controller: group.field('field2'),
                  builder: (context, field, child) => SizedBox(),
                ),
                GroupBuilder(
                  controller: group,
                  builder: (context, group, child) => SizedBox(),
                )
              ],
            ),
            Column(
              children: [
                FieldBuilder(
                  controller: group.field('field1'),
                  builder: (context, field, child) => SizedBox(),
                ),
                FieldBuilder(
                  controller: group.field('field2'),
                  builder: (context, field, child) => SizedBox(),
                ),
                GroupBuilder(
                  controller: group2,
                  builder: (context, group, child) => SizedBox(),
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
      await tester.pumpWidget(SizedBox());
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
