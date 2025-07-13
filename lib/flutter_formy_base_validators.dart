/// A library that defines [FormyValidator], [FormyCrossValidator] and various
/// field-level validators for validating data in [FieldController]s.
///
/// This library provides a comprehensive set of validation rules for strings,
/// numbers, dates and cross-field scenarios. It enables the creation of dynamic,
/// reactive and highly customizable forms by listening to changes in controllers
/// and automatically triggering rebuilds when the state updates.
///
/// ## Features
/// - Generic validators (length, contains, required, etc.)
/// - Numeric validators (min, max, divisible, odd/even, etc.)
/// - Date validators (before, after, between dates, age checks)
/// - String pattern validators (email, URL, IP, regex, etc.)
/// - Cross-field validators (must match, bigger than another field, etc.)
///
/// Part of the `flutter_formy` package.
library flutter_formy_base_validators;

export 'src/validators/formy_validator.dart';
export 'src/validators/formy_cross_validator.dart';
