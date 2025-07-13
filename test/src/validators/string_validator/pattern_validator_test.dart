import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_string_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PatternValidator', () {
    group('Email pattern validation', () {
      final emailPattern =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

      test('should be valid when string matches email pattern', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'test@example.com',
            validators: [PatternValidator(emailPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when string does not match email pattern', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'invalid-email',
            validators: [PatternValidator(emailPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when email is missing @ symbol', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'testexample.com',
            validators: [PatternValidator(emailPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when email is missing domain', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'test@',
            validators: [PatternValidator(emailPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });
    });

    group('Phone number pattern validation', () {
      final phonePattern = RegExp(r'^\+?[1-9]\d{4,14}$');

      test('should be valid when string matches phone pattern', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '+1234567890',
            validators: [PatternValidator(phonePattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be valid when phone number without plus sign', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '1234567890',
            validators: [PatternValidator(phonePattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when phone number contains letters', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '123abc4567',
            validators: [PatternValidator(phonePattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when phone number is too short', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '123',
            validators: [PatternValidator(phonePattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });
    });

    group('Alphanumeric pattern validation', () {
      final alphanumericPattern = RegExp(r'^[a-zA-Z0-9]+$');

      test('should be valid when string contains only letters and numbers', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'Hello123',
            validators: [PatternValidator(alphanumericPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when string contains special characters', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'Hello@123',
            validators: [PatternValidator(alphanumericPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when string contains spaces', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'Hello 123',
            validators: [PatternValidator(alphanumericPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });
    });

    group('Digits only pattern validation', () {
      final digitsOnlyPattern = RegExp(r'^\d+$');

      test('should be valid when string contains only digits', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '12345',
            validators: [PatternValidator(digitsOnlyPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when string contains letters', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '123abc',
            validators: [PatternValidator(digitsOnlyPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when string contains special characters', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '123-456',
            validators: [PatternValidator(digitsOnlyPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });
    });

    group('URL pattern validation', () {
      final urlPattern = RegExp(
          r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');

      test('should be valid when string matches URL pattern', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'https://www.example.com',
            validators: [PatternValidator(urlPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be valid when URL without www', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'https://example.com',
            validators: [PatternValidator(urlPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be valid when HTTP URL', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'http://example.com',
            validators: [PatternValidator(urlPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when URL missing protocol', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: 'www.example.com',
            validators: [PatternValidator(urlPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });
    });

    group('Empty and null validation', () {
      final anyPattern = RegExp(r'.*');

      test(
          'should be invalid when string is empty and pattern requires content',
          () {
        final requireContentPattern = RegExp(r'^.+$');
        final controller = FieldController(
            key: 'field1',
            initialValue: '',
            validators: [PatternValidator(requireContentPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be valid when string is empty and pattern allows empty', () {
        final controller = FieldController(
            key: 'field1',
            initialValue: '',
            validators: [PatternValidator(anyPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be valid when value is null', () {
        final controller = FieldController(
            key: 'field1', validators: [PatternValidator(anyPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });
    });

    group('Custom message', () {
      test('should use custom message when provided', () {
        final emailPattern =
            RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
        final controller = FieldController(
            key: 'field1',
            initialValue: 'invalid-email',
            validators: [
              PatternValidator(emailPattern,
                  message: 'Please enter a valid email address')
            ]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'Please enter a valid email address');
      });
    });

    group('Complex patterns', () {
      test('should validate password pattern with requirements', () {
        // Password with at least 8 chars, one uppercase, one lowercase, one digit, one special char
        final passwordPattern = RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

        final controller = FieldController(
            key: 'field1',
            initialValue: 'Password123!',
            validators: [PatternValidator(passwordPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });

      test('should be invalid when password does not meet requirements', () {
        final passwordPattern = RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

        final controller = FieldController(
            key: 'field1',
            initialValue: 'password', // missing uppercase, digit, special char
            validators: [PatternValidator(passwordPattern)]);

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'pattern');
        expect(result.message, 'pattern');
      });
    });
  });
}
