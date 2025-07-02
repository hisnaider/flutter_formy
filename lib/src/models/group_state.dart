// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class GroupState {
  const GroupState({
    this.isEnabled = true,
    this.isValid = true,
    this.wasValidated = false,
    this.errorMessages = const [],
    this.firstErrorField,
    this.validCount = 0,
  });
  final bool isEnabled;
  final bool isValid;
  final bool wasValidated;
  final List<String> errorMessages;
  final String? firstErrorField;
  final int validCount;

  GroupState copyWith({
    bool? isEnabled,
    bool? isValid,
    bool? wasValidated,
    List<String>? errorMessages,
    String? firstErrorField,
    int? validCount,
  }) {
    return GroupState(
      isEnabled: isEnabled ?? this.isEnabled,
      isValid: isValid ?? this.isValid,
      wasValidated: wasValidated ?? this.wasValidated,
      errorMessages: errorMessages ?? this.errorMessages,
      firstErrorField: firstErrorField ?? this.firstErrorField,
      validCount: validCount ?? this.validCount,
    );
  }

  @override
  String toString() {
    return 'State(isEnabled: $isEnabled, isValid: $isValid, wasValidated: $wasValidated, errorMessages:$errorMessages,firstErrorFieldKey:$firstErrorField, validCount: $validCount)';
  }

  @override
  bool operator ==(covariant GroupState other) {
    if (identical(this, other)) return true;

    return other.isEnabled == isEnabled &&
        other.isValid == isValid &&
        listEquals(other.errorMessages, errorMessages) &&
        other.wasValidated == wasValidated &&
        other.firstErrorField == firstErrorField &&
        other.validCount == validCount;
  }

  @override
  int get hashCode {
    return isEnabled.hashCode ^
        isValid.hashCode ^
        wasValidated.hashCode ^
        errorMessages.hashCode ^
        firstErrorField.hashCode ^
        validCount.hashCode ^
        validCount.hashCode;
  }
}
