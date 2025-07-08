import 'package:flutter/material.dart';
import 'package:flutter_formy/src/manager/form_manager.dart';
import 'package:flutter_formy/src/builder/formy_builder.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';
import 'package:flutter_formy/src/models/field_state.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: must_be_immutable
class MockFormyBuilder extends FormyBuilder<FieldController, FieldState> {
  MockFormyBuilder(
      {super.key, required super.controller, super.buildWhen, super.child});
  int buildCount = 0;

  @override
  State<StatefulWidget> createState() => _MockFormyBuilder();
}

class _MockFormyBuilder
    extends FormyBuilderState<FieldController, FieldState, MockFormyBuilder> {
  @override
  Widget build(BuildContext context) {
    widget.buildCount++;
    return widget.child ?? const SizedBox.shrink();
  }

  @override
  FieldState getState() => widget.controller.state;
}

void main() {
  testWidgets('FormyBuilder: life cycle test', (tester) async {
    final FieldController controller = FieldController(key: 'test');
    final String key = controller.key;
    final MockFormyBuilder mock = MockFormyBuilder(
      controller: controller,
    );
    expect(FormyFormManager.instance.groups, isEmpty);
    expect(FormyFormManager.instance.fields, isEmpty);
    expect(FormyFormManager.instance.fields.containsKey(key), isFalse);
    expect(FormyFormManager.instance.fields[key], isNot(equals(controller)));
    await tester.pumpWidget(MaterialApp(home: mock));
    expect(FormyFormManager.instance.groups, isEmpty);
    expect(FormyFormManager.instance.fields, isNotEmpty);
    expect(FormyFormManager.instance.fields.containsKey(key), isTrue);
    expect(FormyFormManager.instance.fields[key], equals(controller));
    await tester.pumpWidget(Container());
    expect(FormyFormManager.instance.groups, isEmpty);
    expect(FormyFormManager.instance.fields, isEmpty);
    expect(FormyFormManager.instance.fields.containsKey(key), isFalse);
    expect(FormyFormManager.instance.fields[key], isNot(equals(controller)));
  });
  testWidgets('FormyBuilder: buildWhen != null', (tester) async {
    final FieldController controller = FieldController(key: 'test');
    final MockFormyBuilder mock = MockFormyBuilder(
      controller: controller,
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
      controller: controller,
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
      controller: controller,
      child: child,
    );
    await tester.pumpWidget(MaterialApp(home: mock));
    expect(find.byType(Text), findsOneWidget);
    expect(find.text('should render this widget'), findsOneWidget);
  });
}
