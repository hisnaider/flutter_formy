import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_cross_validators.dart';
import 'package:flutter_formy/src/validators/cross_validators/less_than_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LessThanValidator', () {
    test('should return valid when controller value is null', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<int>(key: 'num1', initialValue: 5),
          FieldConfig<int>(
              key: 'num2',
              initialValue: null,
              validators: [LessThanValidator(otherField: 'num1')]),
        ],
      );

      final result = group.field('num2').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'lessThan');
      expect(result.message, 'lessThan');
    });

    group('String validation', () {
      test(
          'should return valid when string length is less than or equal to other string length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<String>(key: 'str1', initialValue: 'hello'),
            FieldConfig<String>(
                key: 'str2',
                initialValue: 'hi',
                validators: [LessThanValidator(otherField: 'str1')]),
          ],
        );

        final result = group.field('str2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
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
                validators: [LessThanValidator(otherField: 'str1')]),
          ],
        );

        final result = group.field('str2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test(
          'should return invalid when string length is greater than other string length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<String>(key: 'str1', initialValue: 'hi'),
            FieldConfig<String>(
                key: 'str2',
                initialValue: 'hello world',
                validators: [LessThanValidator(otherField: 'str1')]),
          ],
        );

        final result = group.field('str2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'lessThan');
      });
    });

    group('List validation', () {
      test(
          'should return valid when list length is less than or equal to other list length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<List<int>>(
                key: 'list1', initialValue: [1, 2, 3, 4, 5]),
            FieldConfig<List<int>>(
                key: 'list2',
                initialValue: [1, 2, 3],
                validators: [LessThanValidator(otherField: 'list1')]),
          ],
        );

        final result = group.field('list2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test(
          'should return invalid when list length is greater than other list length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<List<int>>(key: 'list1', initialValue: [1, 2]),
            FieldConfig<List<int>>(
                key: 'list2',
                initialValue: [1, 2, 3, 4, 5],
                validators: [LessThanValidator(otherField: 'list1')]),
          ],
        );

        final result = group.field('list2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'lessThan');
      });
    });

    group('Map validation', () {
      test(
          'should return valid when map length is less than or equal to other map length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Map<String, int>>(
                key: 'map1', initialValue: {'a': 1, 'b': 2, 'c': 3}),
            FieldConfig<Map<String, int>>(
                key: 'map2',
                initialValue: {'x': 1, 'y': 2},
                validators: [LessThanValidator(otherField: 'map1')]),
          ],
        );

        final result = group.field('map2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test(
          'should return invalid when map length is greater than other map length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Map<String, int>>(
                key: 'map1', initialValue: {'a': 1}),
            FieldConfig<Map<String, int>>(
                key: 'map2',
                initialValue: {'x': 1, 'y': 2, 'z': 3},
                validators: [LessThanValidator(otherField: 'map1')]),
          ],
        );

        final result = group.field('map2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'lessThan');
      });
    });

    group('Set validation', () {
      test(
          'should return valid when set length is less than or equal to other set length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Set<int>>(
                key: 'set1', initialValue: {1, 2, 3, 4, 5}),
            FieldConfig<Set<int>>(
                key: 'set2',
                initialValue: {1, 2, 3},
                validators: [LessThanValidator(otherField: 'set1')]),
          ],
        );

        final result = group.field('set2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test(
          'should return invalid when set length is greater than other set length',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Set<int>>(key: 'set1', initialValue: {1, 2}),
            FieldConfig<Set<int>>(
                key: 'set2',
                initialValue: {1, 2, 3, 4, 5},
                validators: [LessThanValidator(otherField: 'set1')]),
          ],
        );

        final result = group.field('set2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'lessThan');
      });
    });

    group('Number validation', () {
      test(
          'should return valid when number is less than or equal to other number',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 10),
            FieldConfig<int>(
                key: 'num2',
                initialValue: 5,
                validators: [LessThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test('should return valid when number equals other number', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 10),
            FieldConfig<int>(
                key: 'num2',
                initialValue: 10,
                validators: [LessThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test('should return invalid when number is greater than other number',
          () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 5),
            FieldConfig<int>(
                key: 'num2',
                initialValue: 10,
                validators: [LessThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'lessThan');
      });

      test('should work with double values', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<double>(key: 'num1', initialValue: 10.5),
            FieldConfig<double>(
                key: 'num2',
                initialValue: 15.7,
                validators: [LessThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'lessThan');
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
                validators: [LessThanValidator(otherField: 'date1')]),
          ],
        );

        final result = group.field('date2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'lessThan');
      });
    });

    group('Custom message', () {
      test('should use custom message when provided', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 5),
            FieldConfig<int>(key: 'num2', initialValue: 10, validators: [
              LessThanValidator(
                  otherField: 'num1',
                  message: 'Value must not be bigger than other field')
            ]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'lessThan');
        expect(result.message, 'Value must not be bigger than other field');
      });
    });

    group('Edge cases', () {
      test('should handle empty string', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<String>(key: 'str1', initialValue: 'hello'),
            FieldConfig<String>(
                key: 'str2',
                initialValue: '',
                validators: [LessThanValidator(otherField: 'str1')]),
          ],
        );

        final result = group.field('str2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test('should handle empty list', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<List<int>>(key: 'list1', initialValue: [1, 2, 3]),
            FieldConfig<List<int>>(
                key: 'list2',
                initialValue: [],
                validators: [LessThanValidator(otherField: 'list1')]),
          ],
        );

        final result = group.field('list2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test('should handle empty map', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Map<String, int>>(
                key: 'map1', initialValue: {'a': 1}),
            FieldConfig<Map<String, int>>(
                key: 'map2',
                initialValue: {},
                validators: [LessThanValidator(otherField: 'map1')]),
          ],
        );

        final result = group.field('map2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test('should handle empty set', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<Set<int>>(key: 'set1', initialValue: {1, 2, 3}),
            FieldConfig<Set<int>>(
                key: 'set2',
                initialValue: <int>{},
                validators: [LessThanValidator(otherField: 'set1')]),
          ],
        );

        final result = group.field('set2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test('should handle negative numbers', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: -5),
            FieldConfig<int>(
                key: 'num2',
                initialValue: -10,
                validators: [LessThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test('should handle zero values', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 0),
            FieldConfig<int>(
                key: 'num2',
                initialValue: 0,
                validators: [LessThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'lessThan');
      });

      test('should handle mixed types comparison', () {
        final group = GroupController(
          key: 'testGroup',
          fields: [
            const FieldConfig<int>(key: 'num1', initialValue: 5),
            FieldConfig<double>(
                key: 'num2',
                initialValue: 7.5,
                validators: [LessThanValidator(otherField: 'num1')]),
          ],
        );

        final result = group.field('num2').validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'lessThan');
      });
    });
  });
}
