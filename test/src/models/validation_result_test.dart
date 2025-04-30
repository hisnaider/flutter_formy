import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "Validation result",
    () {
      const ValidationResult validationResult =
          ValidationResult(key: "key", isValid: true);
      expect(validationResult.key, "key");
      expect(validationResult.isValid, true);
    },
  );
}
