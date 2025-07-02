import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: must_be_immutable
class MockFormyBuilder extends FormyBuilder<FieldController, FieldState> {
  MockFormyBuilder(
      {super.key, required super.field, super.buildWhen, super.child});
  int addListenerCount = 0;
  int removeListenerCount = 0;
  int buildCount = 0;

  @override
  State<StatefulWidget> createState() => _MockFormyBuilder();
}

class _MockFormyBuilder
    extends FormyBuilderState<FieldController, FieldState, MockFormyBuilder> {
  @override
  void addListener() {
    widget.addListenerCount++;
    widget.field.addListener(triggerUpdate);
  }

  @override
  Widget build(BuildContext context) {
    widget.buildCount++;
    return widget.child ?? const SizedBox.shrink();
  }

  @override
  FieldState getState() => widget.field.state;

  @override
  void removeListener() {
    widget.removeListenerCount++;
    widget.field.removeListener(triggerUpdate);
  }
}

void main() {
  testWidgets('FormyBuilder: life cycle test', (tester) async {
    final FieldController controller = FieldController(key: 'test');
    final String key = controller.key;
    final MockFormyBuilder mock = MockFormyBuilder(
      field: controller,
    );
    expect(FormManager.instance.groups, isEmpty);
    expect(FormManager.instance.fields, isEmpty);
    expect(FormManager.instance.fields.containsKey(key), isFalse);
    expect(FormManager.instance.fields[key], isNot(equals(controller)));
    expect(mock.addListenerCount, equals(0));
    expect(mock.removeListenerCount, equals(0));
    await tester.pumpWidget(MaterialApp(home: mock));
    expect(FormManager.instance.groups, isEmpty);
    expect(FormManager.instance.fields, isNotEmpty);
    expect(FormManager.instance.fields.containsKey(key), isTrue);
    expect(FormManager.instance.fields[key], equals(controller));
    expect(mock.addListenerCount, equals(1));
    expect(mock.removeListenerCount, equals(0));
    await tester.pumpWidget(Container());
    expect(FormManager.instance.groups, isEmpty);
    expect(FormManager.instance.fields, isEmpty);
    expect(FormManager.instance.fields.containsKey(key), isFalse);
    expect(FormManager.instance.fields[key], isNot(equals(controller)));
    expect(mock.addListenerCount, equals(1));
    expect(mock.removeListenerCount, equals(1));
  });
  testWidgets('FormyBuilder: buildWhen != null', (tester) async {
    final FieldController controller = FieldController(key: 'test');
    final MockFormyBuilder mock = MockFormyBuilder(
      field: controller,
      buildWhen: (oldState, currentState) =>
          oldState.value != currentState.value,
    );
    await tester.pumpWidget(MaterialApp(home: mock));
    expect(mock.buildCount, equals(1));
    controller.update(null);
    await tester.pump();
    expect(mock.buildCount, equals(1));
    controller.update('');
    await tester.pump();
    expect(mock.buildCount, equals(2));
    controller.update('');
    await tester.pump();
    expect(mock.buildCount, equals(2));
    controller.update('a');
    await tester.pump();
    controller.update('b');
    await tester.pump();
    expect(mock.buildCount, equals(4));
  });
  testWidgets('FormyBuilder: buildWhen == null', (tester) async {
    final FieldController controller = FieldController(key: 'test');
    final MockFormyBuilder mock = MockFormyBuilder(
      field: controller,
    );
    await tester.pumpWidget(MaterialApp(home: mock));
    expect(mock.buildCount, equals(1));
    controller.update(null);
    await tester.pump();
    expect(mock.buildCount, equals(2));
    controller.update('');
    await tester.pump();
    expect(mock.buildCount, equals(3));
    controller.update('a');
    await tester.pump();
    controller.update('a');
    await tester.pump();
    expect(mock.buildCount, equals(4));
  });
  testWidgets('FormyBuilder: should render child', (tester) async {
    const Widget child = Text('should render this widget');
    final FieldController controller = FieldController(key: 'test');
    final MockFormyBuilder mock = MockFormyBuilder(
      field: controller,
      child: child,
    );
    await tester.pumpWidget(MaterialApp(home: mock));
    expect(find.byType(Text), findsOneWidget);
    expect(find.text('should render this widget'), findsOneWidget);
  });
}
