import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BetweenLengthValidator Tests', () {
    late BetweenLengthValidator validator;

    setUp(() {
      validator = BetweenLengthValidator(
        minLength: 3,
        maxLength: 10,
        message: 'Value must be between 3 and 10 characters',
      );
    });

    group('String validation', () {
      test('should return valid for string within range', () {
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'hello', // 5 characters
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
        expect(result.key, GenericValidators.betweenLength.name);
        expect(result.message, 'Value must be between 3 and 10 characters');
      });

      test('should return valid for string at minimum length', () {
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'abc', // 3 characters
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return valid for string at maximum length', () {
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: '1234567890', // 10 characters
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for string below minimum length', () {
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'ab', // 2 characters
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for string above maximum length', () {
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: '12345678901', // 11 characters
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return valid for empty string when minLength is 0', () {
        final validatorWithZeroMin = BetweenLengthValidator<String>(
          minLength: 0,
          maxLength: 5,
        );

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: '',
        );

        final result = validatorWithZeroMin.onValidate(controller);

        expect(result.isValid, true);
      });
    });

    group('List validation', () {
      test('should return valid for list within range', () {
        final controller = FieldListController<String>(
          key: 'field1',
          initialValue: ['a', 'b', 'c', 'd', 'e'], // 5 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return valid for list at minimum length', () {
        final controller = FieldListController<int>(
          key: 'field1',
          initialValue: [1, 2, 3], // 3 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return valid for list at maximum length', () {
        final controller = FieldListController<int>(
          key: 'field1',
          initialValue: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], // 10 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for list below minimum length', () {
        final controller = FieldListController<String>(
          key: 'field1',
          initialValue: ['a', 'b'], // 2 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for list above maximum length', () {
        final controller = FieldListController<int>(
          key: 'field1',
          initialValue: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], // 11 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });
    });

    group('Map validation', () {
      test('should return valid for map within range', () {
        final controller = FieldController<Map<String, int>>(
          key: 'field1',
          initialValue: {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5}, // 5 entries
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for map below minimum length', () {
        final controller = FieldController<Map<String, int>>(
          key: 'field1',
          initialValue: {'a': 1, 'b': 2}, // 2 entries
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for map above maximum length', () {
        final controller = FieldController<Map<String, int>>(
          key: 'field1',
          initialValue: {
            'a': 1,
            'b': 2,
            'c': 3,
            'd': 4,
            'e': 5,
            'f': 6,
            'g': 7,
            'h': 8,
            'i': 9,
            'j': 10,
            'k': 11
          }, // 11 entries
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });
    });

    group('Set validation', () {
      test('should return valid for set within range', () {
        final controller = FieldController<Set<String>>(
          key: 'field1',
          initialValue: {'a', 'b', 'c', 'd', 'e'}, // 5 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for set below minimum length', () {
        final controller = FieldController<Set<int>>(
          key: 'field1',
          initialValue: {1, 2}, // 2 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for set above maximum length', () {
        final controller = FieldController<Set<int>>(
          key: 'field1',
          initialValue: {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}, // 11 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });
    });

    group('Null value validation', () {
      test('should return valid for null value', () {
        final controller = FieldController<String?>(
          key: 'field1',
          initialValue: null,
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });
    });

    group('Unsupported type validation', () {
      test('should return invalid for unsupported type (int)', () {
        final controller = FieldController<int>(
          key: 'field1',
          initialValue: 42,
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for unsupported type (double)', () {
        final controller = FieldController<double>(
          key: 'field1',
          initialValue: 3.14,
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for unsupported type (bool)', () {
        final controller = FieldController<bool>(
          key: 'field1',
          initialValue: true,
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for custom object', () {
        final controller = FieldController<DateTime>(
          key: 'field1',
          initialValue: DateTime.now(),
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });
    });

    group('Custom message validation', () {
      test('should use custom message when provided', () {
        final customValidator = BetweenLengthValidator<String>(
          minLength: 5,
          maxLength: 15,
          message: 'Custom validation message',
        );

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test',
        );

        final result = customValidator.onValidate(controller);

        expect(result.message, 'Custom validation message');
      });

      test('should handle null message', () {
        final validatorWithNullMessage = BetweenLengthValidator<String>(
          minLength: 3,
          maxLength: 10,
          message: null,
        );

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test',
        );

        final result = validatorWithNullMessage.onValidate(controller);

        expect(result.message, GenericValidators.betweenLength.name);
      });
    });

    group('Edge cases', () {
      test('should handle minLength equal to maxLength', () {
        final singleLengthValidator = BetweenLengthValidator<String>(
          minLength: 5,
          maxLength: 5,
        );

        final validController = FieldController<String>(
          key: 'field1',
          initialValue: 'hello', // exactly 5 characters
        );

        final invalidController = FieldController<String>(
          key: 'field2',
          initialValue: 'hi', // 2 characters
        );

        expect(singleLengthValidator.onValidate(validController).isValid, true);
        expect(
            singleLengthValidator.onValidate(invalidController).isValid, false);
      });

      test('should handle zero minLength', () {
        final zeroMinValidator = BetweenLengthValidator<String>(
          minLength: 0,
          maxLength: 5,
        );

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: '',
        );

        final result = zeroMinValidator.onValidate(controller);

        expect(result.isValid, true);
      });
    });
  });
}
