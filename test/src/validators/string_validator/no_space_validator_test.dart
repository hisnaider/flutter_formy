import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_string_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoSpaceValidator', () {
    test('should be valid when string contains no spaces', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'helloworld',
          validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be invalid when string contains spaces', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello world',
          validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be invalid when string contains multiple spaces', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello   world',
          validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be invalid when string starts with space', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: ' hello',
          validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be invalid when string ends with space', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello ',
          validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be invalid when string contains only spaces', () {
      final controller = FieldController(
          key: 'field1', initialValue: '   ', validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be invalid when string contains single space', () {
      final controller = FieldController(
          key: 'field1', initialValue: ' ', validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be valid when string is empty', () {
      final controller = FieldController(
          key: 'field1', initialValue: '', validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be valid when value is null', () {
      final controller =
          FieldController(key: 'field1', validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be valid with special characters but no spaces', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello@world!123',
          validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should be valid with underscores and hyphens', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello_world-test',
          validators: [NoSpaceValidator()]);

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'noSpaces');
      expect(result.message, 'noSpaces');
    });

    test('should use custom message when provided', () {
      final controller = FieldController(
          key: 'field1',
          initialValue: 'hello world',
          validators: [NoSpaceValidator(message: 'Spaces are not allowed')]);

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'noSpaces');
      expect(result.message, 'Spaces are not allowed');
    });
  });
}
