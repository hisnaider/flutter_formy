import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_test/flutter_test.dart';

class SpyFocusNode extends FocusNode {
  int disposeCount = 0;

  @override
  void dispose() {
    disposeCount++;
    super.dispose();
  }
}

void main() {
  testWidgets(
      'FocusableFieldBuilder: call insert, remove and adds/removes listener',
      (tester) async {
    final controller = FieldController(key: 'test');
    final String key = controller.key;
    await tester.pumpWidget(
      MaterialApp(
        home: FocusableFieldBuilder(
          field: controller,
          builder: (_, __, ___, ____) {
            return const SizedBox();
          },
        ),
      ),
    );
    expect(FormManager.instance.groups, isEmpty);
    expect(FormManager.instance.fields, isNotEmpty);
    expect(FormManager.instance.fields.containsKey(key), isTrue);
    expect(FormManager.instance.fields[key], equals(controller));
    await tester.pumpWidget(const SizedBox());
    expect(FormManager.instance.groups, isEmpty);
    expect(FormManager.instance.fields, isEmpty);
  });
  testWidgets(
      'FocusableFieldBuilder: build with initial state and updates on tap',
      (tester) async {
    final controller = FieldController<String>(
      key: 'test',
      validators: [IsRequired()],
      showErrorWhen: ShowError.always,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FocusableFieldBuilder(
            field: controller,
            builder: (context, field, focus, child) {
              return TextFormField(
                focusNode: focus,
                onChanged: (value) => field.update(value),
                initialValue: field.value,
                decoration: InputDecoration(errorText: field.firstError),
              );
            },
          ),
        ),
      ),
    );
    expect(find.text(GenericValidators.isRequired.name), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'test');
    await tester.pump();
    expect(find.text('test'), findsOneWidget);
    expect(
        find.byWidgetPredicate(
          (widget) => widget is TextFormField && widget.forceErrorText == null,
        ),
        findsOneWidget);
  });
  testWidgets('FocusableFieldBuilder: render child', (tester) async {
    final controller = FieldController<String>(
      key: 'test',
      validators: [IsRequired()],
      showErrorWhen: ShowError.always,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FocusableFieldBuilder(
            field: controller,
            child: const Text('Label'),
            builder: (context, field, focus, child) {
              return Column(
                children: [
                  child!,
                  TextFormField(
                    focusNode: focus,
                    onChanged: (value) => field.update(value),
                    initialValue: field.value,
                    decoration: InputDecoration(errorText: field.firstError),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
    expect(find.text('Label'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'test');
    await tester.pump();
    expect(find.text('Label'), findsOneWidget);
  });
  testWidgets('FocusableFieldBuilder: use provided FocusNode', (tester) async {
    final controller = FieldController<String>(key: 'test');
    final focusNode = SpyFocusNode();

    FocusNode? builderFocusNode;

    await tester.pumpWidget(
      MaterialApp(
        home: FocusableFieldBuilder<String>(
          field: controller,
          focusNode: focusNode,
          builder: (context, field, fn, child) {
            builderFocusNode = fn;
            return const SizedBox();
          },
        ),
      ),
    );

    // Garante que o mesmo focusNode foi usado
    expect(builderFocusNode, same(focusNode));
  });

  testWidgets('FocusableFieldBuilder: dispose provided FocusNode once',
      (tester) async {
    final controller = FieldController<String>(key: 'test');
    final focusNode = SpyFocusNode();

    await tester.pumpWidget(
      MaterialApp(
        home: FocusableFieldBuilder<String>(
          field: controller,
          focusNode: focusNode,
          builder: (context, field, fn, child) => const SizedBox(),
        ),
      ),
    );

    await tester.pumpWidget(const SizedBox()); // remove
    expect(focusNode.disposeCount, equals(1));
  });

  testWidgets('FocusableFieldBuilder: creates only one FocusNode',
      (tester) async {
    final controller = FieldController<String>(key: 'test');

    late FocusNode firstFocusNode;

    await tester.pumpWidget(
      MaterialApp(
        home: FocusableFieldBuilder<String>(
          field: controller,
          builder: (context, field, fn, child) {
            firstFocusNode = fn;
            return const SizedBox();
          },
        ),
      ),
    );

    // Força rebuild
    await tester.pumpWidget(
      MaterialApp(
        home: FocusableFieldBuilder<String>(
          field: controller,
          builder: (context, field, fn, child) {
            // Deve ser o mesmo focusNode
            expect(fn, same(firstFocusNode));
            return const SizedBox();
          },
        ),
      ),
    );
  });
}
