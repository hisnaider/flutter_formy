import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IsRequired', () {
    group('Null value validation', () {
      test('should invalidate null values', () {
        final validator = IsRequired<String?>();
        final controller = FieldController<String?>(
          key: 'test',
          initialValue: null,
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
        expect(result.key, equals(GenericValidators.isRequired.name));
      });

      test('should invalidate null values for different types', () {
        final stringValidator = IsRequired<String?>();
        final intValidator = IsRequired<int?>();
        final listValidator = IsRequired<List<String?>>();
        final mapValidator = IsRequired<Map<String, dynamic>?>();

        final stringController = FieldController<String?>(
          key: 'string',
          initialValue: null,
          validators: [stringValidator],
        );

        final intController = FieldController<int?>(
          key: 'int',
          initialValue: null,
          validators: [intValidator],
        );

        final listController = FieldListController<String?>(
          key: 'list',
          initialValue: null,
          validators: [listValidator],
        );

        final mapController = FieldController<Map<String, dynamic>?>(
          key: 'map',
          initialValue: null,
          validators: [mapValidator],
        );

        expect(stringValidator.onValidate(stringController).isValid, isFalse);
        expect(intValidator.onValidate(intController).isValid, isFalse);
        expect(listValidator.onValidate(listController).isValid, isFalse);
        expect(mapValidator.onValidate(mapController).isValid, isFalse);
      });
    });

    group('String validation', () {
      test('should validate non-empty strings', () {
        final validator = IsRequired<String>();
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'hello',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.isRequired.name));
      });

      test('should invalidate empty strings', () {
        final validator = IsRequired<String>();
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });

      test('should invalidate strings with only whitespace', () {
        final validator = IsRequired<String>();

        final testCases = [
          ' ', // single space
          '  ', // multiple spaces
          '\t', // tab
          '\n', // newline
          '\r', // carriage return
          ' \t\n\r ', // mixed whitespace
        ];

        for (final whitespace in testCases) {
          final controller = FieldController<String>(
            key: 'test',
            initialValue: whitespace,
            validators: [validator],
          );

          final result = controller.validationResults.first;
          expect(result.isValid, isFalse,
              reason: 'Failed for whitespace: "$whitespace"');
        }
      });

      test('should validate strings with content and whitespace', () {
        final validator = IsRequired<String>();

        final testCases = [
          ' hello ', // content with surrounding spaces
          '\thello\t', // content with tabs
          '\nhello\n', // content with newlines
          ' hello world ', // content with spaces
        ];

        for (final text in testCases) {
          final controller = FieldController<String>(
            key: 'test',
            initialValue: text,
            validators: [validator],
          );

          final result = controller.validationResults.first;
          expect(result.isValid, isTrue, reason: 'Failed for text: "$text"');
        }
      });

      test('should validate single character strings', () {
        final validator = IsRequired<String>();
        final controller = FieldController<String>(
          key: 'test',
          initialValue: 'a',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
      });
    });

    group('Iterable validation', () {
      group('List validation', () {
        test('should validate non-empty lists', () {
          final validator = IsRequired<List<String>>();
          final controller = FieldListController<String>(
            key: 'test',
            initialValue: ['item1', 'item2'],
            validators: [validator],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, isTrue);
          expect(result.key, equals(GenericValidators.isRequired.name));
        });

        test('should invalidate empty lists', () {
          final validator = IsRequired<List<String>>();
          final controller = FieldListController<String>(
            key: 'test',
            initialValue: [],
            validators: [validator],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, isFalse);
        });

        test('should validate single-item lists', () {
          final validator = IsRequired<List<int>>();
          final controller = FieldListController<int>(
            key: 'test',
            initialValue: [42],
            validators: [validator],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, isTrue);
        });
      });

      group('Set validation', () {
        test('should validate non-empty sets', () {
          final validator = IsRequired<Set<String>>();
          final controller = FieldController<Set<String>>(
            key: 'test',
            initialValue: {'item1', 'item2'},
            validators: [validator],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, isTrue);
        });

        test('should invalidate empty sets', () {
          final validator = IsRequired<Set<String>>();
          final controller = FieldController<Set<String>>(
            key: 'test',
            initialValue: <String>{},
            validators: [validator],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, isFalse);
        });
      });

      group('Map validation', () {
        test('should validate non-empty maps', () {
          final validator = IsRequired<Map<String, dynamic>>();
          final controller = FieldController<Map<String, dynamic>>(
            key: 'test',
            initialValue: {'key': 'value'},
            validators: [validator],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, isTrue);
        });

        test('should invalidate empty maps', () {
          final validator = IsRequired<Map<String, dynamic>>();
          final controller = FieldController<Map<String, dynamic>>(
            key: 'test',
            initialValue: {},
            validators: [validator],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, isFalse);
        });
      });

      group('Custom Iterable validation', () {
        test('should validate custom iterables', () {
          final validator = IsRequired<Iterable<String>>();
          final controller = FieldController<Iterable<String>>(
            key: 'test',
            initialValue: ['item1', 'item2'].where((item) => item.isNotEmpty),
            validators: [validator],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, isTrue);
        });

        test('should invalidate empty custom iterables', () {
          final validator = IsRequired<Iterable<String>>();
          final controller = FieldController<Iterable<String>>(
            key: 'test',
            initialValue: <String>[].where((item) => item.isNotEmpty),
            validators: [validator],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, isFalse);
        });
      });
    });

    group('Boolean validation', () {
      test('should validate true boolean values', () {
        final validator = IsRequired<bool>();
        final controller = FieldController<bool>(
          key: 'test',
          initialValue: true,
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
        expect(result.key, equals(GenericValidators.isRequired.name));
      });

      test('should invalidate false boolean values', () {
        final validator = IsRequired<bool>();
        final controller = FieldController<bool>(
          key: 'test',
          initialValue: false,
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
      });

      test('should handle nullable boolean values', () {
        final validator = IsRequired<bool?>();

        // Test null
        final nullController = FieldController<bool?>(
          key: 'test',
          initialValue: null,
          validators: [validator],
        );
        expect(validator.onValidate(nullController).isValid, isFalse);

        // Test true
        final trueController = FieldController<bool?>(
          key: 'test',
          initialValue: true,
          validators: [validator],
        );
        expect(validator.onValidate(trueController).isValid, isTrue);

        // Test false
        final falseController = FieldController<bool?>(
          key: 'test',
          initialValue: false,
          validators: [validator],
        );
        expect(validator.onValidate(falseController).isValid, isFalse);
      });
    });

    group('Other type validation', () {
      test('should validate non-null numeric values', () {
        final intValidator = IsRequired<int>();
        final doubleValidator = IsRequired<double>();

        final intController = FieldController<int>(
          key: 'test',
          initialValue: 42,
          validators: [intValidator],
        );

        final doubleController = FieldController<double>(
          key: 'test',
          initialValue: 3.14,
          validators: [doubleValidator],
        );

        expect(intValidator.onValidate(intController).isValid, isTrue);
        expect(doubleValidator.onValidate(doubleController).isValid, isTrue);
      });

      test('should validate zero values', () {
        final intValidator = IsRequired<int>();
        final doubleValidator = IsRequired<double>();

        final intController = FieldController<int>(
          key: 'test',
          initialValue: 0,
          validators: [intValidator],
        );

        final doubleController = FieldController<double>(
          key: 'test',
          initialValue: 0.0,
          validators: [doubleValidator],
        );

        expect(intValidator.onValidate(intController).isValid, isTrue);
        expect(doubleValidator.onValidate(doubleController).isValid, isTrue);
      });

      test('should validate negative values', () {
        final intValidator = IsRequired<int>();
        final doubleValidator = IsRequired<double>();

        final intController = FieldController<int>(
          key: 'test',
          initialValue: -5,
          validators: [intValidator],
        );

        final doubleController = FieldController<double>(
          key: 'test',
          initialValue: -2.5,
          validators: [doubleValidator],
        );

        expect(intValidator.onValidate(intController).isValid, isTrue);
        expect(doubleValidator.onValidate(doubleController).isValid, isTrue);
      });

      test('should validate DateTime values', () {
        final validator = IsRequired<DateTime>();
        final controller = FieldController<DateTime>(
          key: 'test',
          initialValue: DateTime.now(),
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
      });

      test('should validate custom object values', () {
        final validator = IsRequired<Object>();
        final controller = FieldController<Object>(
          key: 'test',
          initialValue: Object(),
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
      });
    });

    group('Custom message', () {
      test('should use custom message when provided', () {
        const customMessage = 'This field is required';
        final validator = IsRequired<String>(message: customMessage);
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
        expect(result.message, equals(customMessage));
      });

      test('should use null message when not provided', () {
        final validator = IsRequired<String>();
        final controller = FieldController<String>(
          key: 'test',
          initialValue: '',
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isFalse);
        expect(result.message, GenericValidators.isRequired.name);
      });
    });

    group('Integration with FieldController', () {
      test('should work with FieldController validators list', () {
        final controller = FieldController<String>(
          key: 'name',
          validators: [IsRequired<String>()],
        );

        // Test empty value
        controller.update('');
        expect(controller.hasError, isTrue);
        expect(controller.valid, isFalse);

        // Test valid value
        controller.update('John Doe');
        expect(controller.hasError, isFalse);
        expect(controller.valid, isTrue);

        // Test whitespace only
        controller.update('   ');
        expect(controller.hasError, isTrue);
        expect(controller.valid, isFalse);
      });

      test('should work with multiple validators', () {
        final controller = FieldController<String>(
          key: 'email',
          validators: [
            IsRequired<String>(),
            MinLengthValidator<String>(5),
          ],
        );

        // Test empty (fails required)
        controller.update('');
        expect(controller.hasError, isTrue);

        // Test too short (passes required, fails min length)
        controller.update('hi');
        expect(controller.hasError, isTrue);

        // Test valid (passes all)
        controller.update('user@example.com');
        expect(controller.hasError, isFalse);
      });
    });

    group('Edge cases', () {
      test('should handle very long strings', () {
        final validator = IsRequired<String>();
        final longString = 'a' * 10000;
        final controller = FieldController<String>(
          key: 'test',
          initialValue: longString,
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
      });

      test('should handle strings with special characters', () {
        final validator = IsRequired<String>();

        final testCases = [
          'hello@world.com',
          'user123!@#\$%',
          'émojis 😀🎉',
          'unicode: ñáéíóú',
          'line\nbreak',
          'tab\there',
        ];

        for (final text in testCases) {
          final controller = FieldController<String>(
            key: 'test',
            initialValue: text,
            validators: [validator],
          );

          final result = controller.validationResults.first;
          expect(result.isValid, isTrue, reason: 'Failed for text: "$text"');
        }
      });

      test('should handle large collections', () {
        final validator = IsRequired<List<int>>();
        final largeList = List.generate(10000, (index) => index);
        final controller = FieldListController<int>(
          key: 'test',
          initialValue: largeList,
          validators: [validator],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, isTrue);
      });
    });

    group('Type-specific behavior', () {
      test('should handle different string edge cases', () {
        final validator = IsRequired<String>();

        final testCases = [
          // Valid cases
          ('0', true), // string zero
          ('false', true), // string false
          ('null', true), // string null
          (' a ', true), // content with spaces

          // Invalid cases
          ('', false), // empty
          (' ', false), // space only
          ('\t', false), // tab only
          ('\n', false), // newline only
          ('\r\n', false), // carriage return + newline
        ];

        for (final (text, expectedValid) in testCases) {
          final controller = FieldController<String>(
            key: 'test',
            initialValue: text,
            validators: [validator],
          );

          final result = controller.validationResults.first;
          expect(result.isValid, equals(expectedValid),
              reason: 'Failed for text: "$text"');
        }
      });

      test('should handle different iterable types consistently', () {
        final listValidator = IsRequired<List<String>>();
        final setValidator = IsRequired<Set<String>>();
        final mapValidator = IsRequired<Map<String, String>>();

        // Empty collections
        final emptyListController = FieldListController<String>(
          key: 'test',
          initialValue: [],
          validators: [listValidator],
        );

        final emptySetController = FieldController<Set<String>>(
          key: 'test',
          initialValue: <String>{},
          validators: [setValidator],
        );

        final emptyMapController = FieldController<Map<String, String>>(
          key: 'test',
          initialValue: {},
          validators: [mapValidator],
        );

        expect(listValidator.onValidate(emptyListController).isValid, isFalse);
        expect(setValidator.onValidate(emptySetController).isValid, isFalse);
        expect(mapValidator.onValidate(emptyMapController).isValid, isFalse);

        // Non-empty collections
        final nonEmptyListController = FieldListController<String>(
          key: 'test',
          initialValue: ['item'],
          validators: [listValidator],
        );

        final nonEmptySetController = FieldController<Set<String>>(
          key: 'test',
          initialValue: {'item'},
          validators: [setValidator],
        );

        final nonEmptyMapController = FieldController<Map<String, String>>(
          key: 'test',
          initialValue: {'key': 'value'},
          validators: [mapValidator],
        );

        expect(
            listValidator.onValidate(nonEmptyListController).isValid, isTrue);
        expect(setValidator.onValidate(nonEmptySetController).isValid, isTrue);
        expect(mapValidator.onValidate(nonEmptyMapController).isValid, isTrue);
      });
    });
  });
}
