import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MaxAgeValidator', () {
    // Note: These tests use fixed dates to ensure consistent results
    // In real scenarios, DateTime.now() would be used

    test('should validate age equal to maximum age', () {
      // Person born exactly 25 years ago
      final twentyFiveYearsAgo = DateTime(
          DateTime.now().year - 25, DateTime.now().month, DateTime.now().day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: twentyFiveYearsAgo,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'maxAge');
      expect(result.message, 'maxAge');
    });

    test('should validate age less than maximum age', () {
      // Person born 20 years ago
      final twentyYearsAgo = DateTime(
          DateTime.now().year - 20, DateTime.now().month, DateTime.now().day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: twentyYearsAgo,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should invalidate age greater than maximum age', () {
      // Person born 30 years ago
      final thirtyYearsAgo = DateTime(
          DateTime.now().year - 30, DateTime.now().month, DateTime.now().day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: thirtyYearsAgo,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'maxAge');
    });

    test('should handle birthday not yet reached this year', () {
      final today = DateTime.now();
      // Person born 25 years ago but birthday is tomorrow
      final birthdayTomorrow =
          DateTime(today.year - 25, today.month, today.day + 1);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: birthdayTomorrow,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      // Should be 24 years old (birthday not reached yet)
      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should handle birthday already passed this year', () {
      final today = DateTime.now();
      // Person born 25 years ago and birthday was yesterday
      final birthdayYesterday =
          DateTime(today.year - 25, today.month, today.day - 1);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: birthdayYesterday,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      // Should be 25 years old (birthday already passed)
      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should handle month boundary - birthday not reached', () {
      final today = DateTime.now();
      // Person born 25 years ago but birthday is next month
      final birthdayNextMonth =
          DateTime(today.year - 25, today.month + 1, today.day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: birthdayNextMonth,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      // Should be 24 years old (birthday not reached yet)
      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should handle month boundary - birthday already passed', () {
      final today = DateTime.now();
      // Person born 25 years ago and birthday was last month
      final birthdayLastMonth =
          DateTime(today.year - 25, today.month - 1, today.day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: birthdayLastMonth,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      // Should be 25 years old (birthday already passed)
      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should accept null values as valid', () {
      final controller = FieldController(
        key: 'birthdate_field',
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should use custom message when provided', () {
      const customMessage = 'Age must not exceed 25 years';
      final thirtyYearsAgo = DateTime(
          DateTime.now().year - 30, DateTime.now().month, DateTime.now().day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: thirtyYearsAgo,
        validators: [MaxAgeValidator(25, message: customMessage)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'maxAge');
      expect(result.message, customMessage);
    });

    test('should use key as message when message is null', () {
      final thirtyYearsAgo = DateTime(
          DateTime.now().year - 30, DateTime.now().month, DateTime.now().day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: thirtyYearsAgo,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'maxAge');
      expect(result.message, 'maxAge');
    });

    test('should handle zero age maximum', () {
      final today = DateTime.now();
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: today,
        validators: [MaxAgeValidator(0)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should invalidate with zero age maximum for older dates', () {
      final oneYearAgo = DateTime(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: oneYearAgo,
        validators: [MaxAgeValidator(0)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'maxAge');
    });

    test('should handle leap year birthdays', () {
      // Test with leap year birthday (Feb 29)
      final leapYearBirth = DateTime(2000, 2, 29); // Born on leap day
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: leapYearBirth,
        validators: [MaxAgeValidator(30)],
      );

      final result = controller.validationResults.first;

      // Should calculate age correctly even with leap year
      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should handle future dates as negative age', () {
      final futureDate = DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: futureDate,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      // Future date results in negative age, which should be valid (less than max)
      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should handle same day different month calculation', () {
      final today = DateTime.now();
      // Same day and month but different year
      final sameMonthDay = DateTime(today.year - 25, today.month, today.day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: sameMonthDay,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      // Should be exactly 25 years old
      expect(result.isValid, true);
      expect(result.key, 'maxAge');
    });

    test('should handle year boundary correctly', () {
      // Person born on December 31st, checking in January
      final today = DateTime.now();
      final lastYearBirth = DateTime(today.year - 26, 12, 31);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: lastYearBirth,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      // Should be at least 25 years old, possibly 26 depending on current date
      final expectedAge = today.year - lastYearBirth.year;
      final adjustedAge = (today.month < lastYearBirth.month ||
              (today.month == lastYearBirth.month &&
                  today.day < lastYearBirth.day))
          ? expectedAge - 1
          : expectedAge;

      expect(result.isValid, adjustedAge <= 25);
      expect(result.key, 'maxAge');
    });

    test('should handle very old ages', () {
      final centuryAgo = DateTime(
          DateTime.now().year - 100, DateTime.now().month, DateTime.now().day);
      final controller = FieldController(
        key: 'birthdate_field',
        initialValue: centuryAgo,
        validators: [MaxAgeValidator(25)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'maxAge');
    });
  });
}
