import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/validators/generic_validators/exact_length_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExactLengthValidator Tests', () {
    late ExactLengthValidator validator;

    setUp(() {
      validator = ExactLengthValidator(
        5,
        message: 'Value must be exactly 5 characters/items',
      );
    });

    group('String validation', () {
      test('should return valid for string with exact length', () {
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'hello', // exactly 5 characters
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
        expect(result.key, GenericValidators.exactLength.name);
        expect(result.message, 'Value must be exactly 5 characters/items');
      });

      test('should return invalid for string shorter than exact length', () {
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'hi', // 2 characters
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for string longer than exact length', () {
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'hello world', // 11 characters
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return valid for empty string when exact length is 0', () {
        final zeroLengthValidator = ExactLengthValidator<String>(0);

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: '',
        );

        final result = zeroLengthValidator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for empty string when exact length is not 0',
          () {
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: '',
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });
    });

    group('List validation', () {
      test('should return valid for list with exact length', () {
        final controller = FieldListController<String>(
          key: 'field1',
          initialValue: ['a', 'b', 'c', 'd', 'e'], // exactly 5 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for list shorter than exact length', () {
        final controller = FieldListController<int>(
          key: 'field1',
          initialValue: [1, 2, 3], // 3 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for list longer than exact length', () {
        final controller = FieldListController<int>(
          key: 'field1',
          initialValue: [1, 2, 3, 4, 5, 6, 7], // 7 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return valid for empty list when exact length is 0', () {
        final zeroLengthValidator = ExactLengthValidator<List<String>>(0);

        final controller = FieldListController<String>(
          key: 'field1',
          initialValue: [],
        );

        final result = zeroLengthValidator.onValidate(controller);

        expect(result.isValid, true);
      });
    });

    group('Map validation', () {
      test('should return valid for map with exact length', () {
        final controller = FieldController<Map<String, int>>(
          key: 'field1',
          initialValue: {
            'a': 1,
            'b': 2,
            'c': 3,
            'd': 4,
            'e': 5
          }, // exactly 5 entries
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for map shorter than exact length', () {
        final controller = FieldController<Map<String, int>>(
          key: 'field1',
          initialValue: {'a': 1, 'b': 2}, // 2 entries
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for map longer than exact length', () {
        final controller = FieldController<Map<String, int>>(
          key: 'field1',
          initialValue: {
            'a': 1,
            'b': 2,
            'c': 3,
            'd': 4,
            'e': 5,
            'f': 6,
            'g': 7
          }, // 7 entries
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return valid for empty map when exact length is 0', () {
        final zeroLengthValidator = ExactLengthValidator<Map<String, int>>(0);

        final controller = FieldController<Map<String, int>>(
          key: 'field1',
          initialValue: {},
        );

        final result = zeroLengthValidator.onValidate(controller);

        expect(result.isValid, true);
      });
    });

    group('Set validation', () {
      test('should return valid for set with exact length', () {
        final controller = FieldController<Set<String>>(
          key: 'field1',
          initialValue: {'a', 'b', 'c', 'd', 'e'}, // exactly 5 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for set shorter than exact length', () {
        final controller = FieldController<Set<int>>(
          key: 'field1',
          initialValue: {1, 2, 3}, // 3 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return invalid for set longer than exact length', () {
        final controller = FieldController<Set<int>>(
          key: 'field1',
          initialValue: {1, 2, 3, 4, 5, 6, 7, 8}, // 8 elements
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return valid for empty set when exact length is 0', () {
        final zeroLengthValidator = ExactLengthValidator<Set<String>>(0);

        final controller = FieldController<Set<String>>(
          key: 'field1',
          initialValue: {},
        );

        final result = zeroLengthValidator.onValidate(controller);

        expect(result.isValid, true);
      });
    });

    group('Numeric validation', () {
      test('should return valid for int equal to exact length', () {
        final controller = FieldController<int>(
          key: 'field1',
          initialValue: 5, // exactly 5
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for int not equal to exact length', () {
        final controller = FieldController<int>(
          key: 'field1',
          initialValue: 10, // not 5
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return valid for double equal to exact length', () {
        final controller = FieldController<double>(
          key: 'field1',
          initialValue: 5.0, // exactly 5.0
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return invalid for double not equal to exact length', () {
        final controller = FieldController<double>(
          key: 'field1',
          initialValue: 5.5, // not 5
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, false);
      });

      test('should return valid for negative number equal to exact length', () {
        final negativeValidator = ExactLengthValidator<int>(-3);

        final controller = FieldController<int>(
          key: 'field1',
          initialValue: -3, // exactly -3
        );

        final result = negativeValidator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should return valid for zero when exact length is 0', () {
        final zeroValidator = ExactLengthValidator<int>(0);

        final controller = FieldController<int>(
          key: 'field1',
          initialValue: 0, // exactly 0
        );

        final result = zeroValidator.onValidate(controller);

        expect(result.isValid, true);
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
        final customValidator = ExactLengthValidator<String>(
          3,
          message: 'Custom validation message',
        );

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'ab', // not 3 characters
        );

        final result = customValidator.onValidate(controller);

        expect(result.message, 'Custom validation message');
      });

      test('should handle null message', () {
        final validatorWithNullMessage = ExactLengthValidator<String>(
          5,
          message: null,
        );

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'hello',
        );

        final result = validatorWithNullMessage.onValidate(controller);

        expect(result.message, GenericValidators.exactLength.name);
      });
    });

    group('Edge cases', () {
      test('should handle exact length 1', () {
        final singleLengthValidator = ExactLengthValidator<String>(1);

        final validController = FieldController<String>(
          key: 'field1',
          initialValue: 'a', // exactly 1 character
        );

        final invalidController = FieldController<String>(
          key: 'field2',
          initialValue: 'ab', // 2 characters
        );

        expect(singleLengthValidator.onValidate(validController).isValid, true);
        expect(
            singleLengthValidator.onValidate(invalidController).isValid, false);
      });

      test('should handle large exact length', () {
        final largeValidator = ExactLengthValidator<String>(100);

        final validString = 'a' * 100; // exactly 100 characters
        final controller = FieldController<String>(
          key: 'field1',
          initialValue: validString,
        );

        final result = largeValidator.onValidate(controller);

        expect(result.isValid, true);
      });

      test('should handle exact length 0 for different types', () {
        final zeroValidator = ExactLengthValidator(0);

        // Test with different types
        final stringController = FieldController<String>(
          key: 'field1',
          initialValue: '',
        );

        final listController = FieldListController<int>(
          key: 'field2',
          initialValue: [],
        );

        final mapController = FieldController<Map<String, int>>(
          key: 'field3',
          initialValue: {},
        );

        final setController = FieldController<Set<int>>(
          key: 'field4',
          initialValue: {},
        );

        final numController = FieldController<int>(
          key: 'field5',
          initialValue: 0,
        );

        expect(zeroValidator.onValidate(stringController).isValid, true);
        expect(zeroValidator.onValidate(listController).isValid, true);
        expect(zeroValidator.onValidate(mapController).isValid, true);
        expect(zeroValidator.onValidate(setController).isValid, true);
        expect(zeroValidator.onValidate(numController).isValid, true);
      });
    });

    group('Constructor validation', () {
      test('should create validator with positional parameter', () {
        final validator1 = ExactLengthValidator<String>(10);

        expect(validator1.exactLength, 10);
        expect(validator1.message, null);
      });

      test('should create validator with message', () {
        final validator2 = ExactLengthValidator<String>(
          5,
          message: 'Test message',
        );

        expect(validator2.exactLength, 5);
        expect(validator2.message, 'Test message');
      });
    });
  });
}
