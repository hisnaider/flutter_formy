import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BeforeDateValidator', () {
    final referenceDate = DateTime(2024, 1, 15);

    test('should validate date before reference date', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 14),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'beforeDate');
      expect(result.message, 'beforeDate');
    });

    test('should validate date significantly before reference date', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2023, 1, 1),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'beforeDate');
    });

    test('should invalidate same date as reference', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'beforeDate');
    });

    test('should invalidate date after reference date', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 16),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'beforeDate');
    });

    test('should invalidate date significantly after reference date', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 12, 31),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'beforeDate');
    });

    test('should accept null values as valid', () {
      final controller = FieldController(
        key: 'date_field',
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'beforeDate');
    });

    test('should use custom message when provided', () {
      const customMessage = 'Date must be before January 15, 2024';
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 20),
        validators: [
          BeforeDateValidator(referenceDate, message: customMessage)
        ],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'beforeDate');
      expect(result.message, customMessage);
    });

    test('should use key as message when message is null', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 20),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'beforeDate');
      expect(result.message, 'beforeDate');
    });

    test('should validate with time precision - same day but earlier time', () {
      final referenceDateWithTime = DateTime(2024, 1, 15, 10, 30);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 10, 29),
        validators: [BeforeDateValidator(referenceDateWithTime)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'beforeDate');
    });

    test('should invalidate with time precision - same day but later time', () {
      final referenceDateWithTime = DateTime(2024, 1, 15, 10, 30);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 10, 31),
        validators: [BeforeDateValidator(referenceDateWithTime)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'beforeDate');
    });

    test('should validate with millisecond precision', () {
      final referenceDateWithMillis = DateTime(2024, 1, 15, 10, 30, 45, 500);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 10, 30, 45, 499),
        validators: [BeforeDateValidator(referenceDateWithMillis)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'beforeDate');
    });

    test('should invalidate with millisecond precision', () {
      final referenceDateWithMillis = DateTime(2024, 1, 15, 10, 30, 45, 500);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 10, 30, 45, 501),
        validators: [BeforeDateValidator(referenceDateWithMillis)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'beforeDate');
    });

    test('should work with different years', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2023, 12, 31),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'beforeDate');
    });

    test('should work with leap year dates', () {
      final leapYearDate = DateTime(2024, 2, 29);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 2, 28),
        validators: [BeforeDateValidator(leapYearDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'beforeDate');
    });

    test('should strictly validate - exactly same datetime is invalid', () {
      final exactDateTime = DateTime(2024, 1, 15, 14, 30, 45, 123);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 14, 30, 45, 123),
        validators: [BeforeDateValidator(exactDateTime)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'beforeDate');
    });

    test('should validate month boundaries', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 14, 23, 59, 59),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'beforeDate');
    });

    test('should invalidate at month boundaries', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 0, 0, 1),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'beforeDate');
    });

    test('should work with distant past dates', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(1900, 1, 1),
        validators: [BeforeDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'beforeDate');
    });
  });
}
