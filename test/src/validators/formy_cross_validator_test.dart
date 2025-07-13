import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_base_validators.dart';
import 'package:flutter_test/flutter_test.dart';

class TestFormyCrossValidator<T> extends FormyCrossValidator<T> {
  TestFormyCrossValidator({
    required super.message,
    required super.otherField,
    required this.shouldBeValid,
  });

  final bool shouldBeValid;

  @override
  ValidationResult onValidate(FieldController<T> controller) {
    return ValidationResult(
      key: 'test_cross_validator',
      message: message,
      isValid: shouldBeValid,
    );
  }
}

// Another concrete implementation to test cross-field validation
class CompareFieldsValidator<T> extends FormyCrossValidator<T> {
  CompareFieldsValidator({
    required super.message,
    required super.otherField,
    required this.shouldMatch,
  });

  final bool shouldMatch;

  @override
  ValidationResult onValidate(FieldController<T> controller) {
    final isMatching = controller.value == otherController.value;
    return ValidationResult(
      key: 'compare_fields',
      message: message,
      isValid: shouldMatch ? isMatching : !isMatching,
    );
  }
}

void main() {
  group('FormyCrossValidator', () {
    test('should store otherField in constructor', () {
      final validator = TestFormyCrossValidator<String>(
        message: 'Test message',
        otherField: 'otherFieldKey',
        shouldBeValid: true,
      );

      expect(validator.otherField, 'otherFieldKey');
    });

    test('should store message in constructor', () {
      final validator = TestFormyCrossValidator<String>(
        message: 'Custom error message',
        otherField: 'otherFieldKey',
        shouldBeValid: true,
      );

      expect(validator.message, 'Custom error message');
    });

    test('should allow null message', () {
      final validator = TestFormyCrossValidator<String>(
        message: null,
        otherField: 'otherFieldKey',
        shouldBeValid: true,
      );

      expect(validator.message, null);
    });

    test('should successfully validate when other field exists', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'field1', initialValue: 'value1'),
          FieldConfig<String>(
            key: 'field2',
            initialValue: 'value2',
            validators: [
              TestFormyCrossValidator<String>(
                message: 'Cross validation test',
                otherField: 'field1',
                shouldBeValid: true,
              )
            ],
          ),
        ],
      );

      final result = group.field('field2').validationResults.first;

      expect(result.key, 'test_cross_validator');
      expect(result.message, 'Cross validation test');
      expect(result.isValid, true);
    });

    test('should throw exception when field does not belong to a group', () {
      final validator = TestFormyCrossValidator<String>(
        message: 'Test message',
        otherField: 'otherField',
        shouldBeValid: true,
      );
      try {
        FieldController<String>(
          key: 'field1',
          initialValue: 'value1',
          validators: [validator],
        );
        fail('Expected exception to be thrown');
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.toString(),
            contains('Validator requires the field to belong to a group'));
      }
    });

    test('should cache other controller after first call', () {
      final validator = TestFormyCrossValidator<String>(
        message: 'Cache test',
        otherField: 'field1',
        shouldBeValid: true,
      );

      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'field1', initialValue: 'value1'),
          FieldConfig<String>(
            key: 'field2',
            initialValue: 'value2',
            validators: [validator],
          ),
        ],
      );

      // First call should cache the other controller
      final result1 = group.field('field2').validationResults.first;

      // Second call should use cached controller
      final result2 = group.field('field2').validationResults.first;

      expect(result1.isValid, true);
      expect(result2.isValid, true);
      expect(validator.otherController.key, 'field1');
    });

    test('should provide access to other controller value', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(
              key: 'field1', initialValue: 'expected_value'),
          FieldConfig<String>(
            key: 'field2',
            initialValue: 'expected_value',
            validators: [
              CompareFieldsValidator<String>(
                message: 'Fields must match',
                otherField: 'field1',
                shouldMatch: true,
              )
            ],
          ),
        ],
      );

      final result = group.field('field2').validationResults.first;

      expect(result.key, 'compare_fields');
      expect(result.message, 'Fields must match');
      expect(result.isValid, true);
    });

    test('should validate correctly when values do not match', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'field1', initialValue: 'value1'),
          FieldConfig<String>(
            key: 'field2',
            initialValue: 'value2',
            validators: [
              CompareFieldsValidator<String>(
                message: 'Fields must match',
                otherField: 'field1',
                shouldMatch: true,
              )
            ],
          ),
        ],
      );

      final result = group.field('field2').validationResults.first;

      expect(result.key, 'compare_fields');
      expect(result.message, 'Fields must match');
      expect(result.isValid, false);
    });

    test('should work with different generic types - int', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<int>(key: 'num1', initialValue: 42),
          FieldConfig<int>(
            key: 'num2',
            initialValue: 42,
            validators: [
              CompareFieldsValidator<int>(
                message: 'Numbers must match',
                otherField: 'num1',
                shouldMatch: true,
              )
            ],
          ),
        ],
      );

      final result = group.field('num2').validationResults.first;

      expect(result.key, 'compare_fields');
      expect(result.message, 'Numbers must match');
      expect(result.isValid, true);
    });

    test('should handle null values in both fields', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'field1', initialValue: null),
          FieldConfig<String>(
            key: 'field2',
            initialValue: null,
            validators: [
              CompareFieldsValidator<String>(
                message: 'Fields must match',
                otherField: 'field1',
                shouldMatch: true,
              )
            ],
          ),
        ],
      );

      final result = group.field('field2').validationResults.first;

      expect(result.key, 'compare_fields');
      expect(result.message, 'Fields must match');
      expect(result.isValid, true);
    });

    test('should handle one null and one non-null value', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'field1', initialValue: null),
          FieldConfig<String>(
            key: 'field2',
            initialValue: 'value',
            validators: [
              CompareFieldsValidator<String>(
                message: 'Fields must match',
                otherField: 'field1',
                shouldMatch: true,
              )
            ],
          ),
        ],
      );

      final result = group.field('field2').validationResults.first;

      expect(result.key, 'compare_fields');
      expect(result.message, 'Fields must match');
      expect(result.isValid, false);
    });

    test('should work with "must not match" validation', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'field1', initialValue: 'value1'),
          FieldConfig<String>(
            key: 'field2',
            initialValue: 'value2',
            validators: [
              CompareFieldsValidator<String>(
                message: 'Fields must not match',
                otherField: 'field1',
                shouldMatch: false,
              )
            ],
          ),
        ],
      );

      final result = group.field('field2').validationResults.first;

      expect(result.key, 'compare_fields');
      expect(result.message, 'Fields must not match');
      expect(result.isValid, true);
    });

    test('should work with bool generic type', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<bool>(key: 'bool1', initialValue: true),
          FieldConfig<bool>(
            key: 'bool2',
            initialValue: true,
            validators: [
              CompareFieldsValidator<bool>(
                message: 'Booleans must match',
                otherField: 'bool1',
                shouldMatch: true,
              )
            ],
          ),
        ],
      );

      final result = group.field('bool2').validationResults.first;

      expect(result.key, 'compare_fields');
      expect(result.message, 'Booleans must match');
      expect(result.isValid, true);
    });

    test('should work with multiple cross validators on same field', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'field1', initialValue: 'value1'),
          const FieldConfig<String>(key: 'field3', initialValue: 'value3'),
          FieldConfig<String>(
            key: 'field2',
            initialValue: 'value2',
            validators: [
              CompareFieldsValidator<String>(
                message: 'Must not match field1',
                otherField: 'field1',
                shouldMatch: false,
              ),
              CompareFieldsValidator<String>(
                message: 'Must not match field3',
                otherField: 'field3',
                shouldMatch: false,
              )
            ],
          ),
        ],
      );

      final results = group.field('field2').validationResults;

      expect(results.length, 2);
      expect(results[0].isValid, true);
      expect(results[1].isValid, true);
    });
  });
}
