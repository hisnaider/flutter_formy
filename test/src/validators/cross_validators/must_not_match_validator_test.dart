import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MustNotMatchValidator', () {
    test('should return valid when fields have different values', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(
              key: 'password', initialValue: 'password123'),
          FieldConfig<String>(
            key: 'username',
            initialValue: 'myusername',
            validators: [MustNotMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('username').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, GenericValidators.mustNotMatch.name);
    });

    test('should return invalid when fields have matching values', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(
              key: 'password', initialValue: 'password123'),
          FieldConfig<String>(
            key: 'username',
            initialValue: 'password123',
            validators: [MustNotMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('username').validationResults.first;

      expect(result.isValid, false);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, GenericValidators.mustNotMatch.name);
    });

    test('should return valid when current field value is null', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(
              key: 'password', initialValue: 'password123'),
          FieldConfig<String>(
            key: 'username',
            initialValue: null,
            validators: [MustNotMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('username').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, GenericValidators.mustNotMatch.name);
    });

    test(
        'should return valid when current field has value but other field is null',
        () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'password', initialValue: null),
          FieldConfig<String>(
            key: 'username',
            initialValue: 'myusername',
            validators: [MustNotMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('username').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, GenericValidators.mustNotMatch.name);
    });

    test('should return valid when both fields are null', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'password', initialValue: null),
          FieldConfig<String>(
            key: 'username',
            initialValue: null,
            validators: [MustNotMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('username').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, GenericValidators.mustNotMatch.name);
    });

    test('should use custom message when provided', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(
              key: 'password', initialValue: 'password123'),
          FieldConfig<String>(
            key: 'username',
            initialValue: 'password123',
            validators: [
              MustNotMatchValidator<String>(
                otherField: 'password',
                message: 'Username must not match password',
              )
            ],
          ),
        ],
      );

      final result = group.field('username').validationResults.first;

      expect(result.isValid, false);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, 'Username must not match password');
    });

    test('should work with integer values - valid different values', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<int>(key: 'value1', initialValue: 42),
          FieldConfig<int>(
            key: 'value2',
            initialValue: 24,
            validators: [MustNotMatchValidator<int>(otherField: 'value1')],
          ),
        ],
      );

      final result = group.field('value2').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, GenericValidators.mustNotMatch.name);
    });

    test('should return invalid for matching integer values', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<int>(key: 'value1', initialValue: 42),
          FieldConfig<int>(
            key: 'value2',
            initialValue: 42,
            validators: [MustNotMatchValidator<int>(otherField: 'value1')],
          ),
        ],
      );

      final result = group.field('value2').validationResults.first;

      expect(result.isValid, false);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, GenericValidators.mustNotMatch.name);
    });

    test('should handle empty strings as different from null', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'field1', initialValue: null),
          FieldConfig<String>(
            key: 'field2',
            initialValue: '',
            validators: [MustNotMatchValidator<String>(otherField: 'field1')],
          ),
        ],
      );

      final result = group.field('field2').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, GenericValidators.mustNotMatch.name);
    });

    test('should return invalid when both fields have same empty string', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'field1', initialValue: ''),
          FieldConfig<String>(
            key: 'field2',
            initialValue: '',
            validators: [MustNotMatchValidator<String>(otherField: 'field1')],
          ),
        ],
      );

      final result = group.field('field2').validationResults.first;

      expect(result.isValid, false);
      expect(result.key, GenericValidators.mustNotMatch.name);
      expect(result.message, GenericValidators.mustNotMatch.name);
    });
  });
}
