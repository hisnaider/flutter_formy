import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/libraries/validators_lib/flutter_formy_string_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IpValidator', () {
    group('Common Tests', () {
      test('should return valid when field value is null for IPv4', () {
        final controller = FieldController<String>(
          key: 'ip',
          initialValue: null,
          validators: [IpValidator(IpType.ipV4)],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'ip');
        expect(result.message, 'ip');
      });

      test('should return valid when field value is null for IPv6', () {
        final controller = FieldController<String>(
          key: 'ip',
          initialValue: null,
          validators: [IpValidator(IpType.ipV6)],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'ip');
      });

      test('should return valid when field value is null for IPv6Short', () {
        final controller = FieldController<String>(
          key: 'ip',
          initialValue: null,
          validators: [IpValidator(IpType.ipV6Short)],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, true);
        expect(result.key, 'ip');
      });

      test('should use custom message when provided', () {
        final controller = FieldController<String>(
          key: 'ip',
          initialValue: 'invalid-ip',
          validators: [IpValidator(IpType.ipV4, message: 'Invalid IP address')],
        );

        final result = controller.validationResults.first;

        expect(result.isValid, false);
        expect(result.key, 'ip');
        expect(result.message, 'Invalid IP address');
      });
    });

    group('IPv4 Tests', () {
      test('should validate standard IPv4 addresses', () {
        final testCases = [
          '192.168.1.1',
          '10.0.0.1',
          '172.16.0.1',
          '127.0.0.1',
          '8.8.8.8',
          '255.255.255.255',
          '0.0.0.0',
          '1.1.1.1',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV4)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, true, reason: 'Should validate $ip');
          expect(result.key, 'ip');
        }
      });

      test('should validate IPv4 addresses with single digit numbers', () {
        final testCases = [
          '1.2.3.4',
          '9.8.7.6',
          '0.1.2.3',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV4)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, true, reason: 'Should validate $ip');
        }
      });

      test('should validate IPv4 addresses with double digit numbers', () {
        final testCases = [
          '10.20.30.40',
          '99.88.77.66',
          '12.34.56.78',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV4)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, true, reason: 'Should validate $ip');
        }
      });

      test('should validate IPv4 addresses with triple digit numbers', () {
        final testCases = [
          '100.200.123.250',
          '255.254.253.252',
          '192.168.100.200',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV4)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, true, reason: 'Should validate $ip');
        }
      });

      test('should return invalid for IPv4 addresses with numbers > 255', () {
        final testCases = [
          '256.168.1.1',
          '192.256.1.1',
          '192.168.256.1',
          '192.168.1.256',
          '300.300.300.300',
          '999.999.999.999',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV4)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, false, reason: 'Should reject $ip');
        }
      });

      test('should return invalid for malformed IPv4 addresses', () {
        final testCases = [
          '192.168.1',
          '192.168',
          '192',
          '192.168.1.1.1',
          '192.168.1.1.1.1',
          '192.168.1.',
          '.192.168.1.1',
          '192..168.1.1',
          '192.168..1.1',
          '192.168.1.1.',
          '',
          '192.168.1.a',
          '192.168.b.1',
          '192.c.1.1',
          'd.168.1.1',
          'abc.def.ghi.jkl',
          '192.168.1.1 ',
          ' 192.168.1.1',
          '192 168 1 1',
          '192-168-1-1',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV4)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, false, reason: 'Should reject $ip');
        }
      });

      test('should return invalid for IPv4 with leading zeros', () {
        final testCases = [
          '001.002.003.004',
          '192.168.001.001',
          '010.020.030.040',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV4)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, false,
              reason: 'Should reject $ip with leading zeros');
        }
      });
    });

    group('IPv6 Tests', () {
      test('should validate standard IPv6 addresses', () {
        final testCases = [
          '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
          '2001:db8:85a3:0:0:8a2e:370:7334',
          '2001:db8:85a3::8a2e:370:7334',
          '::1',
          '::',
          '2001:db8::1',
          'fe80::1%lo0',
          '::ffff:192.0.2.1',
          '2001:db8:85a3::8a2e:370:7334',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV6)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, true, reason: 'Should validate $ip');
          expect(result.key, 'ip');
        }
      });

      test('should validate IPv6 addresses with embedded IPv4', () {
        final testCases = [
          '::ffff:192.168.1.1',
          '::ffff:10.0.0.1',
          '2001:db8::192.168.1.1',
          '::192.168.1.1',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV6)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, true, reason: 'Should validate $ip');
        }
      });

      test('should validate IPv6 addresses with link-local scope', () {
        final testCases = [
          'fe80::1%eth0',
          'fe80::1%lo0',
          'fe80::1%wlan0',
          'fe80::abcd:ef12:3456:7890%eth0',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV6)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, true, reason: 'Should validate $ip');
        }
      });

      test('should return invalid for malformed IPv6 addresses', () {
        final testCases = [
          '2001:0db8:85a3:0000:0000:8a2e:0370:7334:extra',
          '2001:0db8:85a3::8a2e::7334',
          '2001:0db8:85a3:0000:0000:8a2e:0370:',
          ':2001:0db8:85a3:0000:0000:8a2e:0370:7334',
          '2001:0db8:85a3:0000:0000:8a2e:0370:7334:',
          'gggg::1',
          '2001::85a3::7334',
          '192.168.1.1',
          '',
          '::1::',
          '2001:db8:85a3:0000:0000:8a2e:0370:7334 ',
          ' 2001:db8:85a3:0000:0000:8a2e:0370:7334',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV6)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, false, reason: 'Should reject $ip');
        }
      });
    });

    group('IPv6Short Tests', () {
      test('should validate short IPv6 addresses', () {
        final testCases = [
          '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
          'fe80:0000:0000:0000:0000:0000:0000:0001',
          '0000:0000:0000:0000:0000:0000:0000:0001',
          'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff',
          '1234:5678:9abc:def0:1234:5678:9abc:def0',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV6Short)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, true, reason: 'Should validate $ip');
          expect(result.key, 'ip');
        }
      });

      test('should return invalid for compressed IPv6 addresses', () {
        final testCases = [
          '2001:db8:85a3::8a2e:370:7334',
          '::1',
          '::',
          '2001:db8::1',
          'fe80::1',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV6Short)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, false, reason: 'Should reject compressed $ip');
        }
      });

      test('should return invalid for malformed IPv6Short addresses', () {
        final testCases = [
          '2001:0db8:85a3:0000:0000:8a2e:0370',
          '2001:0db8:85a3:0000:0000:8a2e:0370:7334:extra',
          'gggg:0000:0000:0000:0000:0000:0000:0001',
          '192.168.1.1',
          '',
          '2001:0db8:85a3:0000:0000:8a2e:0370:',
          ':2001:0db8:85a3:0000:0000:8a2e:0370:7334',
          '2001:0db8:85a3:0000:0000:8a2e:0370:7334 ',
          ' 2001:0db8:85a3:0000:0000:8a2e:0370:7334',
        ];

        for (final ip in testCases) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV6Short)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, false, reason: 'Should reject $ip');
        }
      });
    });

    group('Cross-validation Tests', () {
      test('should reject IPv4 addresses when validating IPv6', () {
        final ipv4Addresses = [
          '192.168.1.1',
          '10.0.0.1',
          '255.255.255.255',
        ];

        for (final ip in ipv4Addresses) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV6)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, false,
              reason: 'Should reject IPv4 $ip when validating IPv6');
        }
      });

      test('should reject IPv6 addresses when validating IPv4', () {
        final ipv6Addresses = [
          '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
          '::1',
          'fe80::1',
        ];

        for (final ip in ipv6Addresses) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV4)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, false,
              reason: 'Should reject IPv6 $ip when validating IPv4');
        }
      });

      test('should reject IPv6 addresses when validating IPv6Short', () {
        final ipv6Addresses = [
          '2001:db8:85a3::8a2e:370:7334',
          '::1',
          'fe80::1',
        ];

        for (final ip in ipv6Addresses) {
          final controller = FieldController<String>(
            key: 'ip',
            initialValue: ip,
            validators: [IpValidator(IpType.ipV6Short)],
          );

          final result = controller.validationResults.first;

          expect(result.isValid, false,
              reason:
                  'Should reject compressed IPv6 $ip when validating IPv6Short');
        }
      });
    });
  });
}
