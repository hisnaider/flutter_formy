## 0.4.0

### Added
- Added `FormyDependentValidator` to handle cross-field validation.
- Added `TextFieldBuilder`, a `FieldBuilder` specialized for text fields.
- Added `FormyCrossValidator`, a base class for implementing cross-field validation logic.
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