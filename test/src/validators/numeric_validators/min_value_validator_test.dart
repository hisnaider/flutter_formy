import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/validators/numeric_validators/min_value_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MinValueValidator Tests', () {
    test('should pass validation when value is greater than minValue', () {
      // Arrange
      final validator = MinValueValidator(10);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 15,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'minValue');
      expect(result.message, 'minValue');
    });

    test('should fail validation when value equals minValue', () {
      // Arrange
      final validator = MinValueValidator(10);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 10,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'minValue');
      expect(result.message, 'minValue');
    });

    test('should fail validation when value is less than minValue', () {
      // Arrange
      final validator = MinValueValidator(10);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'minValue');
      expect(result.message, 'minValue');
    });

    test('should pass validation when value is null', () {
      // Arrange
      final validator = MinValueValidator(10);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: null,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'minValue');
      expect(result.message, 'minValue');
    });

    test('should use custom message when provided', () {
      // Arrange
      final customMessage = 'Value must be greater than 10';
      final validator = MinValueValidator(10, message: customMessage);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'minValue');
      expect(result.message, customMessage);
    });

    test('should work with decimal values', () {
      // Arrange
      final validator = MinValueValidator(10.5);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 10.7,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'minValue');
    });

    test('should fail with decimal values not exceeding minValue', () {
      // Arrange
      final validator = MinValueValidator(10.5);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 10.3,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'minValue');
    });

    test('should work with negative values', () {
      // Arrange
      final validator = MinValueValidator(-5);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -3,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'minValue');
    });

    test('should fail with negative values not exceeding minValue', () {
      // Arrange
      final validator = MinValueValidator(-5);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -10,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'minValue');
    });

    test('should work with zero as minValue', () {
      // Arrange
      final validator = MinValueValidator(0);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'minValue');
    });

    test('should fail when value is equal to zero minValue', () {
      // Arrange
      final validator = MinValueValidator(0);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'minValue');
    });

    test('should fail when value is less than zero minValue', () {
      // Arrange
      final validator = MinValueValidator(0);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'minValue');
    });

    test('should always return correct key regardless of validation result',
        () {
      // Arrange
      final validator1 = MinValueValidator(10);
      final validator2 = MinValueValidator(10);

      final validController = FieldController<num>(
        key: 'testField',
        initialValue: 15,
        validators: [],
      );

      final invalidController = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      // Act
      final validResult = validator1.onValidate(validController);
      final invalidResult = validator2.onValidate(invalidController);

      // Assert
      expect(validResult.key, 'minValue');
      expect(invalidResult.key, 'minValue');
    });

    test('should handle very small decimal differences', () {
      // Arrange
      final validator = MinValueValidator(10.0);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 10.0000001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'minValue');
    });

    test('should handle very large numbers', () {
      // Arrange
      final validator = MinValueValidator(1000000);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1000001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'minValue');
    });
  });
}
