import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should create FieldController', () {
    final FieldController field = FieldController<String>('field');
    expect(field.completeKey, 'field');
    expect(field.value, isNull);
    expect(field.state.dirty, isFalse);
    expect(field.state.touched, isFalse);
    expect(field.valid, isTrue);
  });
  test('Should be valid if initialValue passes validation', () {
    final field = FieldController<String>(
      'email',
      initialValue: 'valid@email.com',
      validators: [EmailValidator()],
    );
    expect(field.valid, isTrue);
  });
  test('Should update FieldController', () {
    final FieldController field = FieldController<String>('field');
    field.update('test');
    expect(field.value, 'test');
    expect(field.state.dirty, true);
    expect(field.initialValue, isNull);
  });
  test('Should mark FieldController as touched and', () {
    final FieldController field = FieldController<String>('field');
    field.markAsTouched();
    expect(field.state.touched, true);
    field.markAsDirty();
    expect(field.state.dirty, true);
  });
  test('Should reset FieldController', () {
    final FieldController field =
        FieldController<String>('field', initialValue: 'value');
    field.update('newValue');
    field.reset();
    expect(field.value, 'value');
    expect(field.state.dirty, isFalse);
  });
  test("Should be required", () {
    final FieldController field = FieldController<String>(
      'field',
      validators: [IsRequired()],
    );
    expect(field.isRequired, true);
  });
  test('Should return list of validation keys correctly', () {
    final FieldController field = FieldController<String>(
      'field',
      validators: [IsRequired(), EmailValidator(), MinValidator(6)],
      showErrorWhen: ShowError.always,
    );
    expect(field.errorKeys, [
      GenericValidators.isRequired.name,
    ]);
    field.update('value');
    expect(field.errorKeys, [
      GenericValidators.invalidEmail.name,
      GenericValidators.min.name,
    ]);
    field.update('value@');
    expect(field.errorKeys, [
      GenericValidators.invalidEmail.name,
    ]);
    field.update('value@gmail.com');
    expect(field.errorKeys, []);
  });
  test('Should throw error if the key contains `/`', () {
    expect(
      () => FieldController<String>('field/field'),
      throwsA(predicate((e) =>
          e is AssertionError &&
          e.toString().contains('The key cannot contain "/".'))),
    );
  });

  group('FieldListController', () {
    test('Should create FieldListControl', () {
      final field = FieldListControl<String>('field');
      expect(field.value, []);
    });

    test('Should update FieldListControl', () {
      final field = FieldListControl<String>('field');
      field.update(['a', 'b']);
      expect(field.value, ['a', 'b']);
    });
  });
  group('Validation tests', () {
    test('Should validate a single validator', () {
      final FieldController field =
          FieldController<String>('field', validators: [IsRequired()]);
      expect(field.valid, isFalse);
      field.update('');
      expect(field.valid, isFalse);
      field.update('value');
      expect(field.valid, isTrue);
    });
    test('Should validate a multiple validators', () {
      final FieldController field = FieldController<String>('field',
          validators: [IsRequired(), EmailValidator()]);
      expect(field.valid, isFalse);
      field.update('value');
      expect(field.valid, isFalse);
      field.update('value@email.com');
      expect(field.valid, isTrue);
    });
    test("Never show error message", () {
      final FieldController field = FieldController<String>('field',
          validators: [IsRequired()], showErrorWhen: ShowError.never);
      expect(field.valid, isFalse);
      expect(field.firstError, null);
      field.update('value');
      expect(field.valid, isTrue);
      expect(field.firstError, null);
    });
    test("Show error only when is touched", () {
      final FieldController field = FieldController<String>('field',
          validators: [IsRequired()], showErrorWhen: ShowError.whenIsTouched);
      expect(field.valid, isFalse);
      expect(field.firstError, null);
      field.markAsTouched();
      expect(field.valid, isFalse);
      expect(field.firstError, GenericValidators.isRequired.name);
      field.update('value');
      expect(field.valid, isTrue);
      expect(field.firstError, null);
    });
    test("Always show error message", () {
      final FieldController field = FieldController<String>('field',
          validators: [IsRequired()], showErrorWhen: ShowError.always);
      expect(field.valid, isFalse);
      expect(field.firstError, GenericValidators.isRequired.name);
      field.update('value');
      expect(field.valid, isTrue);
      expect(field.firstError, null);
    });
  });
}
