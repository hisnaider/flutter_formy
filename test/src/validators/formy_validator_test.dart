import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_base_validators.dart';
import 'package:flutter_test/flutter_test.dart';

class TestFormyValidator<T> extends FormyValidator<T> {
  TestFormyValidator({required super.message, required this.shouldBeValid});

  final bool shouldBeValid;

  @override
  ValidationResult onValidate(FieldController<T> controller) {
    return ValidationResult(
      key: 'test_validator',
      message: message,
      isValid: shouldBeValid,
    );
  }
}

// Another concrete implementation to test different scenarios
class ValueCheckValidator<T> extends FormyValidator<T> {
  ValueCheckValidator({required super.message, required this.expectedValue});

  final T? expectedValue;

  @override
  ValidationResult onValidate(FieldController<T> controller) {
    return ValidationResult(
      key: 'value_check',
      message: message,
      isValid: controller.value == expectedValue,
    );
  }
}

void main() {
  group('FormyValidator', () {
    test('should store message in constructor', () {
      final validator = TestFormyValidator<String>(
        message: 'Custom error message',
        shouldBeValid: true,
      );

      expect(validator.message, 'Custom error message');
    });

    test('should allow null message', () {
      final validator = TestFormyValidator<String>(
        message: null,
        shouldBeValid: true,
      );

      expect(validator.message, null);
    });

    test('should call onValidate when using call method', () {
      final controller = FieldController<String>(
        key: 'testField',
        initialValue: 'test value',
        validators: [
          TestFormyValidator<String>(
            message: 'Test message',
            shouldBeValid: true,
          )
        ],
      );

      final result = controller.validationResults.first;

      expect(result.key, 'test_validator');
      expect(result.message, 'Test message');
      expect(result.isValid, true);
    });

    test('should work with different generic types - String', () {
      final controller = FieldController<String>(
        key: 'stringField',
        initialValue: 'expected',
        validators: [
          ValueCheckValidator<String>(
            message: 'Value must be "expected"',
            expectedValue: 'expected',
          )
        ],
      );

      final result = controller.validationResults.first;

      expect(result.key, 'value_check');
      expect(result.message, 'Value must be "expected"');
      expect(result.isValid, true);
    });

    test('should work with different generic types - int', () {
      final controller = FieldController<int>(
        key: 'intField',
        initialValue: 42,
        validators: [
          ValueCheckValidator<int>(
            message: 'Value must be 42',
            expectedValue: 42,
          )
        ],
      );

      final result = controller.validationResults.first;

      expect(result.key, 'value_check');
      expect(result.message, 'Value must be 42');
      expect(result.isValid, true);
    });

    test('should return invalid result when validation fails', () {
      final controller = FieldController<String>(
        key: 'stringField',
        initialValue: 'different value',
        validators: [
          ValueCheckValidator<String>(
            message: 'Value must be "expected"',
            expectedValue: 'expected',
          )
        ],
      );

      final result = controller.validationResults.first;

      expect(result.key, 'value_check');
      expect(result.message, 'Value must be "expected"');
      expect(result.isValid, false);
    });

    test('should handle null field values', () {
      final controller = FieldController<String>(
        key: 'nullField',
        initialValue: null,
        validators: [
          ValueCheckValidator<String>(
            message: 'Value must be null',
            expectedValue: null,
          )
        ],
      );

      final result = controller.validationResults.first;

      expect(result.key, 'value_check');
      expect(result.message, 'Value must be null');
      expect(result.isValid, true);
    });

    test('should be callable as function due to call method', () {
      final validator = TestFormyValidator<String>(
        message: 'Callable test',
        shouldBeValid: false,
      );

      final controller = FieldController<String>(
        key: 'callableField',
        initialValue: 'test',
        validators: [validator],
      );

      // Test direct call method usage
      final directResult = validator.call(controller);
      final validationResult = controller.validationResults.first;

      expect(directResult.key, validationResult.key);
      expect(directResult.message, validationResult.message);
      expect(directResult.isValid, validationResult.isValid);
      expect(directResult.isValid, false);
    });

    test('should work with multiple validators on same field', () {
      final controller = FieldController<String>(
        key: 'multiValidatorField',
        initialValue: 'test',
        validators: [
          TestFormyValidator<String>(
            message: 'First validator',
            shouldBeValid: true,
          ),
          ValueCheckValidator<String>(
            message: 'Second validator',
            expectedValue: 'test',
          )
        ],
      );

      final results = controller.validationResults;

      expect(results.length, 2);
      expect(results[0].key, 'test_validator');
      expect(results[0].isValid, true);
      expect(results[1].key, 'value_check');
      expect(results[1].isValid, true);
    });

    test('should work with bool generic type', () {
      final controller = FieldController<bool>(
        key: 'boolField',
        initialValue: true,
        validators: [
          ValueCheckValidator<bool>(
            message: 'Value must be true',
            expectedValue: true,
          )
        ],
      );

      final result = controller.validationResults.first;

      expect(result.key, 'value_check');
      expect(result.message, 'Value must be true');
      expect(result.isValid, true);
    });

    test('should use onValidate method when validator is executed', () {
      final validator = TestFormyValidator<String>(
        message: 'Direct validation test',
        shouldBeValid: true,
      );

      final controller = FieldController<String>(
        key: 'directField',
        initialValue: 'direct value',
        validators: [],
      );

      // Test direct onValidate method call
      final result = validator.onValidate(controller);

      expect(result.key, 'test_validator');
      expect(result.message, 'Direct validation test');
      expect(result.isValid, true);
    });

    test('should handle empty string values', () {
      final controller = FieldController<String>(
        key: 'emptyField',
        initialValue: '',
        validators: [
          ValueCheckValidator<String>(
            message: 'Value must be empty',
            expectedValue: '',
          )
        ],
      );

      final result = controller.validationResults.first;

      expect(result.key, 'value_check');
      expect(result.message, 'Value must be empty');
      expect(result.isValid, true);
    });

    test('should handle double generic type', () {
      final controller = FieldController<double>(
        key: 'doubleField',
        initialValue: 3.14,
        validators: [
          ValueCheckValidator<double>(
            message: 'Value must be 3.14',
            expectedValue: 3.14,
          )
        ],
      );

      final result = controller.validationResults.first;

      expect(result.key, 'value_check');
      expect(result.message, 'Value must be 3.14');
      expect(result.isValid, true);
    });
  });
}
