import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/validators/numeric_validators/positive_num_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PositiveNumValidator Tests', () {
    test('should pass validation when value is positive', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'positiveNum');
      expect(result.message, 'positiveNum');
    });

    test('should fail validation when value is negative', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'positiveNum');
      expect(result.message, 'positiveNum');
    });

    test('should fail validation when value is zero', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'positiveNum');
      expect(result.message, 'positiveNum');
    });

    test('should pass validation when value is null (defaults to 1)', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: null,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'positiveNum');
      expect(result.message, 'positiveNum');
    });

    test('should use custom message when provided', () {
      // Arrange
      final customMessage = 'Value must be positive';
      final validator = PositiveNumValidator(message: customMessage);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'positiveNum');
      expect(result.message, customMessage);
    });

    test('should work with positive decimal values', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5.5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'positiveNum');
    });

    test('should fail with negative decimal values', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5.5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'positiveNum');
    });

    test('should fail with zero as decimal (0.0)', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'positiveNum');
    });

    test('should work with very small positive numbers', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.0001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'positiveNum');
    });

    test('should fail with very small negative numbers', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'positiveNum');
    });

    test('should work with large positive numbers', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1000000,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'positiveNum');
    });

    test('should fail with large negative numbers', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1000000,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'positiveNum');
    });

    test('should always return correct key regardless of validation result',
        () {
      // Arrange
      final validator1 = PositiveNumValidator();
      final validator2 = PositiveNumValidator();

      final validController = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      final invalidController = FieldController<num>(
        key: 'testField',
        initialValue: -5,
        validators: [],
      );

      // Act
      final validResult = validator1.onValidate(validController);
      final invalidResult = validator2.onValidate(invalidController);

      // Assert
      expect(validResult.key, 'positiveNum');
      expect(invalidResult.key, 'positiveNum');
    });

    test('should fail with negative zero (-0.0)', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'positiveNum');
    });

    test('should handle edge case with exactly 1', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'positiveNum');
    });

    test('should handle edge case with exactly -1', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'positiveNum');
    });

    test('should handle floating point precision edge cases', () {
      // Arrange
      final validator = PositiveNumValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.1 +
            0.2 -
            0.3, // This might not be exactly 0 due to floating point precision
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      // This test shows the behavior with floating point precision
      // The result will depend on how Dart handles floating point arithmetic
      expect(result.key, 'positiveNum');
    });

    test('should handle sequence of positive numbers correctly', () {
      // Arrange
      final validator = PositiveNumValidator();
      final positiveNumbers = [0.1, 1, 2, 3, 4, 5, 100, 1000, 0.0001];

      for (final number in positiveNumbers) {
        final controller = FieldController<num>(
          key: 'testField',
          initialValue: number,
          validators: [],
        );

        // Act
        final result = validator.onValidate(controller);

        // Assert
        expect(result.isValid, true,
            reason: '$number should be valid (positive)');
        expect(result.key, 'positiveNum');
      }
    });

    test('should handle sequence of non-positive numbers correctly', () {
      // Arrange
      final validator = PositiveNumValidator();
      final nonPositiveNumbers = [
        0,
        -0.1,
        -1,
        -2,
        -3,
        -4,
        -5,
        -100,
        -1000,
        -0.0001
      ];

      for (final number in nonPositiveNumbers) {
        final controller = FieldController<num>(
          key: 'testField',
          initialValue: number,
          validators: [],
        );

        // Act
        final result = validator.onValidate(controller);

        // Assert
        expect(result.isValid, false,
            reason: '$number should be invalid (not positive)');
        expect(result.key, 'positiveNum');
      }
    });
  });
}
