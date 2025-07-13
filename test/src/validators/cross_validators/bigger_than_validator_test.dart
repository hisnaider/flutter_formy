import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_cross_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BiggerThanValidator', () {
    test('should return valid when controller value is null', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<int>(key: 'num1', initialValue: 5),
          FieldConfig<int>(
              key: 'num2',
              initialValue: null,
              validators: [BiggerThanValidator(otherField: 'num1')]),
        ],
      );

      final result = group.field('num2').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'biggerThan');
      expect(result.message, 'biggerThan');
    });

    group('String validation', () {
      test(
          'should return valid when string length is greater than or equal to other string length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<String>(key: 'str1', initialValue: 'hi'),
            FieldConfig<String>(
                key: 'str2',
                initialValue: 'hello',
                validators: [BiggerThanValidator(otherField: 'str1')]),
          ],
        );

        final result = group.field('str2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test('should return valid when string length equals other string length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<String>(key: 'str1', initialValue: 'hello'),
            FieldConfig<String>(
                key: 'str2',
                initialValue: 'world',
                validators: [BiggerThanValidator(otherField: 'str1')]),
          ],
        );

        final result = group.field('str2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test(
          'should return invalid when string length is less than other string length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<String>(key: 'str1', initialValue: 'hello world'),
            FieldConfig<String>(
                key: 'str2',
                initialValue: 'hi',
                validators: [BiggerThanValidator(otherField: 'str1')]),
          ],
        );

        final result = group.field('str2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
      });
    });

    group('List validation', () {
      test(
          'should return valid when list length is greater than or equal to other list length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<List<int>>(key: 'list1', initialValue: [1, 2, 3]),
            FieldConfig<List<int>>(
                key: 'list2',
                initialValue: [1, 2, 3, 4, 5],
                validators: [BiggerThanValidator(otherField: 'list1')]),
          ],
        );

        final result = group.field('list2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test(
          'should return invalid when list length is less than other list length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<List<int>>(
                key: 'list1', initialValue: [1, 2, 3, 4, 5]),
            FieldConfig<List<int>>(
                key: 'list2',
                initialValue: [1, 2],
                validators: [BiggerThanValidator(otherField: 'list1')]),
          ],
        );

        final result = group.field('list2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
      });
    });

    group('Map validation', () {
      test(
          'should return valid when map length is greater than or equal to other map length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Map<String, int>>(
                key: 'map1', initialValue: {'x': 1, 'y': 2}),
            FieldConfig<Map<String, int>>(
                key: 'map2',
                initialValue: {'a': 1, 'b': 2, 'c': 3},
                validators: [BiggerThanValidator(otherField: 'map1')]),
          ],
        );

        final result = group.field('map2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test(
          'should return invalid when map length is less than other map length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Map<String, int>>(
                key: 'map1', initialValue: {'x': 1, 'y': 2, 'z': 3}),
            FieldConfig<Map<String, int>>(
                key: 'map2',
                initialValue: {'a': 1},
                validators: [BiggerThanValidator(otherField: 'map1')]),
          ],
        );

        final result = group.field('map2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
      });
    });

    group('Set validation', () {
      test(
          'should return valid when set length is greater than or equal to other set length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Set<int>>(key: 'set1', initialValue: {1, 2, 3}),
            FieldConfig<Set<int>>(
                key: 'set2',
                initialValue: {1, 2, 3, 4, 5},
                validators: [BiggerThanValidator(otherField: 'set1')]),
          ],
        );

        final result = group.field('set2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test(
          'should return invalid when set length is less than other set length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Set<int>>(
                key: 'set1', initialValue: {1, 2, 3, 4, 5}),
            FieldConfig<Set<int>>(
                key: 'set2',
                initialValue: {1, 2},
                validators: [BiggerThanValidator(otherField: 'set1')]),
          ],
        );

        final result = group.field('set2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
      });
    });

    group('Number validation', () {
      test(
          'should return valid when number is greater than or equal to other number',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 5),
            FieldConfig<int>(
                key: 'num2',
                initialValue: 10,
                validators: [BiggerThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test('should return valid when number equals other number', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 10),
            FieldConfig<int>(
                key: 'num2',
                initialValue: 10,
                validators: [BiggerThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test('should return invalid when number is less than other number', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 10),
            FieldConfig<int>(
                key: 'num2',
                initialValue: 5,
                validators: [BiggerThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
      });

      test('should work with double values', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<double>(key: 'num1', initialValue: 15.7),
            FieldConfig<double>(
                key: 'num2',
                initialValue: 10.5,
                validators: [BiggerThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
      });
    });

    group('Unsupported types', () {
      test('should return invalid for unsupported types', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            FieldConfig<DateTime>(key: 'date1', initialValue: DateTime.now()),
            FieldConfig<DateTime>(
                key: 'date2',
                initialValue: DateTime.now(),
                validators: [BiggerThanValidator(otherField: 'date1')]),
          ],
        );

        final result = group.field('date2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
      });
    });

    group('Custom message', () {
      test('should use custom message when provided', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 10),
            FieldConfig<int>(key: 'num2', initialValue: 5, validators: [
              BiggerThanValidator(
                  otherField: 'num1',
                  message: 'Value must not be less than other field')
            ]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
        expect(result.message, 'Value must not be less than other field');
      });
    });

    group('Edge cases', () {
      test('should handle empty string', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<String>(key: 'str1', initialValue: ''),
            FieldConfig<String>(
                key: 'str2',
                initialValue: 'hello',
                validators: [BiggerThanValidator(otherField: 'str1')]),
          ],
        );

        final result = group.field('str2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test('should handle empty list', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<List<int>>(key: 'list1', initialValue: []),
            FieldConfig<List<int>>(
                key: 'list2',
                initialValue: [1, 2, 3],
                validators: [BiggerThanValidator(otherField: 'list1')]),
          ],
        );

        final result = group.field('list2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test('should handle empty map', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Map<String, int>>(key: 'map1', initialValue: {}),
            FieldConfig<Map<String, int>>(
                key: 'map2',
                initialValue: {'a': 1},
                validators: [BiggerThanValidator(otherField: 'map1')]),
          ],
        );

        final result = group.field('map2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test('should handle empty set', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Set<int>>(key: 'set1', initialValue: <int>{}),
            FieldConfig<Set<int>>(
                key: 'set2',
                initialValue: {1, 2, 3},
                validators: [BiggerThanValidator(otherField: 'set1')]),
          ],
        );

        final result = group.field('set2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test('should handle negative numbers', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: -10),
            FieldConfig<int>(
                key: 'num2',
                initialValue: -5,
                validators: [BiggerThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test('should handle zero values', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 0),
            FieldConfig<int>(
                key: 'num2',
                initialValue: 0,
                validators: [BiggerThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test('should handle mixed types comparison', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 10),
            FieldConfig<double>(
                key: 'num2',
                initialValue: 7.5,
                validators: [BiggerThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
      });

      test('should handle when both values are empty collections', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<List<int>>(key: 'list1', initialValue: []),
            FieldConfig<List<int>>(
                key: 'list2',
                initialValue: [],
                validators: [BiggerThanValidator(otherField: 'list1')]),
          ],
        );

        final result = group.field('list2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'biggerThan');
      });

      test(
          'should handle when reference field has smaller value but validator should fail',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<String>(key: 'str1', initialValue: 'hello world'),
            FieldConfig<String>(
                key: 'str2',
                initialValue: 'hi',
                validators: [BiggerThanValidator(otherField: 'str1')]),
          ],
        );

        final result = group.field('str2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'biggerThan');
      });
    });
  });
}
