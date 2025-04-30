import 'package:flutter_formy/src/models/group_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "Group state group",
    () {
      test(
        "Should create GroupState with right values",
        () {
          const state = GroupState(
            isValid: false,
            wasValidated: true,
            errorMessages: ["error1, error2"],
            firstErrorFieldKey: "error",
            validCount: 2,
          );
          expect(state.isValid, false);
          expect(state.wasValidated, true);
          expect(state.errorMessages, ["error1, error2"]);
          expect(state.firstErrorFieldKey, "error");
          expect(state.validCount, 2);
        },
      );
      test(
        "Should create GroupState with initial values",
        () {
          const state = GroupState();
          expect(state.isValid, true);
          expect(state.wasValidated, false);
          expect(state.errorMessages, []);
          expect(state.firstErrorFieldKey, null);
          expect(state.validCount, 0);
        },
      );
      test(
        "Should update GroupState",
        () {
          GroupState state = const GroupState();
          state = state.copyWith(
            isValid: false,
            wasValidated: true,
            errorMessages: ["error1, error2"],
            firstErrorFieldKey: "error",
            validCount: 2,
          );
          expect(state.isValid, false);
          expect(state.wasValidated, true);
          expect(state.errorMessages, ["error1, error2"]);
          expect(state.firstErrorFieldKey, "error");
          expect(state.validCount, 2);
        },
      );
      test(
        "Should tranform GroupState into String correctly",
        () {
          const GroupState state = GroupState();

          expect(
            state.toString(),
            'State(isValid: true, wasValidated: false, errorMessages:[],firstErrorFieldKey:null, validCount: 0)',
          );
        },
      );
      test(
        "two GroupState should be equal",
        () {
          const GroupState state1 = GroupState();
          const GroupState state2 = GroupState();

          expect(state1 == state2, true);
        },
      );
      test(
        "two GroupState should be different",
        () {
          const GroupState state1 = GroupState();
          const GroupState state2 = GroupState(errorMessages: ["error1"]);
          expect(state1 == state2, false);
        },
      );
    },
  );
}
