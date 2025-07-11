import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/validators/numeric_validators/non_zero_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NonZeroValidator Tests', () {
    test('should pass validation when value is positive', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
      expect(result.message, 'nonZeroNum');
    });

    test('should pass validation when value is negative', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
      expect(result.message, 'nonZeroNum');
    });

    test('should fail validation when value is zero', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'nonZeroNum');
      expect(result.message, 'nonZeroNum');
    });

    test('should pass validation when value is null (defaults to 1)', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: null,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
      expect(result.message, 'nonZeroNum');
    });

    test('should use custom message when provided', () {
      // Arrange
      final customMessage = 'Value must not be zero';
      final validator = NonZeroValidator(message: customMessage);
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'nonZeroNum');
      expect(result.message, customMessage);
    });

    test('should work with positive decimal values', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5.5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with negative decimal values', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5.5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should fail with zero as decimal (0.0)', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with very small positive numbers', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.0001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with very small negative numbers', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with large positive numbers', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1000000,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with large negative numbers', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1000000,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should always return correct key regardless of validation result',
        () {
      // Arrange
      final validator1 = NonZeroValidator();
      final validator2 = NonZeroValidator();

      final validController = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      final invalidController = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [],
      );

      // Act
      final validResult = validator1.onValidate(validController);
      final invalidResult = validator2.onValidate(invalidController);

      // Assert
      expect(validResult.key, 'nonZeroNum');
      expect(invalidResult.key, 'nonZeroNum');
    });

    test('should handle negative zero (-0.0)', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'nonZeroNum');
    });

    test('should handle edge case with exactly 1', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should handle edge case with exactly -1', () {
      // Arrange
      final validator = NonZeroValidator();
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should handle floating point precision edge cases', () {
      // Arrange
      final validator = NonZeroValidator();
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
      expect(result.key, 'nonZeroNum');
    });
  });
}
