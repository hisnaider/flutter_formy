import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BetweenDatesValidator', () {
    final minDate = DateTime(2024, 1, 10);
    final maxDate = DateTime(2024, 1, 20);

    test('should validate date within range', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15),
        validators: [BetweenDatesValidator(minDate: minDate, maxDate: maxDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
      expect(result.message, 'betweenDates');
    });

    test('should validate date at minimum boundary (inclusive)', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 10),
        validators: [BetweenDatesValidator(minDate: minDate, maxDate: maxDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should validate date at maximum boundary (inclusive)', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 20),
        validators: [BetweenDatesValidator(minDate: minDate, maxDate: maxDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should invalidate date before minimum', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 9),
        validators: [BetweenDatesValidator(minDate: minDate, maxDate: maxDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'betweenDates');
    });

    test('should invalidate date after maximum', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 21),
        validators: [BetweenDatesValidator(minDate: minDate, maxDate: maxDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'betweenDates');
    });

    test('should invalidate date significantly before minimum', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2023, 12, 1),
        validators: [BetweenDatesValidator(minDate: minDate, maxDate: maxDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'betweenDates');
    });

    test('should invalidate date significantly after maximum', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 12, 31),
        validators: [BetweenDatesValidator(minDate: minDate, maxDate: maxDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'betweenDates');
    });

    test('should accept null values as valid', () {
      final controller = FieldController(
        key: 'date_field',
        validators: [BetweenDatesValidator(minDate: minDate, maxDate: maxDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should use custom message when provided', () {
      const customMessage = 'Date must be between January 10 and 20, 2024';
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 5),
        validators: [
          BetweenDatesValidator(
              minDate: minDate, maxDate: maxDate, message: customMessage)
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'betweenDates');
      expect(result.message, customMessage);
    });

    test('should use key as message when message is null', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 5),
        validators: [BetweenDatesValidator(minDate: minDate, maxDate: maxDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'betweenDates');
      expect(result.message, 'betweenDates');
    });

    test('should validate with time precision - within range', () {
      final minDateTime = DateTime(2024, 1, 10, 10, 0);
      final maxDateTime = DateTime(2024, 1, 10, 20, 0);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 10, 15, 30),
        validators: [
          BetweenDatesValidator(minDate: minDateTime, maxDate: maxDateTime)
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should validate exact same moment as minimum', () {
      final exactDateTime = DateTime(2024, 1, 10, 15, 30, 45, 123);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 10, 15, 30, 45, 123),
        validators: [
          BetweenDatesValidator(minDate: exactDateTime, maxDate: maxDate)
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should validate exact same moment as maximum', () {
      final exactDateTime = DateTime(2024, 1, 20, 15, 30, 45, 123);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 20, 15, 30, 45, 123),
        validators: [
          BetweenDatesValidator(minDate: minDate, maxDate: exactDateTime)
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should invalidate by milliseconds before minimum', () {
      final minDateTime = DateTime(2024, 1, 10, 10, 30, 45, 500);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 10, 10, 30, 45, 499),
        validators: [
          BetweenDatesValidator(minDate: minDateTime, maxDate: maxDate)
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'betweenDates');
    });

    test('should invalidate by milliseconds after maximum', () {
      final maxDateTime = DateTime(2024, 1, 20, 10, 30, 45, 500);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 20, 10, 30, 45, 501),
        validators: [
          BetweenDatesValidator(minDate: minDate, maxDate: maxDateTime)
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'betweenDates');
    });

    test('should work with same day range', () {
      final sameDay = DateTime(2024, 1, 15);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15),
        validators: [BetweenDatesValidator(minDate: sameDay, maxDate: sameDay)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should work with wide year range', () {
      final minYear = DateTime(2020, 1, 1);
      final maxYear = DateTime(2030, 12, 31);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2025, 6, 15),
        validators: [BetweenDatesValidator(minDate: minYear, maxDate: maxYear)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should work with leap year dates', () {
      final minLeap = DateTime(2024, 2, 28);
      final maxLeap = DateTime(2024, 3, 1);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 2, 29),
        validators: [BetweenDatesValidator(minDate: minLeap, maxDate: maxLeap)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should work with month boundaries', () {
      final minMonth = DateTime(2024, 1, 31, 23, 59, 59);
      final maxMonth = DateTime(2024, 2, 1, 0, 0, 1);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 2, 1, 0, 0, 0),
        validators: [
          BetweenDatesValidator(minDate: minMonth, maxDate: maxMonth)
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });

    test('should validate with time zones consideration', () {
      final minUTC = DateTime.utc(2024, 1, 10, 10, 0);
      final maxUTC = DateTime.utc(2024, 1, 10, 20, 0);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime.utc(2024, 1, 10, 15, 0),
        validators: [BetweenDatesValidator(minDate: minUTC, maxDate: maxUTC)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'betweenDates');
    });
  });
}
