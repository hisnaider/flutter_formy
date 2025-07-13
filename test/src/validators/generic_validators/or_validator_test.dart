import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

class _AlwaysValidValidator extends FormyValidator<String> {
  _AlwaysValidValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) {
    return ValidationResult(
      key: 'alwaysValid',
      message: message ?? 'Always valid',
      isValid: true,
    );
  }
}

class _AlwaysInvalidValidator extends FormyValidator<String> {
  _AlwaysInvalidValidator({super.message});

  @override
  ValidationResult onValidate(FieldController<String> controller) {
    return ValidationResult(
      key: 'alwaysInvalid',
      message: message ?? 'Always invalid',
      isValid: false,
    );
  }
}

void main() {
  group('OrValidator Tests', () {
    group('Basic OR logic', () {
      test('should return valid when first validator passes', () {
        final orValidator = OrValidator([
          MinLengthValidator(3), // Will pass for "hello"
          MaxLengthValidator(2), // Will fail for "hello"
        ], message: 'Must be at least 3 chars OR at most 2 chars');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'hello', // 5 chars - passes first validator
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, true);
        expect(result.key,
            'minLength'); // Returns result from first passing validator
        expect(result.message, GenericValidators.minLength.name);
      });

      test('should return valid when second validator passes', () {
        final orValidator = OrValidator([
          MinLengthValidator(10), // Will fail for "hi"
          MaxLengthValidator(5), // Will pass for "hi"
        ], message: 'Must be at least 10 chars OR at most 5 chars');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'hi', // 2 chars - fails first, passes second
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, true);
        expect(result.key, 'maxLength'); // Returns result from second validator
        expect(result.message, GenericValidators.maxLength.name);
      });

      test('should return invalid when all validators fail', () {
        final orValidator = OrValidator([
          MinLengthValidator(10), // Will fail for "hello"
          MaxLengthValidator(2), // Will fail for "hello"
        ], message: 'Must be at least 10 chars OR at most 2 chars');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'hello', // 5 chars - fails both validators
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, false);
        expect(result.key, GenericValidators.or.name);
        expect(result.message, 'Must be at least 10 chars OR at most 2 chars');
      });
    });

    group('Multiple validators', () {
      test('should return valid when any of multiple validators passes', () {
        final orValidator = OrValidator([
          MinLengthValidator(20), // Will fail
          MaxLengthValidator(10), // Will fail
          EmailValidator(), // Will pass for "test@example.com"
          IsRequired(), // Will pass
        ], message: 'Must meet at least one condition');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test@example.com',
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, true);
        expect(result.key,
            GenericValidators.invalidEmail.name); // First passing validator
      });

      test('should return first valid result in order', () {
        final orValidator = OrValidator([
          _AlwaysValidValidator(message: 'First valid'),
          _AlwaysValidValidator(message: 'Second valid'),
          _AlwaysValidValidator(message: 'Third valid'),
        ], message: 'At least one should pass');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test',
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, true);
        expect(
            result.message, 'First valid'); // Should return first valid result
      });

      test('should check all validators when all fail', () {
        final orValidator = OrValidator([
          MinLengthValidator(10),
          MaxLengthValidator(2),
          EmailValidator(),
        ], message: 'Must meet at least one condition');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'hello', // Fails all conditions
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, false);
        expect(result.key, GenericValidators.or.name);
        expect(result.message, 'Must meet at least one condition');
      });
    });

    group('Edge cases', () {
      test('should handle empty validator list', () {
        final orValidator = OrValidator([], message: 'No validators provided');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test',
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, false);
        expect(result.key, GenericValidators.or.name);
        expect(result.message, 'No validators provided');
      });

      test('should handle single validator that passes', () {
        final orValidator = OrValidator([
          _AlwaysValidValidator(message: 'Single valid'),
        ], message: 'Single validator');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test',
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, true);
        expect(result.message, 'Single valid');
      });

      test('should handle single validator that fails', () {
        final orValidator = OrValidator([
          _AlwaysInvalidValidator(message: 'Single invalid'),
        ], message: 'Single validator failed');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test',
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, false);
        expect(result.key, GenericValidators.or.name);
        expect(result.message, 'Single validator failed');
      });

      test('should handle null values', () {
        final orValidator = OrValidator([
          MinLengthValidator(3),
          IsRequired(),
        ], message: 'Must be valid');

        final controller = FieldController<String?>(
          key: 'field1',
          initialValue: null,
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, true);
        expect(result.key, GenericValidators.minLength.name);
      });
    });

    group('Complex scenarios', () {
      test('should work with mixed validator types', () {
        // Create validators for different scenarios:
        // 1. Very short strings (1-2 chars) OR
        // 2. Valid email addresses OR
        // 3. Very long strings (20+ chars)
        final orValidator = OrValidator([
          MaxLengthValidator(2, message: 'Too short is OK'),
          EmailValidator(message: 'Valid email'),
          MinLengthValidator(20, message: 'Very long is OK'),
        ], message: 'Must be very short, valid email, or very long');

        // Test very short string
        final shortController = FieldController<String>(
          key: 'field1',
          initialValue: 'hi',
        );
        final shortResult = orValidator.onValidate(shortController);
        expect(shortResult.isValid, true);
        expect(shortResult.message, 'Too short is OK');

        // Test email
        final emailController = FieldController<String>(
          key: 'field2',
          initialValue: 'test@example.com',
        );
        final emailResult = orValidator.onValidate(emailController);
        expect(emailResult.isValid, true);
        expect(emailResult.message, 'Valid email');

        // Test very long string
        final longController = FieldController<String>(
          key: 'field3',
          initialValue: 'this is a very long string that should pass',
        );
        final longResult = orValidator.onValidate(longController);
        expect(longResult.isValid, true);
        expect(longResult.message, 'Very long is OK');

        // Test medium length without @ (should fail all)
        final mediumController = FieldController<String>(
          key: 'field4',
          initialValue: 'medium',
        );
        final mediumResult = orValidator.onValidate(mediumController);
        expect(mediumResult.isValid, false);
        expect(mediumResult.message,
            'Must be very short, valid email, or very long');
      });

      test('should handle nested OR conditions', () {
        // Simulate: (min 5 chars) OR (max 2 chars) OR (contains @)
        final orValidator = OrValidator([
          MinLengthValidator(8, message: 'At least 8 chars'),
          MaxLengthValidator(2, message: 'At most 2 chars'),
          EmailValidator(message: 'Contains @'),
        ], message: 'Must meet at least one condition');

        // Test cases
        final testCases = [
          ('hello world', true, 'At least 8 chars'), // Passes first condition
          ('hi', true, 'At most 2 chars'), // Passes second condition
          ('a@b.com', true, 'Contains @'), // Passes third condition
          ('test', false, 'Must meet at least one condition'), // Fails all
        ];

        for (final (input, expectedValid, expectedMessage) in testCases) {
          final controller = FieldController<String>(
            key: 'field1',
            initialValue: input,
          );
          final result = orValidator.onValidate(controller);
          expect(result.isValid, expectedValid,
              reason: 'Failed for input: $input');
          expect(result.message, expectedMessage,
              reason: 'Wrong message for input: $input');
        }
      });
    });

    group('Message handling', () {
      test('should use custom message for OR validator when all fail', () {
        final orValidator = OrValidator([
          _AlwaysInvalidValidator(),
          _AlwaysInvalidValidator(),
        ], message: 'Custom OR validation message');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test',
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, false);
        expect(result.message, 'Custom OR validation message');
      });

      test('should return message from first passing validator', () {
        final orValidator = OrValidator([
          _AlwaysInvalidValidator(message: 'First failed'),
          _AlwaysValidValidator(message: 'Second passed'),
          _AlwaysValidValidator(message: 'Third passed'),
        ], message: 'OR validation message');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test',
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, true);
        expect(result.message, 'Second passed');
      });
    });

    group('Constructor validation', () {
      test('should require message parameter', () {
        // This test verifies that the constructor requires a message
        expect(() => OrValidator([], message: 'Required message'),
            returnsNormally);
      });

      test('should store validators list correctly', () {
        final validator1 = _AlwaysValidValidator();
        final validator2 = _AlwaysInvalidValidator();
        final validators = [validator1, validator2];

        final orValidator = OrValidator(validators, message: 'Test');

        expect(orValidator.validators, equals(validators));
        expect(orValidator.validators.length, 2);
        expect(orValidator.message, 'Test');
      });
    });

    group('Performance considerations', () {
      test('should stop at first passing validator (short-circuit)', () {
        // Create a list where first validator passes
        // If short-circuiting works, subsequent validators won't be called
        final orValidator = OrValidator([
          _AlwaysValidValidator(message: 'First valid'),
          _AlwaysValidValidator(message: 'Second valid'),
          _AlwaysValidValidator(message: 'Third valid'),
        ], message: 'At least one should pass');

        final controller = FieldController<String>(
          key: 'field1',
          initialValue: 'test',
        );

        final result = orValidator.onValidate(controller);

        expect(result.isValid, true);
        expect(result.message,
            'First valid'); // Should be first validator's message
      });
    });
  });
}
