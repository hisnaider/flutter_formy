import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_numeric_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DivisibleByValidator', () {
    test('should create a valid instance with positive denominator', () {
      final validator = DivisibleByValidator(5);

      expect(validator.denominator, equals(5));
    });

    test('should create a valid instance with negative denominator', () {
      final validator = DivisibleByValidator(-3);

      expect(validator.denominator, equals(-3));
    });

    test('should throw AssertionError when denominator is 0', () {
      expect(
        () => DivisibleByValidator(0),
        throwsAssertionError,
      );
    });

    test('should accept custom message', () {
      const customMessage = 'Value must be divisible by 5';
      final validator = DivisibleByValidator(5, message: customMessage);

      expect(validator.message, equals(customMessage));
    });

    group('onValidate', () {
      late DivisibleByValidator validator;

      setUp(() {
        validator =
            DivisibleByValidator(3, message: 'Value must be divisible by 3');
      });

      test('should return valid when value is divisible by denominator', () {
        final controller = FieldController<int>(key: 'test', initialValue: 9);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.divisibleBy.name));
        expect(result.message, equals('Value must be divisible by 3'));
      });

      test('should return invalid when value is not divisible by denominator',
          () {
        final controller = FieldController<int>(key: 'test', initialValue: 10);
        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
        expect(result.key, equals(GenericValidators.divisibleBy.name));
        expect(result.message, equals('Value must be divisible by 3'));
      });

      test('should return valid when value is zero', () {
        final controller = FieldController<int>(key: 'test', initialValue: 0);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should return valid when value is null', () {
        final controller =
            FieldController<int>(key: 'test', initialValue: null);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should work with negative divisible values', () {
        final controller = FieldController<int>(key: 'test', initialValue: -6);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should work with negative non-divisible values', () {
        final controller = FieldController<int>(key: 'test', initialValue: -7);
        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
      });

      test('should work when value equals denominator', () {
        final controller = FieldController<int>(key: 'test', initialValue: 3);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should work when value is multiple of denominator', () {
        final testCases = [3, 6, 9, 12, 15, 18];

        for (final testValue in testCases) {
          final controller =
              FieldController<int>(key: 'test', initialValue: testValue);
          final result = validator.onValidate(controller);

          expect(result.isValid, isTrue,
              reason: '$testValue should be divisible by 3');
        }
      });

      test('should work when value is not multiple of denominator', () {
        final testCases = [1, 2, 4, 5, 7, 8, 10, 11];

        for (final testValue in testCases) {
          final controller =
              FieldController<int>(key: 'test', initialValue: testValue);
          final result = validator.onValidate(controller);

          expect(result.isValid, isFalse,
              reason: '$testValue should not be divisible by 3');
        }
      });
    });

    group('Different denominators', () {
      test('should work with denominator 1', () {
        final validator = DivisibleByValidator(1);

        // Any number should be divisible by 1
        final testCases = [1, 2, 5, 10, 100, -5, -10];

        for (final testValue in testCases) {
          final controller =
              FieldController<int>(key: 'test', initialValue: testValue);
          final result = validator.onValidate(controller);

          expect(result.isValid, isTrue,
              reason: '$testValue should be divisible by 1');
        }
      });

      test('should work with denominator 2 (even numbers)', () {
        final validator = DivisibleByValidator(2);

        // Even numbers
        final evenNumbers = [0, 2, 4, 6, 8, 10, -2, -4, -6];
        for (final num in evenNumbers) {
          final controller =
              FieldController<int>(key: 'test', initialValue: num);
          final result = validator.onValidate(controller);

          expect(result.isValid, isTrue,
              reason: '$num should be divisible by 2');
        }

        // Odd numbers
        final oddNumbers = [1, 3, 5, 7, 9, 11, -1, -3, -5];
        for (final num in oddNumbers) {
          final controller =
              FieldController<int>(key: 'test', initialValue: num);
          final result = validator.onValidate(controller);

          expect(result.isValid, isFalse,
              reason: '$num should not be divisible by 2');
        }
      });

      test('should work with denominator 5', () {
        final validator = DivisibleByValidator(5);

        // Divisible by 5
        final divisibleBy5 = [0, 5, 10, 15, 20, 25, -5, -10, -15];
        for (final num in divisibleBy5) {
          final controller =
              FieldController<int>(key: 'test', initialValue: num);
          final result = validator.onValidate(controller);

          expect(result.isValid, isTrue,
              reason: '$num should be divisible by 5');
        }

        // Not divisible by 5
        final notDivisibleBy5 = [1, 2, 3, 4, 6, 7, 8, 9, 11, 12, 13, 14];
        for (final num in notDivisibleBy5) {
          final controller =
              FieldController<int>(key: 'test', initialValue: num);
          final result = validator.onValidate(controller);

          expect(result.isValid, isFalse,
              reason: '$num should not be divisible by 5');
        }
      });

      test('should work with denominator 10', () {
        final validator = DivisibleByValidator(10);

        // Divisible by 10
        final divisibleBy10 = [0, 10, 20, 30, 100, 1000, -10, -20, -30];
        for (final num in divisibleBy10) {
          final controller =
              FieldController<int>(key: 'test', initialValue: num);
          final result = validator.onValidate(controller);

          expect(result.isValid, isTrue,
              reason: '$num should be divisible by 10');
        }

        // Not divisible by 10
        final notDivisibleBy10 = [1, 5, 15, 25, 35, 45, 55, 65, 75, 85, 95];
        for (final num in notDivisibleBy10) {
          final controller =
              FieldController<int>(key: 'test', initialValue: num);
          final result = validator.onValidate(controller);

          expect(result.isValid, isFalse,
              reason: '$num should not be divisible by 10');
        }
      });

      test('should work with negative denominator', () {
        final validator = DivisibleByValidator(-4);

        // Divisible by -4 (same result as divisible by 4)
        final divisibleBy4 = [0, 4, 8, 12, 16, -4, -8, -12];
        for (final num in divisibleBy4) {
          final controller =
              FieldController<int>(key: 'test', initialValue: num);
          final result = validator.onValidate(controller);

          expect(result.isValid, isTrue,
              reason: '$num should be divisible by -4');
        }

        // Not divisible by -4
        final notDivisibleBy4 = [1, 2, 3, 5, 6, 7, 9, 10, 11, 13, 14, 15];
        for (final num in notDivisibleBy4) {
          final controller =
              FieldController<int>(key: 'test', initialValue: num);
          final result = validator.onValidate(controller);

          expect(result.isValid, isFalse,
              reason: '$num should not be divisible by -4');
        }
      });
    });

    group('Edge cases', () {
      test('should work with very large numbers', () {
        final validator = DivisibleByValidator(1000);

        final controller =
            FieldController<int>(key: 'test', initialValue: 5000);
        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should work with very large non-divisible numbers', () {
        final validator = DivisibleByValidator(1000);

        final controller =
            FieldController<int>(key: 'test', initialValue: 5001);
        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
      });

      test('should work with very large denominator', () {
        final validator = DivisibleByValidator(999999);

        // Divisible value
        final validController =
            FieldController<int>(key: 'test', initialValue: 999999);
        final validResult = validator.onValidate(validController);
        expect(validResult.isValid, isTrue);

        // Non-divisible value
        final invalidController =
            FieldController<int>(key: 'test', initialValue: 1000000);
        final invalidResult = validator.onValidate(invalidController);
        expect(invalidResult.isValid, isFalse);
      });

      test('should handle null values correctly', () {
        final validator = DivisibleByValidator(7);

        final controller =
            FieldController<int>(key: 'test', initialValue: null);
        final result = validator.onValidate(controller);

        // When value is null, uses denominator as default
        // null ?? 7 = 7, and 7 % 7 = 0, so should be valid
        expect(result.isValid, isTrue);
      });
    });

    group('Mathematical properties', () {
      test(
          'should follow property: if a is divisible by b, then a is multiple of b',
          () {
        final validator = DivisibleByValidator(6);

        // Multiples of 6
        final multiples = [0, 6, 12, 18, 24, 30, 36, -6, -12, -18];

        for (final multiple in multiples) {
          final controller =
              FieldController<int>(key: 'test', initialValue: multiple);
          final result = validator.onValidate(controller);

          expect(result.isValid, isTrue,
              reason: '$multiple should be divisible by 6');
        }
      });

      test('should follow property: zero is divisible by any non-zero number',
          () {
        final denominators = [1, 2, 3, 4, 5, 7, 10, 100, -1, -2, -5];

        for (final denom in denominators) {
          final validator = DivisibleByValidator(denom);
          final controller = FieldController<int>(key: 'test', initialValue: 0);
          final result = validator.onValidate(controller);

          expect(result.isValid, isTrue,
              reason: '0 should be divisible by $denom');
        }
      });
    });
  });
}
