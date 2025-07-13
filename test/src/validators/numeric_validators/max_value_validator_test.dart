import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_numeric_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MaxValueValidator Tests', () {
    test('should pass validation when value is less than maxValue', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [MaxValueValidator(10)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'maxValue');
      expect(result.message, 'maxValue');
    });

    test('should pass validation when value equals maxValue', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 10,
        validators: [MaxValueValidator(10)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'maxValue');
      expect(result.message, 'maxValue');
    });

    test('should fail validation when value is greater than maxValue', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 15,
        validators: [MaxValueValidator(10)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'maxValue');
      expect(result.message, 'maxValue');
    });

    test('should pass validation when value is null', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: null,
        validators: [MaxValueValidator(10)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'maxValue');
      expect(result.message, 'maxValue');
    });

    test('should use custom message when provided', () {
      // Arrange
      const customMessage = 'Value must not exceed 10';
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 15,
        validators: [MaxValueValidator(10, message: customMessage)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'maxValue');
      expect(result.message, customMessage);
    });

    test('should work with decimal values', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 10.3,
        validators: [MaxValueValidator(10.5)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'maxValue');
    });

    test('should fail with decimal values exceeding maxValue', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 10.7,
        validators: [MaxValueValidator(10.5)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'maxValue');
    });

    test('should work with negative values', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -10,
        validators: [MaxValueValidator(-5)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'maxValue');
    });

    test('should fail with negative values exceeding maxValue', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -3,
        validators: [MaxValueValidator(-5)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'maxValue');
    });

    test('should work with zero as maxValue', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1,
        validators: [MaxValueValidator(0)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'maxValue');
    });

    test('should fail when value is greater than zero maxValue', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1,
        validators: [MaxValueValidator(0)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'maxValue');
    });

    test('should always return correct key regardless of validation result',
        () {
      // Arrange
      final validator1 = MaxValueValidator(10);
      final validator2 = MaxValueValidator(10);

      final validController = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      final invalidController = FieldController<num>(
        key: 'testField',
        initialValue: 15,
        validators: [],
      );

      // Act
      final validResult = validator1.onValidate(validController);
      final invalidResult = validator2.onValidate(invalidController);

      // Assert
      expect(validResult.key, 'maxValue');
      expect(invalidResult.key, 'maxValue');
    });
  });
}
