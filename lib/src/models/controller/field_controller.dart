import 'package:flutter/foundation.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/group_state.dart';

part 'group_controller.dart';

enum ShowError { never, whenIsTouched, always }

class FieldController<T> extends ChangeNotifier {
  FieldController(
    this._completeKey, {
    this.validators = const [],
    this.initialValue,
    ShowError showErrorWhen = ShowError.whenIsTouched,
  })  : assert(!_completeKey.contains("/"), 'The key cannot contain "/".'),
        _state =
            FieldState.initial(initialValue ?? (T == bool ? false as T : null)),
        _showErrorWhen = showErrorWhen,
        _key = _completeKey,
        id = DateTime.now().microsecondsSinceEpoch {
    _validate();
  }

  String _completeKey;
  final String _key;
  final int id;
  List<FormyValidator<T?>> validators;
  final T? initialValue;
  final ShowError _showErrorWhen;

  FieldState<T> _state;

  String get key => _key;
  String get completeKey => _completeKey;
  T? get value => _state.value;
  List<ValidationResult> get validationResults => _state.validationResults;

  FieldState<T> get state => _state;

  void validate() => _validate();

  void update(
    T? value,
  ) {
    final FieldState<T> oldState = _state;

    _state = _state.copyWith(
      value: value,
      dirty: true,
    );
    _validate();
    if (_state != oldState) {
      _debugLog();
      notifyListeners();
    }
  }

  void markAsDirty() {
    if (state.dirty) return;
    _state = _state.copyWith(dirty: true);
    notifyListeners();
  }

  void markAsTouched() {
    if (state.touched) return;
    _state = _state.copyWith(touched: true);
    debugPrint(
        '\x1B[38;5;43m[FORMY]FieldController: $completeKey marked as touched\x1B[0m');
    notifyListeners();
  }

  bool mustShowError() =>
      _showErrorWhen == ShowError.always ||
      (_showErrorWhen == ShowError.whenIsTouched && state.touched);

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

  void _putInGroup(String groupKey) {
    _completeKey = '$groupKey/$_completeKey';
  }

  void _debugLog() {
    debugPrint('''
\x1B[38;5;43m[FORMY]FieldController: $completeKey is ${valid ? '\x1B[32mVALID\x1B[0m\x1B[0m' : '\x1B[31mINVALID\x1B[0m\x1B[0m'}
\x1B[38;5;43m  →  value = ${state.value}
\x1B[38;5;43m  →  isDirty = ${state.dirty}
\x1B[38;5;43m  →  isTouched = ${state.touched}
\x1B[38;5;43m  →  errors = $errorKeys\x1B[0m
''');
  }
}

class FieldListControl<T> extends FieldController<List<T>> {
  FieldListControl(
    super._key, {
    super.validators = const [],
  }) : super(initialValue: <T>[]) {
    _validate();
  }

  @override
  void validate() => _validate();

  @override
  void update(List<T>? value) {
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
      _debugLog();
      notifyListeners();
    }
  }
}

extension FieldControllerX<T> on FieldController<T> {
  bool get isRequired => validationResults.any((e) => e.key == "isRequired");
  String? get firstError => mustShowError()
      ? state.validationResults
          .where((v) => !v.isValid)
          .map((v) => v.key)
          .firstOrNull
      : null;
  List<String> get errorKeys => mustShowError()
      ? state.validationResults
          .where((v) => !v.isValid)
          .map((v) => v.key)
          .toList()
      : [];
  bool get valid => state.validationResults.every((e) => e.isValid);
}
