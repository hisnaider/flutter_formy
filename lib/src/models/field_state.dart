import 'package:flutter/foundation.dart';
import 'package:flutter_formy/src/models/validation_result.dart';

class FieldState<T> {
  const FieldState({
    required this.value,
    required this.validationResults,
    required this.dirty,
    required this.touched,
    required this.type,
  });
  final T? value;
  final List<ValidationResult> validationResults;
  final bool dirty;
  final bool touched;
  final Type type;

  const FieldState.initial(T? initialValue)
      : this(
          dirty: false,
          touched: false,
          validationResults: const [],
          value: initialValue,
          type: T,
        );

  FieldState<T> copyWith({
    T? value,
    List<ValidationResult>? validationResults,
    bool? dirty,
    bool? touched,
  }) {
    return FieldState<T>(
        value: value ?? this.value,
        validationResults: validationResults ?? this.validationResults,
        dirty: dirty ?? this.dirty,
        touched: touched ?? this.touched,
        type: type);
  }

  @override
  String toString() {
    return 'State(dirty: $dirty, touched: $touched, validationResults:$validationResults,value:$value)';
  }

  @override
  bool operator ==(covariant FieldState<T> other) {
    if (identical(this, other)) return true;

    return other.value == value &&
        listEquals(other.validationResults, validationResults) &&
        other.dirty == dirty &&
        other.touched == touched;
  }

  @override
  int get hashCode {
    return value.hashCode ^
        validationResults.hashCode ^
        dirty.hashCode ^
        touched.hashCode;
  }
}
