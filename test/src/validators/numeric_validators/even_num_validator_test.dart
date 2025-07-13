import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EvenNumValidator', () {
    test('should validate even numbers as valid', () {
      // Arrange
      final controller = FieldController<int>(
          key: 'field1', initialValue: 4, validators: [EvenNumValidator()]);

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'evenNum');
      expect(result.message, 'evenNum'); // null message defaults to key
    });

    test('should validate odd numbers as invalid', () {
      // Arrange
      final controller = FieldController<int>(
          key: 'field1', initialValue: 3, validators: [EvenNumValidator()]);

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'evenNum');
      expect(result.message, 'evenNum'); // null message defaults to key
    });

    test('should validate zero as valid (even number)', () {
      // Arrange
      final controller = FieldController<int>(
          key: 'field1', initialValue: 0, validators: [EvenNumValidator()]);

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'evenNum');
      expect(result.message, 'evenNum');
    });

    test('should validate negative even numbers as valid', () {
      // Arrange
      final controller = FieldController<int>(
          key: 'field1', initialValue: -4, validators: [EvenNumValidator()]);

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'evenNum');
    });

    test('should validate negative odd numbers as invalid', () {
      // Arrange
      final controller = FieldController<int>(
          key: 'field1', initialValue: -3, validators: [EvenNumValidator()]);

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'evenNum');
    });

    test('should use custom message when provided', () {
      // Arrange
      const customMessage = 'Number must be even';
      final controller = FieldController<int>(
          key: 'field1',
          initialValue: 3,
          validators: [EvenNumValidator(message: customMessage)]);

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'evenNum');
      expect(result.message, customMessage);
    });

    test('should default to 2 when controller value is null', () {
      // Arrange
      final controller = FieldController<int>(
          key: 'field1', initialValue: null, validators: [EvenNumValidator()]);

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true); // 2 is even, so should be valid
      expect(result.key, 'evenNum');
      expect(result.message, 'evenNum');
    });

    test('should handle large even numbers', () {
      // Arrange
      final controller = FieldController<int>(
          key: 'field1',
          initialValue: 1000000,
          validators: [EvenNumValidator()]);

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, true);
      expect(result.key, 'evenNum');
    });

    test('should handle large odd numbers', () {
      // Arrange
      final controller = FieldController<int>(
          key: 'field1',
          initialValue: 1000001,
          validators: [EvenNumValidator()]);

      // Act
      final result = controller.validationResults.first;

      // Assert
      expect(result.isValid, false);
      expect(result.key, 'evenNum');
    });

    test('should maintain consistent key across all validations', () {
      // Arrange
      final evenController = FieldController<int>(
          key: 'field1', initialValue: 4, validators: [EvenNumValidator()]);
      final oddController = FieldController<int>(
          key: 'field2', initialValue: 5, validators: [EvenNumValidator()]);

      // Act
      final evenResult = evenController.validationResults.first;
      final oddResult = oddController.validationResults.first;

      // Assert
      expect(evenResult.key, 'evenNum');
      expect(oddResult.key, 'evenNum');
    });

    test('should work with different field controller keys', () {
      // Arrange
      final controller1 = FieldController<int>(
          key: 'different_field',
          initialValue: 8,
          validators: [EvenNumValidator()]);
      final controller2 = FieldController<int>(
          key: 'another_field',
          initialValue: 9,
          validators: [EvenNumValidator()]);

      // Act
      final result1 = controller1.validationResults.first;
      final result2 = controller2.validationResults.first;

      // Assert
      expect(result1.isValid, true);
      expect(result2.isValid, false);
      expect(result1.key, 'evenNum');
      expect(result2.key, 'evenNum');
    });
  });
}
