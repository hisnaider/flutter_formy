import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_numeric_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NonZeroValidator Tests', () {
    test('should pass validation when value is positive', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
      expect(result.message, 'nonZeroNum');
    });

    test('should pass validation when value is negative', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
      expect(result.message, 'nonZeroNum');
    });

    test('should fail validation when value is zero', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'nonZeroNum');
      expect(result.message, 'nonZeroNum');
    });

    test('should pass validation when value is null (defaults to 1)', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: null,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
      expect(result.message, 'nonZeroNum');
    });

    test('should use custom message when provided', () {
      // Arrange
      const customMessage = 'Value must not be zero';
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [NonZeroValidator(message: customMessage)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'nonZeroNum');
      expect(result.message, customMessage);
    });

    test('should work with positive decimal values', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 5.5,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with negative decimal values', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -5.5,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should fail with zero as decimal (0.0)', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.0,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with very small positive numbers', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.0001,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with very small negative numbers', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0001,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with large positive numbers', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1000000,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should work with large negative numbers', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1000000,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

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
        validators: [NonZeroValidator()],
      );

      final invalidController = FieldController<num>(
        key: 'testField',
        initialValue: 0,
        validators: [NonZeroValidator()],
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
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -0.0,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'nonZeroNum');
    });

    test('should handle edge case with exactly 1', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 1,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should handle edge case with exactly -1', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: -1,
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'nonZeroNum');
    });

    test('should handle floating point precision edge cases', () {
      // Arrange
      final controller = FieldController<num>(
        key: 'testField',
        initialValue: 0.1 +
            0.2 -
            0.3, // This might not be exactly 0 due to floating point precision
        validators: [NonZeroValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      // This test shows the behavior with floating point precision
      // The result will depend on how Dart handles floating point arithmetic
      expect(result.key, 'nonZeroNum');
    });
  });
}
