/// A library that provides cross-field validators for use with Formy.
///
/// These validators compare the value of a field against another field in the
/// same group, enabling complex scenarios like:
///
/// - Checking if a value is greater or less than another field.
/// - Ensuring two fields match (e.g., password and confirm password).
/// - Ensuring two fields do not match.
///
/// ## Included validators
/// - [BiggerThanValidator]
/// - [LessThanValidator]
/// - [MustMatchValidator]
/// - [MustNotMatchValidator]
///
/// Part of the `flutter_formy` package.
library flutter_formy_cross_validators;

export 'src/validators/cross_validators/bigger_than_validator.dart';
export 'src/validators/cross_validators/less_than_validator.dart';
export 'src/validators/cross_validators/must_match_validator.dart';
export 'src/validators/cross_validators/must_not_match_validator.dart';
