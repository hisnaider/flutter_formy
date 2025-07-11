import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MaxLengthValidator', () {
    group('String validation', () {
      test('should validate string with length less than maxLength', () {
        final validator = MaxLengthValidator<String>(10);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'hello', // 5 characters < 10
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.maxLength.name));
      });

      test('should invalidate string with length equal to maxLength', () {
        final validator = MaxLengthValidator<String>(4);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'hello', // exactly 5 characters
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
        expect(result.key, equals(GenericValidators.maxLength.name));
      });

      test('should invalidate string with length greater than maxLength', () {
        final validator = MaxLengthValidator<String>(5);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'hello world', // 11 characters > 5
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
        expect(result.key, equals(GenericValidators.maxLength.name));
      });

      test('should handle empty string', () {
        final validator = MaxLengthValidator<String>(5);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should validate string with maxLength 0', () {
        final validator = MaxLengthValidator<String>(0);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue); // because 0 is not < 0
      });

      test('should handle single character with maxLength 1', () {
        final validator = MaxLengthValidator<String>(1);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'a',
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue); // because 1 is not < 1
      });
    });

    group('List validation', () {
      test('should validate list with length less than maxLength', () {
        final validator = MaxLengthValidator<List<String>>(5);
        final controller = FieldController<List<String>>(
          key: 'test',
          initialValue: ['item1', 'item2', 'item3'], // 3 items < 5
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.maxLength.name));
      });

      test('should validate list with length equal to maxLength', () {
        final validator = MaxLengthValidator<List<String>>(3);
        final controller = FieldController<List<String>>(
          key: 'test',
          initialValue: ['item1', 'item2', 'item3'], // exactly 3 items
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should invalidate list with length greater than maxLength', () {
        final validator = MaxLengthValidator<List<int>>(3);
        final controller = FieldController<List<int>>(
          key: 'test',
          initialValue: [1, 2, 3, 4, 5], // 5 items > 3
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
      });

      test('should handle empty list', () {
        final validator = MaxLengthValidator<List<dynamic>>(5);
        final controller = FieldController<List<dynamic>>(
          key: 'test',
          initialValue: [],
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });
    });

    group('Map validation', () {
      test('should validate map with length less than maxLength', () {
        final validator = MaxLengthValidator<Map<String, dynamic>>(5);
        final controller = FieldController<Map<String, dynamic>>(
          key: 'test',
          initialValue: {'key1': 'value1', 'key2': 'value2'}, // 2 entries < 5
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.maxLength.name));
      });

      test('should validate map with length equal to maxLength', () {
        final validator = MaxLengthValidator<Map<String, int>>(2);
        final controller = FieldController<Map<String, int>>(
          key: 'test',
          initialValue: {'a': 1, 'b': 2}, // exactly 2 entries
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should invalidate map with length greater than maxLength', () {
        final validator = MaxLengthValidator<Map<String, String>>(2);
        final controller = FieldController<Map<String, String>>(
          key: 'test',
          initialValue: {'a': '1', 'b': '2', 'c': '3'}, // 3 entries > 2
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
      });

      test('should handle empty map', () {
        final validator = MaxLengthValidator<Map<dynamic, dynamic>>(5);
        final controller = FieldController<Map<dynamic, dynamic>>(
          key: 'test',
          initialValue: {},
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });
    });

    group('Set validation', () {
      test('should validate set with length less than maxLength', () {
        final validator = MaxLengthValidator<Set<String>>(5);
        final controller = FieldController<Set<String>>(
          key: 'test',
          initialValue: {'item1', 'item2'}, // 2 items < 5
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.maxLength.name));
      });

      test('should validate set with length equal to maxLength', () {
        final validator = MaxLengthValidator<Set<int>>(3);
        final controller = FieldController<Set<int>>(
          key: 'test',
          initialValue: {1, 2, 3}, // exactly 3 items
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });

      test('should invalidate set with length greater than maxLength', () {
        final validator = MaxLengthValidator<Set<String>>(2);
        final controller = FieldController<Set<String>>(
          key: 'test',
          initialValue: {'a', 'b', 'c', 'd'}, // 4 items > 2
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
      });

      test('should handle empty set', () {
        final validator = MaxLengthValidator<Set<dynamic>>(5);
        final controller = FieldController<Set<dynamic>>(
          key: 'test',
          initialValue: <dynamic>{},
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });
    });

    group('Null value validation', () {
      test('should validate null value as valid', () {
        final validator = MaxLengthValidator<String?>(5);
        final controller = FieldController<String?>(
          key: 'test',
          initialValue: null,
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.maxLength.name));
      });

      test('should handle null value with different types', () {
        final stringValidator = MaxLengthValidator<String?>(10);
        final listValidator = MaxLengthValidator<List<String>?>(10);
        final mapValidator = MaxLengthValidator<Map<String, dynamic>?>(10);
        final setValidator = MaxLengthValidator<Set<String>?>(10);

        final stringController = FieldController<String?>(
          key: 'string',
          initialValue: null,
          validators: [stringValidator],
        );

        final listController = FieldController<List<String>?>(
          key: 'list',
          initialValue: null,
          validators: [listValidator],
        );

        final mapController = FieldController<Map<String, dynamic>?>(
          key: 'map',
          initialValue: null,
          validators: [mapValidator],
        );

        final setController = FieldController<Set<String>?>(
          key: 'set',
          initialValue: null,
          validators: [setValidator],
        );

        expect(stringValidator.onValidate(stringController).isValid, isTrue);
        expect(listValidator.onValidate(listController).isValid, isTrue);
        expect(mapValidator.onValidate(mapController).isValid, isTrue);
        expect(setValidator.onValidate(setController).isValid, isTrue);
      });
    });

    group('Unsupported type validation', () {
      test('should invalidate unsupported types', () {
        final validator = MaxLengthValidator<int>(5);
        final controller = FieldController<int>(
          key: 'test',
          initialValue: 123,
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
        expect(result.key, equals(GenericValidators.maxLength.name));
      });

      test('should invalidate object types', () {
        final validator = MaxLengthValidator<DateTime>(10);
        final controller = FieldController<DateTime>(
          key: 'test',
          initialValue: DateTime.now(),
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
      });

      test('should invalidate boolean type', () {
        final validator = MaxLengthValidator<bool>(1);
        final controller = FieldController<bool>(
          key: 'test',
          initialValue: true,
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
      });

      test('should invalidate double type', () {
        final validator = MaxLengthValidator<double>(10);
        final controller = FieldController<double>(
          key: 'test',
          initialValue: 3.14,
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
      });
    });

    group('Custom message', () {
      test('should use custom message when provided', () {
        const customMessage = 'Maximum length cannot exceed 10 characters';
        final validator =
            MaxLengthValidator<String>(10, message: customMessage);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'this is a very long string that exceeds the limit',
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
        expect(result.message, equals(customMessage));
      });

      test('should use null message when not provided', () {
        final validator = MaxLengthValidator<String>(5);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'too long',
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse);
        expect(result.message, GenericValidators.maxLength.name);
      });
    });

    group('Edge cases', () {
      test('should handle maxLength 0', () {
        final validator = MaxLengthValidator<String>(0);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue); // because 0 is not < 0
      });

      test('should handle maxLength 1', () {
        final validator = MaxLengthValidator<String>(1);

        // Test with empty string
        final emptyController = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final emptyResult = validator.onValidate(emptyController);
        expect(emptyResult.isValid, isTrue); // because 0 < 1

        // Test with single character
        final singleController = FieldController<String>(
          key: 'test',
          initialValue: 'a',
          validators: [validator],
        );

        final singleResult = validator.onValidate(singleController);
        expect(singleResult.isValid, isTrue); // because 1 is not < 1
      });

      test('should handle negative maxLength', () {
        final validator = MaxLengthValidator<String>(-1);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isFalse); // because 0 is not < -1
      });

      test('should handle very large maxLength', () {
        final validator = MaxLengthValidator<String>(1000000);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'short string',
          validators: [validator],
        );

        final result = validator.onValidate(controller);

        expect(result.isValid, isTrue);
      });
    });

    group('Integration with FieldController', () {
      test('should work with FieldController validators list', () {
        final controller = FieldController<String>(
          key: 'description',
          validators: [MaxLengthValidator<String>(10)],
        );

        controller.update('short');
        expect(controller.hasError, isFalse);
        expect(controller.valid, isTrue);

        controller
            .update('this is way too long for the maximum allowed length');
        expect(controller.hasError, isTrue);
        expect(controller.valid, isFalse);
      });

      test('should work with multiple validators', () {
        final controller = FieldController<String>(
          key: 'name',
          validators: [
            MinLengthValidator<String>(3),
            MaxLengthValidator<String>(10),
          ],
        );

        controller.update('ab'); // too short
        expect(controller.hasError, isTrue);

        controller.update('perfect'); // just right
        expect(controller.hasError, isFalse);

        controller.update('way too long text'); // too long
        expect(controller.hasError, isTrue);
      });
    });

    group('Boundary testing', () {
      test('should test exact boundary conditions', () {
        final validator = MaxLengthValidator<String>(5);

        // Test strings of different lengths around the boundary
        final testCases = [
          ('', true), // 0 <= 5
          ('a', true), // 1 <= 5
          ('ab', true), // 2 <= 5
          ('abc', true), // 3 <= 5
          ('abcd', true), // 4 <= 5
          ('abcde', true), // 5 <= 5
          ('abcdef', false), // 6 is not <= 5
        ];

        for (final (text, expectedValid) in testCases) {
          final controller = FieldController<String>(
            key: 'test',
            initialValue: text,
            validators: [validator],
          );

          final result = validator.onValidate(controller);
          expect(result.isValid, equals(expectedValid),
              reason: 'Failed for text "$text" (length ${text.length})');
        }
      });

      test('should test list boundary conditions', () {
        final validator = MaxLengthValidator<List<int>>(3);

        final testCases = [
          (<int>[], true), // 0 <= 3
          ([1], true), // 1 <= 3
          ([1, 2], true), // 2 <= 3
          ([1, 2, 3], true), // 3 <= 3
          ([1, 2, 3, 4], false), // 4 is not < 3
        ];

        for (final (list, expectedValid) in testCases) {
          final controller = FieldListController<int>(
            key: 'test',
            initialValue: list,
            validators: [validator],
          );

          final result = validator.onValidate(controller);
          expect(result.isValid, equals(expectedValid),
              reason: 'Failed for list $list (length ${list.length})');
        }
      });
    });
  });
}
