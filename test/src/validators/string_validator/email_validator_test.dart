import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_string_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmailValidator', () {
    test('should return valid when field value is null', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: null,
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
      expect(result.message, 'invalidEmail');
    });

    test('should return valid when field value is empty string', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: '',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should validate simple email format', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test@example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should validate email with numbers', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'user123@domain456.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should validate email with dots and special characters', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'user.name+tag@example.co.uk',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should validate email with underscore and hyphen', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'user_name@sub-domain.example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should validate email with percentage sign', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'user%name@example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email without @ symbol', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'testexample.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email without domain', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test@',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email without local part', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: '@example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email without top-level domain', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test@example',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email with invalid characters', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test@exam ple.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email with multiple @ symbols', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test@@example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email with short top-level domain', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test@example.c',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email starting with dot', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: '.test@example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email ending with dot before @', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test.@example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email with consecutive dots', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test..name@example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should use custom message when provided', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'invalid-email',
        validators: [
          EmailValidator(message: 'Please enter a valid email address')
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
      expect(result.message, 'Please enter a valid email address');
    });

    test('should validate email with long top-level domain', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test@example.photography',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should validate email with subdomain', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test@mail.example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should validate email with multiple subdomains', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test@mail.subdomain.example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email with spaces', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'test @example.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email with leading/trailing spaces', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: ' test@example.com ',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });

    test('should validate minimum valid email format', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: 'a@b.co',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'invalidEmail');
    });

    test('should return invalid for email with only @ and domain', () {
      final controller = FieldController<String>(
        key: 'email',
        initialValue: '@domain.com',
        validators: [EmailValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'invalidEmail');
    });
  });
}
