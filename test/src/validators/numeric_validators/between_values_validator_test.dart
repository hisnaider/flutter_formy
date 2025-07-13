import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_numeric_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BetweenValuesValidator', () {
    test('should create a valid instance with correct values', () {
      final validator = BetweenValuesValidator(
        minValue: 0,
        maxValue: 100,
      );

      expect(validator.minValue, equals(0));
      expect(validator.maxValue, equals(100));
    });

    test('should create a valid instance with equal values', () {
      final validator = BetweenValuesValidator(
        minValue: 50,
        maxValue: 50,
      );

      expect(validator.minValue, equals(50));
      expect(validator.maxValue, equals(50));
    });

    test('should throw AssertionError when minValue > maxValue', () {
      expect(
        () => BetweenValuesValidator(
          minValue: 100,
          maxValue: 50,
        ),
        throwsAssertionError,
      );
    });

    test('should accept custom message', () {
      const customMessage = 'Value must be between 0 and 100';
      final validator = BetweenValuesValidator(
        minValue: 0,
        maxValue: 100,
        message: customMessage,
      );

      expect(validator.message, equals(customMessage));
    });

    group('onValidate', () {
      late BetweenValuesValidator validator;

      setUp(() {
        validator = BetweenValuesValidator(
          minValue: 10,
          maxValue: 90,
          message: 'Value must be between 10 and 90',
        );
      });

      test('should return valid when value is within range', () {
        final controller = FieldController<num>(key: 'test', initialValue: 50);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.betweenValues.name));
        expect(result.message, equals('Value must be between 10 and 90'));
      });

      test('should return valid when value equals minimum', () {
        final controller = FieldController<num>(key: 'test', initialValue: 10);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should return valid when value equals maximum', () {
        final controller = FieldController<num>(key: 'test', initialValue: 90);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should return invalid when value is less than minimum', () {
        final controller = FieldController<num>(key: 'test', initialValue: 5);
        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
        expect(result.key, equals(GenericValidators.betweenValues.name));
        expect(result.message, equals('Value must be between 10 and 90'));
      });

      test('should return invalid when value is greater than maximum', () {
        final controller = FieldController<num>(key: 'test', initialValue: 95);
        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
        expect(result.key, equals(GenericValidators.betweenValues.name));
        expect(result.message, equals('Value must be between 10 and 90'));
      });

      test('should return valid when value is null', () {
        final controller =
            FieldController<num>(key: 'test', initialValue: null);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.betweenValues.name));
        expect(result.message, equals('Value must be between 10 and 90'));
      });

      test('should work with decimal values', () {
        final decimalValidator = BetweenValuesValidator(
          minValue: 1.5,
          maxValue: 5.7,
        );

        // Valid value
        final validController =
            FieldController<num>(key: 'test', initialValue: 3.2);
        final validResult = decimalValidator.onValidate(validController);
        expect(validResult.isValid, isTrue);

        // Invalid value (too low)
        final invalidLowController =
            FieldController<num>(key: 'test', initialValue: 1.2);
        final invalidLowResult =
            decimalValidator.onValidate(invalidLowController);
        expect(invalidLowResult.isValid, isFalse);

        // Invalid value (too high)
        final invalidHighController =
            FieldController<num>(key: 'test', initialValue: 6.0);
        final invalidHighResult =
            decimalValidator.onValidate(invalidHighController);
        expect(invalidHighResult.isValid, isFalse);
      });

      test('should work with negative values', () {
        final negativeValidator = BetweenValuesValidator(
          minValue: -100,
          maxValue: -10,
        );

        // Valid value
        final validController =
            FieldController<num>(key: 'test', initialValue: -50);
        final validResult = negativeValidator.onValidate(validController);
        expect(validResult.isValid, isTrue);

        // Invalid value (too low)
        final invalidLowController =
            FieldController<num>(key: 'test', initialValue: -150);
        final invalidLowResult =
            negativeValidator.onValidate(invalidLowController);
        expect(invalidLowResult.isValid, isFalse);

        // Invalid value (too high)
        final invalidHighController =
            FieldController<num>(key: 'test', initialValue: 0);
        final invalidHighResult =
            negativeValidator.onValidate(invalidHighController);
        expect(invalidHighResult.isValid, isFalse);
      });

      test('should work with range that includes zero', () {
        final zeroValidator = BetweenValuesValidator(
          minValue: -10,
          maxValue: 10,
        );

        final zeroController =
            FieldController<num>(key: 'test', initialValue: 0);
        final result = zeroValidator.onValidate(zeroController);
        expect(result.isValid, isTrue);
      });

      test('should work with int and double', () {
        final validator = BetweenValuesValidator(
          minValue: 1,
          maxValue: 10,
        );

        // Test with int
        final intController =
            FieldController<num>(key: 'test', initialValue: 5);
        final intResult = validator.onValidate(intController);
        expect(intResult.isValid, isTrue);

        // Test with double
        final doubleController =
            FieldController<num>(key: 'test', initialValue: 5.5);
        final doubleResult = validator.onValidate(doubleController);
        expect(doubleResult.isValid, isTrue);
      });
    });

    group('Edge cases', () {
      test('should work with very large values', () {
        final validator = BetweenValuesValidator(
          minValue: 1000000,
          maxValue: 9999999,
        );

        final controller =
            FieldController<num>(key: 'test', initialValue: 5000000);
        final result = validator.onValidate(controller);
        expect(result.isValid, isTrue);
      });

      test('should work with very small values', () {
        final validator = BetweenValuesValidator(
          minValue: 0.001,
          maxValue: 0.999,
        );

        final controller = FieldController<num>(key: 'test', initialValue: 0.5);
        final result = validator.onValidate(controller);
        expect(result.isValid, isTrue);
      });

      test('should work with single value range', () {
        final validator = BetweenValuesValidator(
          minValue: 42,
          maxValue: 42,
        );

        // Correct value
        final validController =
            FieldController<num>(key: 'test', initialValue: 42);
        final validResult = validator.onValidate(validController);
        expect(validResult.isValid, isTrue);

        // Incorrect value
        final invalidController =
            FieldController<num>(key: 'test', initialValue: 41);
        final invalidResult = validator.onValidate(invalidController);
        expect(invalidResult.isValid, isFalse);
      });
    });
  });
}
