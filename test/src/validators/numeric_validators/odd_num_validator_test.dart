import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/validators/numeric_validators/odd_num_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OddNumValidator Tests', () {
    test('should pass validation when value is odd positive number', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should pass validation when value is odd negative number', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -5,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should fail validation when value is even positive number', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 6,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should fail validation when value is even negative number', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -6,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should fail validation when value is zero', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 0,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should pass validation when value is null (defaults to 1)', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: null,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
      expect(result.message, 'oddNum');
    });

    test('should use custom message when provided', () {
      // Arrange
      final customMessage = 'Value must be an odd number';
      final validator = OddNumValidator(message: customMessage);
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 4,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
      expect(result.message, customMessage);
    });

    test('should pass validation with odd number 1', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
    });

    test('should pass validation with odd number -1', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -1,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
    });

    test('should fail validation with even number 2', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 2,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
    });

    test('should fail validation with even number -2', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -2,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
    });

    test('should work with large odd numbers', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 1000001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
    });

    test('should work with large even numbers', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: 1000000,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'oddNum');
    });

    test('should work with large negative odd numbers', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -1000001,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'oddNum');
    });

    test('should work with large negative even numbers', () {
      // Arrange
      final validator = OddNumValidator();
      final controller = FieldController<int>(
        key: 'testField',
        initialValue: -1000000,
        validators: [],
      );

      // Act
      final result = validator.onValidate(controller);

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
        validators: [],
      );

      final invalidController = FieldController<int>(
        key: 'testField',
        initialValue: 8,
        validators: [],
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
      final validator = OddNumValidator();
      final oddNumbers = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];

      for (final number in oddNumbers) {
        final controller = FieldController<int>(
          key: 'testField',
          initialValue: number,
          validators: [],
        );

        // Act
        final result = validator.onValidate(controller);

        // Assert
        expect(result.isValid, true, reason: '$number should be valid (odd)');
        expect(result.key, 'oddNum');
      }
    });

    test('should handle sequence of even numbers correctly', () {
      // Arrange
      final validator = OddNumValidator();
      final evenNumbers = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20];

      for (final number in evenNumbers) {
        final controller = FieldController<int>(
          key: 'testField',
          initialValue: number,
          validators: [],
        );

        // Act
        final result = validator.onValidate(controller);

        // Assert
        expect(result.isValid, false,
            reason: '$number should be invalid (even)');
        expect(result.key, 'oddNum');
      }
    });
  });
}
