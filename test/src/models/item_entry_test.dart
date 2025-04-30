import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "Item entry",
    () {
      const itemEntry =
          ItemEntry(value: 2, text: Text("teste"), enabled: false);

      expect(itemEntry.value, 2);
      expect(itemEntry.enabled, false);
      expect(itemEntry.text, isA<Text>());

      final Text textWidget = itemEntry.text as Text;
      expect(textWidget.data, 'teste');
    },
  );
}
