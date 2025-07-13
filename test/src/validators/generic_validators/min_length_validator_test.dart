import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_generic_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MinLengthValidator', () {
    group('String validation', () {
      test('should validate string with length greater than minLength', () {
        final validator = MinLengthValidator<String>(5);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'hello world',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.minLength.name));
      });

      test('should validate string with length equal to minLength', () {
        final validator = MinLengthValidator<String>(5);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'hello', // exactly 5 characters
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.minLength.name));
      });

      test('should invalidate string with length less than minLength', () {
        final validator = MinLengthValidator<String>(5);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'hi', // only 2 characters
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
        expect(result.key, equals(GenericValidators.minLength.name));
      });

      test('should handle empty string', () {
        final validator = MinLengthValidator<String>(1);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });

      test('should validate string with minLength 0', () {
        final validator = MinLengthValidator<String>(0);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'a',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
      });
    });

    group('List validation', () {
      test('should validate list with length greater than minLength', () {
        final validator = MinLengthValidator<List<String>>(2);
        final controller = FieldListController<String>(
          key: 'test',
          initialValue: ['item1', 'item2', 'item3'],
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.minLength.name));
      });

      test('should validate list with length equal to minLength', () {
        final validator = MinLengthValidator<List<String>>(3);
        final controller = FieldListController<String>(
          key: 'test',
          initialValue: ['item1', 'item2', 'item3'], // exactly 3 items
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
      });

      test('should invalidate list with length less than minLength', () {
        final validator = MinLengthValidator<List<int>>(5);
        final controller = FieldListController<int>(
          key: 'test',
          initialValue: [1, 2], // only 2 items
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });

      test('should handle empty list', () {
        final validator = MinLengthValidator<List<dynamic>>(1);
        final controller = FieldListController<dynamic>(
          key: 'test',
          initialValue: [],
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });
    });

    group('Map validation', () {
      test('should validate map with length greater than minLength', () {
        final validator = MinLengthValidator<Map<String, dynamic>>(2);
        final controller = FieldController<Map<String, dynamic>>(
          key: 'test',
          initialValue: {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'},
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.minLength.name));
      });

      test('should validate map with length equal to minLength', () {
        final validator = MinLengthValidator<Map<String, int>>(2);
        final controller = FieldController<Map<String, int>>(
          key: 'test',
          initialValue: {'a': 1, 'b': 2}, // exactly 2 entries
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
      });

      test('should invalidate map with length less than minLength', () {
        final validator = MinLengthValidator<Map<String, String>>(3);
        final controller = FieldController<Map<String, String>>(
          key: 'test',
          initialValue: {'only': 'one'}, // only 1 entry
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });

      test('should handle empty map', () {
        final validator = MinLengthValidator<Map<dynamic, dynamic>>(1);
        final controller = FieldController<Map<dynamic, dynamic>>(
          key: 'test',
          initialValue: {},
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });
    });

    group('Set validation', () {
      test('should validate set with length greater than minLength', () {
        final validator = MinLengthValidator<Set<String>>(2);
        final controller = FieldController<Set<String>>(
          key: 'test',
          initialValue: {'item1', 'item2', 'item3'},
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.minLength.name));
      });

      test('should validate set with length equal to minLength', () {
        final validator = MinLengthValidator<Set<int>>(3);
        final controller = FieldController<Set<int>>(
          key: 'test',
          initialValue: {1, 2, 3}, // exactly 3 items
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
      });

      test('should invalidate set with length less than minLength', () {
        final validator = MinLengthValidator<Set<String>>(4);
        final controller = FieldController<Set<String>>(
          key: 'test',
          initialValue: {'a', 'b'}, // only 2 items
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });

      test('should handle empty set', () {
        final validator = MinLengthValidator<Set<dynamic>>(1);
        final controller = FieldController<Set<dynamic>>(
          key: 'test',
          initialValue: <dynamic>{},
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });
    });

    group('Null value validation', () {
      test('should validate null value as valid', () {
        final validator = MinLengthValidator<String?>(5);
        final controller = FieldController<String?>(
          key: 'test',
          initialValue: null,
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.minLength.name));
      });

      test('should handle null value with different types', () {
        final stringValidator = MinLengthValidator<String?>(1);
        final listValidator = MinLengthValidator<List<String>>(1);
        final mapValidator = MinLengthValidator<Map<String, dynamic>?>(1);
        final setValidator = MinLengthValidator<Set<String>?>(1);

        final stringController = FieldController<String?>(
          key: 'string',
          initialValue: null,
          validators: [stringValidator],
        );

        final listController = FieldListController<String>(
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
        final validator = MinLengthValidator<int>(5);
        final controller = FieldController<int>(
          key: 'test',
          initialValue: 123,
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
        expect(result.key, equals(GenericValidators.minLength.name));
      });

      test('should invalidate object types', () {
        final validator = MinLengthValidator<DateTime>(1);
        final controller = FieldController<DateTime>(
          key: 'test',
          initialValue: DateTime.now(),
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });

      test('should invalidate boolean type', () {
        final validator = MinLengthValidator<bool>(1);
        final controller = FieldController<bool>(
          key: 'test',
          initialValue: true,
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });
    });

    group('Custom message', () {
      test('should use custom message when provided', () {
        const customMessage = 'Minimum length must be greater than 5';
        final validator = MinLengthValidator<String>(5, message: customMessage);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'hi',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
        expect(result.message, equals(customMessage));
      });

      test('should use null message when not provided', () {
        final validator = MinLengthValidator<String>(5);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'hi',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
        expect(result.message, GenericValidators.minLength.name);
      });
    });

    group('Edge cases', () {
      test('should handle minLength 0', () {
        final validator = MinLengthValidator<String>(0);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue); // because 0 >= 0
      });

      test('should handle negative minLength', () {
        final validator = MinLengthValidator<String>(-1);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue); // because 0 > -1
      });

      test('should handle very large minLength', () {
        final validator = MinLengthValidator<String>(1000000);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'short string',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });
    });

    group('Integration with FieldController', () {
      test('should work with FieldController validators list', () {
        final controller = FieldController<String>(
          key: 'name',
          validators: [MinLengthValidator<String>(6)],
        );

        controller.update('short');
        expect(controller.hasError, isTrue);
        expect(controller.valid, isFalse);

        controller.update('long enough');
        expect(controller.hasError, isFalse);
        expect(controller.valid, isTrue);
      });

      test('should work with multiple validators', () {
        final controller = FieldController<String>(
          key: 'name',
          validators: [
            MinLengthValidator<String>(6),
            // Assumindo que existe MaxLengthValidator
            MaxLengthValidator<String>(20),
          ],
        );

        controller.update('short');
        expect(controller.hasError, isTrue);
        controller.update('perfect length');
        expect(controller.hasError, isFalse);
      });
    });
  });
}
