import 'package:flutter/foundation.dart';
import 'package:flutter_formy/flutter_formy.dart';

class FieldControl<T> extends ChangeNotifier {
  FieldControl({
    required this.key,
    this.validators = const [],
    this.initialValue,
  })  : assert(!key.contains("/"), 'A key não pode conter "/".'),
        _state = FieldState.initial(initialValue),
        id = DateTime.now().microsecondsSinceEpoch {
    FormManager.instance.insertField(this);
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

  void update({
    T? value,
    bool? touched,
    bool? hasFocus,
  }) {
    ///if (_state.value == value) return;
    final FieldState<T> oldState = _state;

    _state = _state.copyWith(
        value: value,
        dirty: value != _state.value ? true : _state.dirty,
        touched: touched,
        hasFocus: hasFocus);
    _validate();
    if (_state != oldState) {
      notifyListeners();
    }
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
  void update({
    List<T>? value,
    bool? touched,
    bool? hasFocus,
  }) {
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
