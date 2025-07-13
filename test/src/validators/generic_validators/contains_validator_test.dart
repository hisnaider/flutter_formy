import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContainsValidator', () {
    test('should return valid when field value is null', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: null,
        validators: [ContainsValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
      expect(result.message, 'contains');
    });

    test('should validate String contains substring', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello world',
        validators: [ContainsValidator('world')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test('should return invalid when String does not contain substring', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello world',
        validators: [ContainsValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should validate List contains element', () {
      final controller = FieldController<List<String>>(
        key: 'field1',
        initialValue: ['apple', 'banana', 'orange'],
        validators: [ContainsValidator('banana')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test('should return invalid when List does not contain element', () {
      final controller = FieldController<List<String>>(
        key: 'field1',
        initialValue: ['apple', 'banana', 'orange'],
        validators: [ContainsValidator('grape')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should validate Set contains element', () {
      final controller = FieldController<Set<int>>(
        key: 'field1',
        initialValue: {1, 2, 3, 4, 5},
        validators: [ContainsValidator(3)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test('should validate Map contains key', () {
      final controller = FieldController<Map<String, dynamic>>(
        key: 'field1',
        initialValue: {'name': 'John', 'age': 30},
        validators: [ContainsValidator('name')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test('should return invalid when Map does not contain key', () {
      final controller = FieldController<Map<String, dynamic>>(
        key: 'field1',
        initialValue: {'name': 'John', 'age': 30},
        validators: [ContainsValidator('email')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should use direct equality comparison as fallback', () {
      final controller = FieldController<int>(
        key: 'field1',
        initialValue: 42,
        validators: [ContainsValidator(42)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test('should return invalid when direct equality fails', () {
      final controller = FieldController<int>(
        key: 'field1',
        initialValue: 42,
        validators: [ContainsValidator('24')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should use custom message when provided', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello',
        validators: [
          ContainsValidator('world', message: 'Custom error message')
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
      expect(result.message, 'Custom error message');
    });

    test('should handle empty String', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: '',
        validators: [ContainsValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should handle empty List', () {
      final controller = FieldController<List<String>>(
        key: 'field1',
        initialValue: [],
        validators: [ContainsValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should handle empty Map', () {
      final controller = FieldController<Map<String, dynamic>>(
        key: 'field1',
        initialValue: {},
        validators: [ContainsValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should validate String contains empty string', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello world',
        validators: [ContainsValidator('')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test('should validate case-sensitive String contains', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'Hello World',
        validators: [ContainsValidator('hello')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });
    test('should validate case-sensitive String contains', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'Hello World',
        validators: [ContainsValidator('hello')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should return valid when FieldListController value is null', () {
      final controller = FieldListController<String>(
        key: 'listField',
        initialValue: null,
        validators: [ContainsValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test('should validate FieldListController contains element', () {
      final controller = FieldListController<String>(
        key: 'listField',
        initialValue: ['apple', 'banana', 'orange'],
        validators: [ContainsValidator('banana')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test(
        'should return invalid when FieldListController does not contain element',
        () {
      final controller = FieldListController<String>(
        key: 'listField',
        initialValue: ['apple', 'banana', 'orange'],
        validators: [ContainsValidator('grape')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should validate FieldListController with numbers', () {
      final controller = FieldListController<int>(
        key: 'numberList',
        initialValue: [1, 2, 3, 4, 5],
        validators: [ContainsValidator(3)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test('should handle empty FieldListController', () {
      final controller = FieldListController<String>(
        key: 'emptyList',
        initialValue: [],
        validators: [ContainsValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
    });

    test('should use custom message with FieldListController', () {
      final controller = FieldListController<String>(
        key: 'listField',
        initialValue: ['apple', 'banana'],
        validators: [
          ContainsValidator('orange', message: 'List must contain orange')
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'contains');
      expect(result.message, 'List must contain orange');
    });

    test('should validate FieldListController with duplicate elements', () {
      final controller = FieldListController<String>(
        key: 'listField',
        initialValue: ['apple', 'banana', 'apple', 'orange'],
        validators: [ContainsValidator('apple')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });

    test('should validate FieldListController with mixed types', () {
      final controller = FieldListController<dynamic>(
        key: 'mixedList',
        initialValue: [1, 'hello', true, 3.14],
        validators: [ContainsValidator('hello')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'contains');
    });
  });
}
