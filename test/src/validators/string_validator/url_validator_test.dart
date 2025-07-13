import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_string_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UrlValidator', () {
    test('should validate valid URLs', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'https://example.com',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'url');
      expect(result.message, 'url');
    });

    test('should validate valid URLs without protocol', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'example.com',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'url');
    });

    test('should validate valid URLs with path', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'https://example.com/path/to/page',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'url');
    });

    test('should validate valid URLs with subdomain', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'https://www.example.com',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'url');
    });

    test('should invalidate URLs without domain', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'https://',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'url');
    });

    test('should invalidate URLs with invalid format', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'not-a-url',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'url');
    });

    test('should invalidate URLs with spaces', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'https://example .com',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'url');
    });

    test('should invalidate URLs with invalid TLD', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'https://example.x',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'url');
    });

    test('should accept null values as valid', () {
      final controller = FieldController(
        key: 'url_field',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'url');
    });

    test('should accept empty string as invalid', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: '',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'url');
    });

    test('should use custom message when provided', () {
      const customMessage = 'Please enter a valid URL';
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'invalid-url',
        validators: [UrlValidator(message: customMessage)],
      );

      final result =
          UrlValidator(message: customMessage).onValidate(controller);

      expect(result.isValid, false);
      expect(result.key, 'url');
      expect(result.message, customMessage);
    });

    test('should use key as message when message is null', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'invalid-url',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'url');
      expect(result.message, 'url');
    });

    test('should validate URLs with query parameters', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'https://example.com/path?param=value&other=123',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'url');
    });

    test('should validate URLs with fragments', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'https://example.com/path#section',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'url');
    });

    test('should validate URLs with port numbers', () {
      final controller = FieldController(
        key: 'url_field',
        initialValue: 'https://example.com:8080/path',
        validators: [UrlValidator()],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'url');
    });
  });
}
