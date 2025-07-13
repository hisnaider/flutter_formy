import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_string_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoSpecialCharsValidator', () {
    test('should be valid when string contains only letters and numbers', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello123',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be valid when string contains only letters', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'helloworld',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be valid when string contains only numbers', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: '12345',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be valid with mixed case letters and numbers', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'Hello123World',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains spaces', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello world',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains special characters', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello@world',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains punctuation', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello!',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains symbols', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello#world',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains underscores', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello_world',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains hyphens', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello-world',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains dots', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello.world',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains multiple special characters',
        () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello@#world!',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains only special characters', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: '@#\$%',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string is empty', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: '',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when value is null', () {
      final controller = FieldController(
          key: 'field1', validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should be invalid when string contains accented characters', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'héllo',
          validators: [NoSpecialCharsValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'noSpecialChars');
    });

    test('should use custom message when provided', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello@world',
          validators: [
            NoSpecialCharsValidator(
                message: 'Special characters are not allowed')
          ]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpecialChars');
      expect(result.message, 'Special characters are not allowed');
    });
  });
}
