import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ValidationResult validationResult =
      ValidationResult(key: "key", isValid: true);
  group("Field state group", () {
    test(
      "Should create FieldState with right values",
      () {
        final state = FieldState(
            value: "value",
            validationResults: [validationResult],
            dirty: false,
            touched: true,
            hasFocus: false);
        expect(state.value, "value");
        expect(state.validationResults, [validationResult]);
        expect(state.dirty, false);
        expect(state.touched, true);
        expect(state.hasFocus, false);
      },
    );
    test(
      "Should create FieldState with initial values",
      () {
        const state = FieldState.initial("initialValue");
        expect(state.value, "initialValue");
        expect(state.validationResults, []);
        expect(state.dirty, false);
        expect(state.touched, false);
        expect(state.hasFocus, false);
      },
    );
    test(
      "Should update FieldState",
      () {
        FieldState state = const FieldState.initial("initialValue");
        state = state.copyWith(
          value: "otherValue",
          dirty: true,
          hasFocus: true,
          touched: true,
          validationResults: [validationResult],
        );
        expect(state.value, "otherValue");
        expect(state.validationResults, [validationResult]);
        expect(state.dirty, true);
        expect(state.touched, true);
        expect(state.hasFocus, true);
      },
    );
    test(
      "Should tranform FieldState into String correctly",
      () {
        const FieldState state = FieldState.initial("initialValue");
        expect(state.toString(),
            'State(dirty: ${state.dirty}, touched: ${state.touched}, validationResults:${state.validationResults},value:${state.value}, hasFocus: ${state.hasFocus})');
      },
    );
    test(
      "two FieldState should be equal",
      () {
        const FieldState state1 = FieldState.initial("initialValue");
        const FieldState state2 = FieldState.initial("initialValue");

        expect(state1 == state2, true);
      },
    );
    test(
      "two FieldState should be different",
      () {
        const FieldState state1 = FieldState.initial("initialValue");
        const FieldState state2 = FieldState.initial("otherValue");
        expect(state1 == state2, false);
      },
    );
  });
}
