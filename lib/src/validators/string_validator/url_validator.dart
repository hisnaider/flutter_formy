import 'package:flutter_formy/flutter_formy.dart';

/// A validator that checks if the value is a valid URL.
///
/// The [UrlValidator] can be used with [FieldController]s holding
/// values of type `String`. It ensures that the
/// value is a valid URL.
///
/// If the value is `null` it is treated as valid by default.
///
/// ## Properties
///
/// * [message]: An optional custom error message to display when invalid.
///
/// ## Example
/// ```dart
/// FieldController<String> field = FieldController(
///   key: 'string',
///   validators:[UrlValidator()],
/// );
///
/// // If field.value = 'example', validation fails.
/// // If field.value = 'http:///example', validation fails.
/// // If field.value = 'example.c', validation fails.
/// // If field.value = 'http://', validation fails.
/// // If field.value = 'example.abcdefg', validation fails.
/// // If field.value = 'example.com', validation passes.
/// // If field.value = 'https://example.com', validation passes.
/// // If field.value = 'http://sub.domain.com/path/to/page', validation passes.
/// // If field.value = 'www.example.org', validation passes.
/// // If field.value = 'https://example.com:8080/path', validation passes.
/// ```
///
/// ## See also
///
/// * [FormyValidator], the base class for custom validators.
/// * [ValidationResult], which describes the outcome of validation.
/// * [FieldController], which holds the field value to be validated.
class UrlValidator extends FormyValidator<String> {
  UrlValidator({super.message});

  final RegExp _pattern = RegExp(r'^(https?:\/\/)?'
      r'([\w\-]+\.)+[a-z]{2,6}'
      r'(:[0-9]{1,5})?'
      r'(\/\S*)?$');

  @override
  ValidationResult onValidate(FieldController<String> controller) =>
      ValidationResult(
        key: GenericValidators.url.name,
        message: message,
        isValid: controller.value != null
            ? _pattern.hasMatch(controller.value!)
            : true,
      );
}
