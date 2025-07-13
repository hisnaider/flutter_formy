import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_cross_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MustMatchValidator', () {
    test('should return valid when both fields have matching values', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(
              key: 'password', initialValue: 'password123'),
          FieldConfig<String>(
            key: 'confirmPassword',
            initialValue: 'password123',
            validators: [MustMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('confirmPassword').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustMatch.name);
      expect(result.message, GenericValidators.mustMatch.name);
    });

    test('should return invalid when fields have different values', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(
              key: 'password', initialValue: 'password123'),
          FieldConfig<String>(
            key: 'confirmPassword',
            initialValue: 'differentPassword',
            validators: [MustMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('confirmPassword').validationResults.first;

      expect(result.isValid, false);
      expect(result.key, GenericValidators.mustMatch.name);
      expect(result.message, GenericValidators.mustMatch.name);
    });

    test('should return valid when current field value is null', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(
              key: 'password', initialValue: 'password123'),
          FieldConfig<String>(
            key: 'confirmPassword',
            initialValue: null,
            validators: [MustMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('confirmPassword').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustMatch.name);
      expect(result.message, GenericValidators.mustMatch.name);
    });

    test(
        'should return invalid when current field has value but other field is null',
        () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'password', initialValue: null),
          FieldConfig<String>(
            key: 'confirmPassword',
            initialValue: 'password123',
            validators: [MustMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('confirmPassword').validationResults.first;

      expect(result.isValid, false);
      expect(result.key, GenericValidators.mustMatch.name);
      expect(result.message, GenericValidators.mustMatch.name);
    });

    test('should return valid when both fields are null', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(key: 'password', initialValue: null),
          FieldConfig<String>(
            key: 'confirmPassword',
            initialValue: null,
            validators: [MustMatchValidator<String>(otherField: 'password')],
          ),
        ],
      );

      final result = group.field('confirmPassword').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustMatch.name);
      expect(result.message, GenericValidators.mustMatch.name);
    });

    test('should use custom message when provided', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<String>(
              key: 'password', initialValue: 'password123'),
          FieldConfig<String>(
            key: 'confirmPassword',
            initialValue: 'differentPassword',
            validators: [
              MustMatchValidator<String>(
                otherField: 'password',
                message: 'Passwords must match',
              )
            ],
          ),
        ],
      );

      final result = group.field('confirmPassword').validationResults.first;

      expect(result.isValid, false);
      expect(result.key, GenericValidators.mustMatch.name);
      expect(result.message, 'Passwords must match');
    });

    test('should work with integer values', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<int>(key: 'value1', initialValue: 42),
          FieldConfig<int>(
            key: 'value2',
            initialValue: 42,
            validators: [MustMatchValidator<int>(otherField: 'value1')],
          ),
        ],
      );

      final result = group.field('value2').validationResults.first;

      expect(result.isValid, true);
      expect(result.key, GenericValidators.mustMatch.name);
      expect(result.message, GenericValidators.mustMatch.name);
    });

    test('should return invalid for different integer values', () {
      final group = GroupController(
        key: 'testGroup',
        fields: [
          const FieldConfig<int>(key: 'value1', initialValue: 42),
          FieldConfig<int>(
            key: 'value2',
            initialValue: 24,
            validators: [MustMatchValidator<int>(otherField: 'value1')],
          ),
        ],
      );

      final result = group.field('value2').validationResults.first;

      expect(result.isValid, false);
      expect(result.key, GenericValidators.mustMatch.name);
      expect(result.message, GenericValidators.mustMatch.name);
    });
  });
}
