import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartWithValidator', () {
    group('Basic string validation', () {
      test('should be valid when string starts with the required value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'hello world',
            validators: [StartWithValidator('hello')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test(
          'should be invalid when string does not start with the required value',
          () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'world hello',
            validators: [StartWithValidator('hello')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid when string is exactly the required value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'hello',
            validators: [StartWithValidator('hello')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be invalid when string is shorter than the required start',
          () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'hi',
            validators: [StartWithValidator('hello')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test(
          'should be invalid when string contains the required value but not at start',
          () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'say hello world',
            validators: [StartWithValidator('hello')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });
    });

    group('Case sensitivity', () {
      test('should be invalid when case does not match', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'Hello world',
            validators: [StartWithValidator('hello')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid when case matches exactly', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'Hello world',
            validators: [StartWithValidator('Hello')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid with uppercase start value', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'HELLO world',
            validators: [StartWithValidator('HELLO')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });
    });

    group('Special characters and numbers', () {
      test('should be valid when string starts with number', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '123abc',
            validators: [StartWithValidator('123')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid when string starts with special characters', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '@#\$hello',
            validators: [StartWithValidator('@#\$')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid when string starts with space', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: ' hello world',
            validators: [StartWithValidator(' ')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid when string starts with mixed characters', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'Hello123@world',
            validators: [StartWithValidator('Hello123@')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });
    });

    group('Edge cases', () {
      test('should be valid when both strings are empty', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '',
            validators: [StartWithValidator('')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid when string is not empty and start is empty', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'hello',
            validators: [StartWithValidator('')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be invalid when string is empty and start is not empty', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '',
            validators: [StartWithValidator('hello')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid when value is null', () {
        final controller = FieldController(
            key: 'field1', validators: [StartWithValidator('hello')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });
    });

    group('URL and protocol validation', () {
      test('should be valid when URL starts with https', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'https://example.com',
            validators: [StartWithValidator('https://')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test(
          'should be invalid when URL starts with http but validator expects https',
          () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'http://example.com',
            validators: [StartWithValidator('https://')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid when URL starts with http', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'http://example.com',
            validators: [StartWithValidator('http://')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });
    });

    group('Phone number validation', () {
      test('should be valid when phone starts with country code', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '+1234567890',
            validators: [StartWithValidator('+1')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test(
          'should be invalid when phone does not start with expected country code',
          () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '+44234567890',
            validators: [StartWithValidator('+1')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });
    });

    group('Multi-character start validation', () {
      test('should be valid when string starts with multi-character prefix',
          () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'HelloWorld123',
            validators: [StartWithValidator('HelloWorld')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test(
          'should be invalid when string partially matches multi-character prefix',
          () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'Hello123',
            validators: [StartWithValidator('HelloWorld')]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });
    });

    group('Custom message', () {
      test('should use custom message when provided', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'world hello',
            validators: [
              StartWithValidator('hello', message: 'Text must start with hello')
            ]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'startWith');
        expect(result.message, 'Text must start with hello');
      });
    });

    group('Unicode and special characters', () {
      test('should be valid when string starts with unicode characters', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'çãoworld',
            validators: [StartWithValidator('ção')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });

      test('should be valid when string starts with emoji', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '😀hello',
            validators: [StartWithValidator('😀')]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'startWith');
        expect(result.message, 'startWith');
      });
    });
  });
}
