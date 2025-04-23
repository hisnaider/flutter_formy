// ignore_for_file: public_member_api_docs, sort_constructors_first
class GroupState {
  const GroupState({
    this.isValid = true,
    this.wasValidated = false,
    this.errorMessages = const [],
    this.firstErrorFieldKey,
    this.validCount = 0,
  });
  final bool isValid;
  final bool wasValidated;
  final List<String> errorMessages;
  final String? firstErrorFieldKey;
  final int validCount;

  GroupState copyWith({
    bool? isValid,
    bool? wasValidated,
    List<String>? errorMessages,
    String? firstErrorFieldKey,
    int? validCount,
  }) {
    return GroupState(
      isValid: isValid ?? this.isValid,
      wasValidated: wasValidated ?? this.wasValidated,
      errorMessages: errorMessages ?? this.errorMessages,
      firstErrorFieldKey: firstErrorFieldKey ?? this.firstErrorFieldKey,
      validCount: validCount ?? this.validCount,
    );
  }
}
