import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AfterDateValidator', () {
    final referenceDate = DateTime(2024, 1, 15);

    test('should validate date after reference date', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 16),
        validators: [AfterDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'afterDate');
      expect(result.message, 'afterDate');
    });

    test('should validate date significantly after reference date', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 12, 31),
        validators: [AfterDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'afterDate');
    });

    test('should invalidate same date as reference', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15),
        validators: [AfterDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'afterDate');
    });

    test('should invalidate date before reference date', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 14),
        validators: [AfterDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'afterDate');
    });

    test('should invalidate date significantly before reference date', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2023, 1, 1),
        validators: [AfterDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'afterDate');
    });

    test('should accept null values as valid', () {
      final controller = FieldController(
        key: 'date_field',
        validators: [AfterDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'afterDate');
    });

    test('should use custom message when provided', () {
      const customMessage = 'Date must be after January 15, 2024';
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 10),
        validators: [AfterDateValidator(referenceDate, message: customMessage)],
      );

      final result = AfterDateValidator(referenceDate, message: customMessage)
          .onValidate(controller);

      expect(result.isValid, false);
      expect(result.key, 'afterDate');
      expect(result.message, customMessage);
    });

    test('should use key as message when message is null', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 10),
        validators: [AfterDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, false);
      expect(result.key, 'afterDate');
      expect(result.message, 'afterDate');
    });

    test('should validate with time precision - same day but later time', () {
      final referenceDateWithTime = DateTime(2024, 1, 15, 10, 30);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 10, 31),
        validators: [AfterDateValidator(referenceDateWithTime)],
      );

      final result =
          AfterDateValidator(referenceDateWithTime).onValidate(controller);

      expect(result.isValid, true);
      expect(result.key, 'afterDate');
    });

    test('should invalidate with time precision - same day but earlier time',
        () {
      final referenceDateWithTime = DateTime(2024, 1, 15, 10, 30);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 10, 29),
        validators: [AfterDateValidator(referenceDateWithTime)],
      );

      final result =
          AfterDateValidator(referenceDateWithTime).onValidate(controller);

      expect(result.isValid, false);
      expect(result.key, 'afterDate');
    });

    test('should validate with millisecond precision', () {
      final referenceDateWithMillis = DateTime(2024, 1, 15, 10, 30, 45, 500);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 10, 30, 45, 501),
        validators: [AfterDateValidator(referenceDateWithMillis)],
      );

      final result =
          AfterDateValidator(referenceDateWithMillis).onValidate(controller);

      expect(result.isValid, true);
      expect(result.key, 'afterDate');
    });

    test('should invalidate with millisecond precision', () {
      final referenceDateWithMillis = DateTime(2024, 1, 15, 10, 30, 45, 500);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 10, 30, 45, 499),
        validators: [AfterDateValidator(referenceDateWithMillis)],
      );

      final result =
          AfterDateValidator(referenceDateWithMillis).onValidate(controller);

      expect(result.isValid, false);
      expect(result.key, 'afterDate');
    });

    test('should work with different years', () {
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2025, 1, 1),
        validators: [AfterDateValidator(referenceDate)],
      );

      final result = controller.validationResults.first;

      expect(result.isValid, true);
      expect(result.key, 'afterDate');
    });

    test('should work with leap year dates', () {
      final leapYearDate = DateTime(2024, 2, 29);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 3, 1),
        validators: [AfterDateValidator(leapYearDate)],
      );

      final result = AfterDateValidator(leapYearDate).onValidate(controller);

      expect(result.isValid, true);
      expect(result.key, 'afterDate');
    });

    test('should strictly validate - exactly same datetime is invalid', () {
      final exactDateTime = DateTime(2024, 1, 15, 14, 30, 45, 123);
      final controller = FieldController(
        key: 'date_field',
        initialValue: DateTime(2024, 1, 15, 14, 30, 45, 123),
        validators: [AfterDateValidator(exactDateTime)],
      );

      final result = AfterDateValidator(exactDateTime).onValidate(controller);

      expect(result.isValid, false);
      expect(result.key, 'afterDate');
    });
  });
}
