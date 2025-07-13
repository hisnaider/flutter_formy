import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_string_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoNumbersValidator', () {
    test('should be valid when string contains no numbers', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello world',
          validators: [NoNumbersValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noNumbers');
      expect(result.message, 'noNumbers');
    });

    test('should be invalid when string contains numbers', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello123',
          validators: [NoNumbersValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noNumbers');
      expect(result.message, 'noNumbers');
    });

    test('should be invalid when string contains only numbers', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: '12345',
          validators: [NoNumbersValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noNumbers');
      expect(result.message, 'noNumbers');
    });

    test('should be valid when string is empty', () {
      final controller = FieldController(
          key: 'field1', initialValue: '', validators: [NoNumbersValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noNumbers');
      expect(result.message, 'noNumbers');
    });

    test('should be valid when value is null', () {
      final controller =
          FieldController(key: 'field1', validators: [NoNumbersValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noNumbers');
      expect(result.message, 'noNumbers');
    });

    test('should be valid with special characters but no numbers', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello@world!',
          validators: [NoNumbersValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noNumbers');
      expect(result.message, 'noNumbers');
    });

    test('should be invalid with mixed text and numbers', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'test2024',
          validators: [NoNumbersValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noNumbers');
      expect(result.message, 'noNumbers');
    });

    test('should use custom message when provided', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'test123',
          validators: [NoNumbersValidator(message: 'Numbers are not allowed')]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noNumbers');
      expect(result.message, 'Numbers are not allowed');
    });
  });
}
