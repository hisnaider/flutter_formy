import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_generic_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotContainsValidator', () {
    group('String validation', () {
      test('should be valid when string does not contain the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'hello world',
            validators: [NotContainsValidator('test')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be invalid when string contains the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'hello world',
            validators: [NotContainsValidator('world')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be invalid when string contains substring', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'testing',
            validators: [NotContainsValidator('test')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be valid when string is empty and notContain is not empty',
          () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '',
            validators: [NotContainsValidator('test')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be invalid when string is empty and notContain is empty',
          () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '',
            validators: [NotContainsValidator('')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });
    });

    group('List validation', () {
      test('should be valid when list does not contain the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: [1, 2, 3],
            validators: [NotContainsValidator(4)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be invalid when list contains the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: [1, 2, 3],
            validators: [NotContainsValidator(2)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be valid when list is empty', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: <int>[],
            validators: [NotContainsValidator(1)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should work with string list', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: ['apple', 'banana', 'orange'],
            validators: [NotContainsValidator('grape')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be invalid when string list contains the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: ['apple', 'banana', 'orange'],
            validators: [NotContainsValidator('banana')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });
    });

    group('Map validation', () {
      test('should be valid when map does not contain the key', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: {'name': 'John', 'age': 30},
            validators: [NotContainsValidator('email')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be invalid when map contains the key', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: {'name': 'John', 'age': 30},
            validators: [NotContainsValidator('name')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be valid when map is empty', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: <String, dynamic>{},
            validators: [NotContainsValidator('key')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });
    });

    group('Other types validation', () {
      test('should be valid when int does not equal the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 42,
            validators: [NotContainsValidator(24)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be invalid when int equals the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 42,
            validators: [NotContainsValidator(42)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be valid when bool does not equal the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: true,
            validators: [NotContainsValidator(false)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be invalid when bool equals the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: true,
            validators: [NotContainsValidator(true)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });
    });

    group('Null validation', () {
      test('should be valid when value is null', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: null,
            validators: [NotContainsValidator('test')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be valid when value is null and notContain is null', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: null,
            validators: [NotContainsValidator(null)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });
    });

    group('Custom message', () {
      test('should use custom message when provided', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'hello world',
            validators: [
              NotContainsValidator('world', message: 'Should not contain world')
            ]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'Should not contain world');
      });
    });

    group('Set validation', () {
      test('should be valid when set does not contain the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: {1, 2, 3},
            validators: [NotContainsValidator(4)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });

      test('should be invalid when set contains the value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: {1, 2, 3},
            validators: [NotContainsValidator(2)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'notContains');
        expect(result.message, 'notContains');
      });
    });
  });
}
