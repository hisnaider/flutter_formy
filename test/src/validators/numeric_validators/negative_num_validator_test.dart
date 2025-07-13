import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_numeric_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NegativeNumValidator Tests', () {
    test('should pass validation when value is negative', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
      expect(result.message, 'negativeNum');
    });

    test('should fail validation when value is zero', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
      expect(result.message, 'negativeNum');
    });

    test('should fail validation when value is positive', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
      expect(result.message, 'negativeNum');
    });

    test('should pass validation when value is null (defaults to -1)', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: null,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
      expect(result.message, 'negativeNum');
    });

    test('should use custom message when provided', () {
      // Arrange
      const customMessage = 'Value must be negative';
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [NegativeNumValidator(message: customMessage)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
      expect(result.message, customMessage);
    });

    test('should work with negative decimal values', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5.5,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
    });

    test('should fail with positive decimal values', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5.5,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
    });

    test('should work with very small negative numbers', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0001,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
    });

    test('should fail with very small positive numbers', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.0001,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
    });

    test('should work with large negative numbers', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1000000,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
    });

    test('should fail with large positive numbers', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1000000,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

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
        validators: [NegativeNumValidator()],
      );

      final invalidController = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [NegativeNumValidator()],
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
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
    });

    test('should handle edge case with exactly -1', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'negativeNum');
    });

    test('should handle edge case with exactly 1', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1,
        validators: [NegativeNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'negativeNum');
    });
  });
}
