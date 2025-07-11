import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/validators/numeric_validators/negative_num_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NegativeNumValidator Tests', () {
    test('should pass validation when value is negative', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
      expect(result.message, 'negativeNum');
    });

    test('should fail validation when value is zero', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
      expect(result.message, 'negativeNum');
    });

    test('should fail validation when value is positive', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
      expect(result.message, 'negativeNum');
    });

    test('should pass validation when value is null (defaults to -1)', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: null,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
      expect(result.message, 'negativeNum');
    });

    test('should use custom message when provided', () {
      // Arrange
      final customMessage = 'Value must be negative';
      final validator = NegativeNumValidator(message: customMessage);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
      expect(result.message, customMessage);
    });

    test('should work with negative decimal values', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5.5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
    });

    test('should fail with positive decimal values', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5.5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
    });

    test('should work with very small negative numbers', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
    });

    test('should fail with very small positive numbers', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.0001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
    });

    test('should work with large negative numbers', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1000000,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
    });

    test('should fail with large positive numbers', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1000000,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
    });

    test('should always return correct key regardless of validation result',
        () {
      // Arrange
      final validator1 = NegativeNumValidator();
      final validator2 = NegativeNumValidator();

      final validController = FieldController<num>(
        key: 'testField',
        initialValue: -5,
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
      expect(validResult.key, 'negativeNum');
      expect(invalidResult.key, 'negativeNum');
    });

    test('should handle negative zero (-0.0)', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
    });

    test('should handle edge case with exactly -1', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
    });

    test('should handle edge case with exactly 1', () {
      // Arrange
      final validator = NegativeNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
    });
  });
}
