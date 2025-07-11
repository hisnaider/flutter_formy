## 0.4.0

### Added
- Added `FormyDependentValidator` to handle cross-field validation.
- Added `TextFieldBuilder`, a `FieldBuilder` specialized for text fields.
- Added `FormyCrossValidator`, a base class for implementing cross-field validation logic.
- Added the following validators with their documentation and test:
    //Generic
    - `MinLengthValidator`: Ensures the length of a text field is at least a specified minimum length.
    - `MaxLengthValidator`: Ensures the length of a text field is at most a specified maximum length.
    - `IsRequired`: Ensures a field is not null, empty nor false.
    - `BetweenLengthValidator`: Ensures the length of a text field is within a specified range.
    - `ExactLengthValidator`: Ensures the length of a text field is exactly a specified length.
    - `OrValidator`: Ensures at least one of the specified validators passes.
    //Numeric
    - `BetweenValuesValidator`: Ensures a numeric field is within a specified range.
    - `DivisibleByValidator`: Ensures a number is divisible by a specified number.
    - `EvenNumValidator`: Ensures a number is even.
    - `MaxValueValidator`: Ensures a number is at most a specified maximum value.
    - `MinValueValidator`: Ensures a number is at least a specified minimum value.
    - `NegativeNumValidator`: Ensures a number is negative.
    - `NonZeroValidator`: Ensures a number is not zero.
    - `OddNumValidator`: Ensures a number is odd.
    - `PositiveNumValidator`: Ensures a number is positive.
    //String
- Added `BiggerThanValidator`, which checks if the value of one field is greater than another.
- Added `LessThanValidator`, which checks if the value of one field is less than another.

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