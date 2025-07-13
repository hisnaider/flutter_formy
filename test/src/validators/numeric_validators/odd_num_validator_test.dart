import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_numeric_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OddNumValidator Tests', () {
    test('should pass validation when value is odd positive number', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 5,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should pass validation when value is odd negative number', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -5,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should fail validation when value is even positive number', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 6,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should fail validation when value is even negative number', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -6,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should fail validation when value is zero', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 0,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should pass validation when value is null (defaults to 1)', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: null,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should use custom message when provided', () {
      // Arrange
      const customMessage = 'Value must be an odd number';
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 4,
        validators: [OddNumValidator(message: customMessage)],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
      expect(result.message, customMessage);
    });

    test('should pass validation with odd number 1', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 1,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
    });

    test('should pass validation with odd number -1', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -1,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
    });

    test('should fail validation with even number 2', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 2,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
    });

    test('should fail validation with even number -2', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -2,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
    });

    test('should work with large odd numbers', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 1000001,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
    });

    test('should work with large even numbers', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 1000000,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
    });

    test('should work with large negative odd numbers', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -1000001,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
    });

    test('should work with large negative even numbers', () {
      // Arrange

      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -1000000,
        validators: [OddNumValidator()],
      );

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
    });

    test('should always return correct key regardless of validation result',
        () {
      // Arrange
      final validator1 = OddNumValidator();
      final validator2 = OddNumValidator();

      final validController = FieldController<int>(
        key: 'testField',
        initialValue: 7,
        validators: [OddNumValidator()],
      );

      final invalidController = FieldController<int>(
        key: 'testField',
        initialValue: 8,
        validators: [OddNumValidator()],
      );

      // Act
      final validResult = validator1.onValidate(validController);
      final invalidResult = validator2.onValidate(invalidController);

      // Assert
      expect(validResult.key, 'oddNum');
      expect(invalidResult.key, 'oddNum');
    });

    test('should handle sequence of odd numbers correctly', () {
      // Arrange

      final oddNumbers = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];

      for (final number in oddNumbers) {
        final controller = FieldController<int>(
          key: 'testField',
          initialValue: number,
          validators: [OddNumValidator()],
        );

        // Act
        final result = controller.validationResults.first;

        // Assert
        expect(result.isValid, true, reason: '$number should be valid (odd)');
        expect(result.key, 'oddNum');
      }
    });

    test('should handle sequence of even numbers correctly', () {
      // Arrange

      final evenNumbers = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20];

      for (final number in evenNumbers) {
        final controller = FieldController<int>(
          key: 'testField',
          initialValue: number,
          validators: [OddNumValidator()],
        );

        // Act
        final result = controller.validationResults.first;

        // Assert
        expect(result.isValid, false,
            reason: '$number should be invalid (even)');
        expect(result.key, 'oddNum');
      }
    });
  });
}
