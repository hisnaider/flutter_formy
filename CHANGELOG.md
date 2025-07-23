## 0.4.2

### Updated
- TextFieldBuilder has been added to the flutter_formy_builder library.


## 0.4.1

### Updated
- Readme has been updated.


## 0.4.0

### Added
- Added `FormyDependentValidator` to handle cross-field validation.
- Added `TextFieldBuilder`, a `FieldBuilder` specialized for text fields.
- Added `FormyValidator` test and documentation.
- Added `FormyCrossValidator`, a base class for implementing cross-field validation logic, test and documentation.
- Added the following validators with their documentation and test:
    - `MinLengthValidator`: Ensures the length of a field value is at least a specified minimum length.
    - `MaxLengthValidator`: Ensures the length of a field value is at most a specified maximum length.
    - `IsRequired`: Ensures the field value is not null, empty nor false.
    - `BetweenLengthValidator`: Ensures the length of a field value is within a specified range.
    - `ExactLengthValidator`: Ensures the length of a field value is exactly a specified length.
    - `OrValidator`: Ensures at least one of the specified validators passes.
    - `ContainsValidator`: Ensures the field value contains a specified value.
    - `NotContainsValidator`: Ensures the field value does not contain a specified value.
    - `BetweenValuesValidator`: Ensures the field value is within a specified range.
    - `DivisibleByValidator`: Ensures the field value is divisible by a specified number.
    - `EvenNumValidator`: Ensures the field value is even.
    - `MaxValueValidator`: Ensures the field value is at most a specified maximum value.
    - `MinValueValidator`: Ensures the field value is at least a specified minimum value.
    - `NegativeNumValidator`: Ensures the field value is negative.
    - `NonZeroValidator`: Ensures the field value is not zero.
    - `OddNumValidator`: Ensures the field value is odd.
    - `PositiveNumValidator`: Ensures the field value is positive.
    - `EmailValidator`: Ensures the field value is a valid email address.
    - `EndWithValidator`: Ensures the field value ends with a specified value.
    - `IpValidator`: Ensures the field value is a valid IP address.
    - `NoNumbersValidator`: Ensures the field value does not contain any numbers.
    - `NoSpaceValidator`: Ensures the field value does not contain any spaces.
    - `NoSpecialCharsValidator`: Ensures the field value does not contain any special characters.
    - `PatternValidator`: Ensures the field value matches a specified pattern.
    - `StartWithValidator`: Ensures the field value starts with a specified value.
    - `UrlValidator`: Ensures the field value is a valid URL.
    - `AfterDateValidator`: Ensures the field value is after a specified date.
    - `BeforeDateValidator`: Ensures the field value is before a specified date.
    - `BetweenDatesValidator`: Ensures the field value is within a specified date range.
    - `MaxAgeValidator`: Ensures the field value is at most a specified age.
    - `MinAgeValidator`: Ensures the field value is at least a specified age.
    - `BiggerThanValidator`: Ensures the field value is bigger than another field value.
    - `LessThanValidator`: Ensures the field value is less than another field value.
    - `MustMatchValidator`: Ensures the field value matches another field value.
    - `MustNotMatchValidator`: Ensures the field value does not match another field value.


### Updated
- Updated the structure of the field and group management to improve dependency handling and validation.

### Removed
- All references to dependencies have been removed from `FieldController`.


## 0.3.0

### Added
- FormManager test and documentation
- FormySelector test and documentation
- FieldSelector test and documentation
- GroupSelector test and documentation
- FormyBuilder documentation
- FieldBuilder documentation
- GroupBuilder documentation
- FocusableFieldBuilder documentation

### Fixed
- The `field` property of `FormyBuilder` has been renamed to `controller`.
- The `control` property of `FormySelector` has been renamed to `controller`.

### Removed
- Removed the `addListener` and `removeListener` methods from `FormyBuilder`.

## 0.2.1

### Fixed
- Added the `dispose` method to both `FieldController` and `GroupController`.
- Improved the debug print output for better clarity.

## 0.2.0

### Added
- FormManager has been created
- Added FormyBuilder, FieldBuilder and GroupBuilder documentation
- FormyBuilder test
- FieldBuilder test
- GroupBuilder test
- FocusableFieldBuilder test
### Fixed
- Fixed issue where using two `FocusableFieldBuilder` widgets on the same page would incorrectly share the same focus node.

## 0.1.0

### Added
- FormySubmitButton to react to GroupController's state changes
### Fixed
- Change FormySubGroupVisibility name to FormyGroupVisibility

## 0.0.3
### Fixed
- Remove hasFocus from FieldState
- Readme has been updated

## 0.0.2

### Fixed
- Atualização na descrição do pubspec.yaml