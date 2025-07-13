import 'package:flutter/foundation.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/group_state.dart';

part 'group_controller.dart';
part 'field_config.dart';
part 'subgroup_config.dart';

enum ShowError { never, whenIsTouched, always }

class FieldController<T> extends ChangeNotifier {
  factory FieldController({
    required String key,
    List<FormyValidator<T?>> validators = const [],
    T? initialValue,
    ShowError showErrorWhen = ShowError.whenIsTouched,
  }) {
    assert(!key.contains("/"), 'The key cannot contain "/".');
    return FieldController<T>._internal(
        key, initialValue, showErrorWhen, validators, null);
  }

  FieldController._internal(
    this._key,
    this._initialValue,
    this._showErrorWhen,
    this.validators,
    this._groupRef,
  )   : _state = FieldState.initial(
            _initialValue ?? (T == bool ? false as T : null)),
        createdTimestamp = DateTime.now().microsecondsSinceEpoch {
    _validate();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint(
        '\x1B[38;5;43m[FORMY] FieldController: "$completeKey" has been \x1B[31mDISPOSED\x1B[0m');
  }

  final String _key;
  final int createdTimestamp;
  List<FormyValidator<T?>> validators;
  T? _initialValue;
  final ShowError _showErrorWhen;

  FieldState<T> _state;

  GroupController? _groupRef;
  GroupController? get groupRef => _groupRef;

  T? get initialValue => _initialValue;
  String get key => _key;
  String get completeKey =>
      _groupRef == null ? _key : '${_groupRef!.key}/$_key';
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
        '\x1B[38;5;43m[FORMY] FieldController: $completeKey marked as touched\x1B[0m');
    notifyListeners();
  }

  bool _mustShowError() =>
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

  void _setInitialValue() {
    _initialValue = _state.value;
  }

  void _validate() {
    _state = _state.copyWith(
        validationResults: validators.map((e) => e(this)).toList());
  }

  void _debugLog() {
    debugPrint('''
\x1B[38;5;43m[FORMY] FieldController: $completeKey is ${valid ? '\x1B[32mVALID\x1B[0m\x1B[0m' : '\x1B[31mINVALID\x1B[0m\x1B[0m'}
\x1B[38;5;43m  →  value = ${state.value}
\x1B[38;5;43m  →  isDirty = ${state.dirty}
\x1B[38;5;43m  →  isTouched = ${state.touched}
\x1B[38;5;43m  →  errors = $errorKeys\x1B[0m
''');
  }
}

class FieldListController<T> extends FieldController<List<T>> {
  FieldListController({
    required String key,
    List<T>? initialValue,
    ShowError showErrorWhen = ShowError.whenIsTouched,
    List<FormyValidator<List<T>>> validators = const [],
  }) : super._internal(
          key,
          initialValue,
          showErrorWhen,
          validators,
          null,
        );

  FieldListController._internal(
    super.key,
    super.initialValue,
    super.showErrorWhen,
    List<FormyValidator<List<T>>> super.validators,
    super.groupRef,
  ) : super._internal();

  @override
  void validate() => _validate();

  @override
  void update(List<T>? value) {
    if (listEquals(value, _state.value)) return;
    FieldState<List<T>> oldState = _state;
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

  // void addItem(T item) {
  //   final updated = [...(value ?? []), item];
  //   update(updated);
  // }

  // void removeItem(T item) {
  //   final updated = [...(value ?? [])]..remove(item);
  //   update(updated);
  // }

  // void moveItem(int from, int to) {
  //   final updated = [...(value ?? [])];
  //   final item = updated.removeAt(from);
  //   updated.insert(to, item);
  //   update(updated);
  // }
}

extension FieldControllerX<T> on FieldController<T> {
  bool get isRequired => validationResults.any((e) => e.key == "isRequired");
  bool get hasError => validationResults.any((e) => e.isValid == false);
  String? get firstError => _mustShowError()
      ? state.validationResults
          .where((v) => !v.isValid)
          .map((v) => v.message)
          .firstOrNull
      : null;
  List<String> get errorKeys => _mustShowError()
      ? state.validationResults
          .where((v) => !v.isValid)
          .map((v) => v.key)
          .toList()
      : [];
  List<String?> get errorMessages => _mustShowError()
      ? state.validationResults
          .where((v) => !v.isValid)
          .map((v) => v.message)
          .toList()
      : [];
  bool get valid => state.validationResults.every((e) => e.isValid);
}
