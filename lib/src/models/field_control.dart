import 'package:flutter/foundation.dart';

import 'package:flutter_formy/src/models/field_state.dart';
import 'package:flutter_formy/src/models/validation_result.dart';
import 'package:flutter_formy/src/validators/formy_validator.dart';

class FieldControl<T> extends ChangeNotifier {
  FieldControl({
    required this.key,
    this.validators = const [],
    this.initialValue,
  })  : _state = FieldState.initial(initialValue),
        id = DateTime.now().microsecondsSinceEpoch {
    _validate();
  }

  final String key;
  final int id;
  List<FormyValidator<T?>> validators;
  final T? initialValue;

  FieldState<T> _state;

  bool get isRequired => validationResults.any((e) => e.key == "isRequired");
  T? get value => _state.value;
  List<ValidationResult> get validationResults => _state.validationResults;

  FieldState<T> get state => _state;

  void validate() => _validate();

  void update(T value) {
    bool isSame = false;
    if (value is List && _state.value is List) {
      isSame = listEquals(value as List, _state.value as List);
    } else {
      isSame = _state.value == value;
    }
    if (isSame) return;
    final FieldState<T> oldState = _state;

    _state = _state.copyWith(
      value: value,
      dirty: value != _state.value ? true : _state.dirty,
    );
    _validate();
    if (_state != oldState) {
      notifyListeners();
    }
  }

  void touch() {
    _state = _state.copyWith(
      touched: true,
    );
    _validate();
    notifyListeners();
  }

  void reset() {
    _state = FieldState.initial(initialValue);
    _validate();
    notifyListeners();
  }

  void updateValidators(List<FormyValidator<T?>> newValidators) {
    validators = newValidators;
    _validate();
    notifyListeners();
  }

  void _validate() {
    _state = _state.copyWith(
        validationResults: validators.map((e) => e(this)).toList());
  }
}

class FieldListControl<T> extends FieldControl<List<T>> {
  FieldListControl({
    required super.key,
    super.validators = const [],
  }) : super(initialValue: <T>[]) {
    _validate();
  }

  @override
  void validate() => _validate();

  @override
  void update(List<T> value) {
    bool isSame = false;
    isSame = listEquals(value, _state.value);
    if (isSame) return;
    FieldState<List<T>> oldState = _state;
    _state = _state.copyWith(
      value: value,
      dirty: value != _state.value ? true : _state.dirty,
    );
    _validate();
    if (_state != oldState) {
      notifyListeners();
    }
  }
}
