/// Formy - A modular form state management library for Flutter.
///
/// Provides field and group controllers, builders, and validation
/// utilities for building complex forms with ease.
library flutter_formy;

//enum
export 'src/enum/generic_validators.dart';

//
//
//
//models
export 'src/controller/field_controller.dart';
export 'src/models/field_state.dart';
export 'src/models/item_entry.dart';
export 'src/models/validation_result.dart';
//
//
//
//services
export 'src/manager/form_manager.dart';

//
//
//
//validators
export 'src/validators/string_validator/email_validator.dart';
export 'src/validators/formy_validator.dart';
export 'src/validators/generic_validators/is_required_validator.dart';
export 'src/validators/generic_validators/max_length_validator.dart';
export 'src/validators/generic_validators/min_length_validator.dart';
export 'src/validators/cross_validators/must_match_validator.dart';

//
//
//
//widgets
export 'src/widgets/formy_checkbox.dart';
export 'src/widgets/formy_list_checkbox.dart';
export 'src/widgets/formy_option_mark_widget.dart';
export 'src/widgets/formy_radio.dart';
export 'src/widgets/formy_text_field.dart';
export 'src/widgets/formy_dropdown.dart';
export 'src/widgets/formy_group_visibility.dart';

//selector
export 'src/libraries/flutter_formy_selector.dart';
//builder
export 'src/libraries/flutter_formy_builder.dart';
