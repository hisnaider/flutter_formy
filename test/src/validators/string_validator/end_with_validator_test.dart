import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EndWithValidator', () {
    test('should return valid when field value is null', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: null,
        validators: [EndWithValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
      expect(result.message, 'endWith');
    });

    test('should validate when string ends with specified suffix', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello world',
        validators: [EndWithValidator('world')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should return invalid when string does not end with specified suffix',
        () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello world',
        validators: [EndWithValidator('hello')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'endWith');
    });

    test('should validate when string ends with single character', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'test!',
        validators: [EndWithValidator('!')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate when string ends with number', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'version123',
        validators: [EndWithValidator('123')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate when string ends with special characters', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'email@domain.com',
        validators: [EndWithValidator('.com')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate when string is exactly the end suffix', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'test',
        validators: [EndWithValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate when string ends with empty string', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello world',
        validators: [EndWithValidator('')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate when empty string ends with empty string', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: '',
        validators: [EndWithValidator('')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test(
        'should return invalid when empty string does not end with specified suffix',
        () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: '',
        validators: [EndWithValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'endWith');
    });

    test('should be case-sensitive', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'Hello World',
        validators: [EndWithValidator('world')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'endWith');
    });

    test('should validate case-sensitive match', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'Hello World',
        validators: [EndWithValidator('World')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate when string ends with whitespace', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello world ',
        validators: [EndWithValidator(' ')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should return invalid when suffix is longer than string', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hi',
        validators: [EndWithValidator('hello')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'endWith');
    });

    test('should validate with unicode characters', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello 🌍',
        validators: [EndWithValidator('🌍')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate with accented characters', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'café',
        validators: [EndWithValidator('é')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should use custom message when provided', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello world',
        validators: [EndWithValidator('test', message: 'Must end with test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'endWith');
      expect(result.message, 'Must end with test');
    });

    test('should validate with newline characters', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello\nworld\n',
        validators: [EndWithValidator('\n')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate with tab characters', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello\tworld\t',
        validators: [EndWithValidator('\t')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate file extension pattern', () {
      final controller = FieldController<String>(
        key: 'filename',
        initialValue: 'document.pdf',
        validators: [EndWithValidator('.pdf')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should return invalid for wrong file extension', () {
      final controller = FieldController<String>(
        key: 'filename',
        initialValue: 'document.txt',
        validators: [EndWithValidator('.pdf')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'endWith');
    });

    test('should validate URL ending pattern', () {
      final controller = FieldController<String>(
        key: 'url',
        initialValue: 'https://example.com/',
        validators: [EndWithValidator('/')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate with repeated characters', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hellooo',
        validators: [EndWithValidator('ooo')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should validate partial match at end', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello world test',
        validators: [EndWithValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'endWith');
    });

    test('should return invalid for partial match not at end', () {
      final controller = FieldController<String>(
        key: 'field1',
        initialValue: 'hello test world',
        validators: [EndWithValidator('test')],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'endWith');
    });
  });
}
