import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MinAgeValidator', () {
    test('should return valid when controller value is null', () {
      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: null,
        validators: [MinAgeValidator(18)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'minAge');
      expect(result.message, 'minAge');
    });

    test('should return valid when age is exactly the minimum age', () {
      final today = DateTime.now();
      final exactMinAge = DateTime(today.year - 18, today.month, today.day);

      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: exactMinAge,
        validators: [MinAgeValidator(18)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'minAge');
    });

    test('should return valid when age is greater than minimum age', () {
      final today = DateTime.now();
      final olderThanMinAge = DateTime(today.year - 25, today.month, today.day);

      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: olderThanMinAge,
        validators: [MinAgeValidator(18)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'minAge');
    });

    test('should return invalid when age is less than minimum age', () {
      final today = DateTime.now();
      final youngerThanMinAge =
          DateTime(today.year - 16, today.month, today.day);

      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: youngerThanMinAge,
        validators: [MinAgeValidator(18)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'minAge');
    });

    test('should return invalid when birthday has not occurred this year', () {
      final today = DateTime.now();
      // Birthday in the future this year (hasn't happened yet)
      final birthdayNotYetOccurred = DateTime(
        today.year - 18,
        today.month + 1 > 12 ? 1 : today.month + 1,
        today.day,
      );

      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: birthdayNotYetOccurred,
        validators: [MinAgeValidator(18)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'minAge');
    });

    test(
        'should return invalid when birthday is today but year makes them younger',
        () {
      final today = DateTime.now();
      final birthdayToday = DateTime(today.year - 17, today.month, today.day);

      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: birthdayToday,
        validators: [MinAgeValidator(18)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'minAge');
    });

    test('should use custom message when provided', () {
      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: DateTime(2010, 1, 1),
        validators: [
          MinAgeValidator(18, message: 'Must be at least 18 years old')
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'minAge');
      expect(result.message, 'Must be at least 18 years old');
    });

    test('should work with different minimum ages', () {
      final today = DateTime.now();
      final birthdate = DateTime(today.year - 16, today.month, today.day);

      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: birthdate,
        validators: [MinAgeValidator(16)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'minAge');
    });

    test('should handle edge case when birthday is tomorrow', () {
      final today = DateTime.now();
      final tomorrow = today.add(const Duration(days: 1));
      final birthdayTomorrow = DateTime(
        today.year - 18,
        tomorrow.month,
        tomorrow.day,
      );

      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: birthdayTomorrow,
        validators: [MinAgeValidator(18)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'minAge');
    });

    test('should handle leap year dates correctly', () {
      final today = DateTime.now();
      final leapYearBirthdate = DateTime(today.year - 20, 2, 29);

      final controller = FieldController<DateTime>(
        key: 'birthdate',
        initialValue: leapYearBirthdate,
        validators: [MinAgeValidator(18)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'minAge');
    });
  });
}
