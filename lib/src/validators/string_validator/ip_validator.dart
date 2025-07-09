import 'package:flutter_formy/flutter_formy.dart';

enum IpType { ipV4, ipV6, ipV6Short }

class IpValidator extends FormyValidator<String> {
  final IpType ipType;
  IpValidator(this.ipType, {super.message});

  final RegExp _ipv4 = RegExp(
      r'^(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)){3}$');
  final _ipv6 = RegExp(r'^(([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}|'
      r'([0-9A-Fa-f]{1,4}:){1,7}:|'
      r'([0-9A-Fa-f]{1,4}:){1,6}:[0-9A-Fa-f]{1,4}|'
      r'([0-9A-Fa-f]{1,4}:){1,5}(:[0-9A-Fa-f]{1,4}){1,2}|'
      r'([0-9A-Fa-f]{1,4}:){1,4}(:[0-9A-Fa-f]{1,4}){1,3}|'
      r'([0-9A-Fa-f]{1,4}:){1,3}(:[0-9A-Fa-f]{1,4}){1,4}|'
      r'([0-9A-Fa-f]{1,4}:){1,2}(:[0-9A-Fa-f]{1,4}){1,5}|'
      r'[0-9A-Fa-f]{1,4}:((:[0-9A-Fa-f]{1,4}){1,6})|'
      r':((:[0-9A-Fa-f]{1,4}){1,7}|:)|'
      r'fe80:(:[0-9A-Fa-f]{0,4}){0,4}%[0-9a-zA-Z]{1,}|'
      r'::(ffff(:0{1,4}){0,1}:){0,1}'
      r'((25[0-5]|(2[0-4]|1{0,1}[0-9])?[0-9])\.){3,3}'
      r'(25[0-5]|(2[0-4]|1{0,1}[0-9])?[0-9])|'
      r'([0-9A-Fa-f]{1,4}:){1,4}:'
      r'((25[0-5]|(2[0-4]|1{0,1}[0-9])?[0-9])\.){3,3}'
      r'(25[0-5]|(2[0-4]|1{0,1}[0-9])?[0-9]))$');
  final RegExp _ipv6Short = RegExp(r'^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
        key: GenericValidators.ip.name,
        message: message,
        isValid: controller.value != null ? _check(controller.value!) : true,
      );

  bool _check(String fieldValue) {
    switch (ipType) {
      case IpType.ipV4:
        return _ipv4.hasMatch(fieldValue);
      case IpType.ipV6:
        return _ipv6.hasMatch(fieldValue);
      case IpType.ipV6Short:
        return _ipv6Short.hasMatch(fieldValue);
      default:
        return true;
    }
  }
}
