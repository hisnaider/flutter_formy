import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

// Concrete implementation for testing
class TestFormySelector extends FormySelector<FieldController, String> {
  const TestFormySelector({
    super.key,
    required super.controller,
    required super.selector,
    required super.child,
  });

  @override
  State<TestFormySelector> createState() => _TestFormySelectorState();
}

class _TestFormySelectorState
    extends FormySelectorState<FieldController, String, TestFormySelector> {
  @override
  void addListener() {
    widget.controller.addListener(triggerUpdate);
  }

  @override
  void removeListener() {
    widget.controller.removeListener(triggerUpdate);
  }
}

void main() {
  group('FormySelectorState tests', () {
    late FieldController controller;

    setUp(() {
      controller = FieldController(key: 'field1');
      FormyFormManager.instance.forceReset();
    });

    testWidgets('initializes _value and inserts FieldController',
        (tester) async {
      final widget = TestFormySelector(
        controller: controller,
        selector: (ctrl) => ctrl.key,
        child: (value) => Text(value, textDirection: TextDirection.ltr),
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      expect(FormyFormManager.instance.fields, contains(controller.key));
      expect(find.text('field1'), findsOneWidget);
    });

    testWidgets('calls removeField on dispose', (tester) async {
      final widget = TestFormySelector(
        controller: controller,
        selector: (ctrl) => ctrl.key,
        child: (value) => Text(value, textDirection: TextDirection.ltr),
      );

      await tester.pumpWidget(MaterialApp(home: widget));
      await tester
          .pumpWidget(Container()); // removes the widget, triggers dispose

      expect(FormyFormManager.instance.fields, isNot(contains(controller.key)));
    });

    testWidgets('triggerUpdate updates the state and rebuilds', (tester) async {
      final controller =
          FieldController(key: 'field1', initialValue: 'initial');

      final widget = TestFormySelector(
        controller: controller,
        selector: (value) => value.value,
        child: (value) => Text(value, textDirection: TextDirection.ltr),
      );

      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.text('initial'), findsOneWidget);

      controller.update('updated');

      await tester.pump();

      expect(find.text('updated'), findsOneWidget);
    });
  });
}
