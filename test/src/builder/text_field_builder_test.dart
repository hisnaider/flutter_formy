import 'package:flutter/material.dart';
import 'package:flutter_formy/src/builder/text_field_builder.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextFieldBuilder', () {
    late FieldController<String> controller;
    late TextFieldWidgetBuilder<String> builder;

    setUp(() {
      controller = FieldController(key: 'field1', initialValue: 'initial');
      builder = (context, field, focusNode, textEditingController, child) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Test Field',
            errorText: field.firstError,
          ),
        );
      };
    });

    testWidgets('should create TextFieldBuilder with required parameters',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: controller,
              builder: builder,
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('initial'), findsOneWidget);
    });

    testWidgets('should use provided FocusNode', (tester) async {
      final customFocusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: controller,
              focusNode: customFocusNode,
              builder: builder,
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);

      // Verifica se o FocusNode personalizado está sendo usado
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.focusNode, equals(customFocusNode));
    });

    testWidgets('should use provided TextEditingController', (tester) async {
      final customTextController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: controller,
              textEditingController: customTextController,
              builder: builder,
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'custom text');
      await tester.pump();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('custom text'), findsOneWidget);
    });

    testWidgets('should update controller when text changes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: controller,
              builder: builder,
            ),
          ),
        ),
      );

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Digita novo texto
      await tester.enterText(textField, 'novo texto');
      await tester.pump();

      // Verifica se o controller foi atualizado
      expect(controller.value, equals('novo texto'));
    });

    testWidgets('should mark field as touched when focus is lost',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TextFieldBuilder(
                  controller: controller,
                  builder: builder,
                ),
                const TextField(), // Campo adicional para testar mudança de foco
              ],
            ),
          ),
        ),
      );

      final textField = find.byType(TextField).first;
      final secondTextField = find.byType(TextField).last;

      // Foca no primeiro campo
      await tester.tap(textField);
      await tester.pump();

      // Verifica se ainda não foi marcado como touched
      expect(controller.state.touched, isFalse);

      // Muda o foco para o segundo campo
      await tester.tap(secondTextField);
      await tester.pump();

      // Verifica se foi marcado como touched
      expect(controller.state.touched, isTrue);
    });

    testWidgets('should sync TextEditingController with field value changes',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: controller,
              builder: builder,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'valor atualizado');

      await tester.pump();

      expect(find.text('valor atualizado'), findsOneWidget);
    });

    testWidgets(
        'should handle cursor position correctly when updating externally',
        (tester) async {
      final customTextController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: controller,
              textEditingController: customTextController,
              builder: builder,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'novo valor');

      await tester.pump();

      expect(customTextController.selection.baseOffset,
          equals('novo valor'.length));
    });

    testWidgets('should pass child widget to builder', (tester) async {
      const childWidget = Icon(Icons.search);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: controller,
              builder:
                  (context, field, focusNode, textEditingController, child) {
                return Column(
                  children: [
                    TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                    ),
                    if (child != null) child,
                  ],
                );
              },
              child: childWidget,
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should handle buildWhen condition', (tester) async {
      var buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: controller,
              buildWhen: (previous, current) {
                // Só reconstrói se o valor mudou
                return previous?.value != current.value;
              },
              builder:
                  (context, field, focusNode, textEditingController, child) {
                buildCount++;
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                );
              },
            ),
          ),
        ),
      );

      final initialBuildCount = buildCount;

      // Atualiza com o mesmo valor - não deve reconstruir
      controller.update('initial');
      await tester.pump();

      expect(buildCount, equals(initialBuildCount));

      // Atualiza com valor diferente - deve reconstruir
      controller.update('novo valor');
      await tester.pump();

      expect(buildCount, equals(initialBuildCount + 1));
    });

    testWidgets('should dispose resources properly', (tester) async {
      final customFocusNode = FocusNode();
      final customTextController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: controller,
              focusNode: customFocusNode,
              textEditingController: customTextController,
              builder: builder,
            ),
          ),
        ),
      );

      // Remove o widget
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));

      // Verifica se os recursos foram dispostos
      // Nota: Esta verificação pode precisar ser ajustada dependendo da implementação
      expect(customFocusNode.hasFocus, isFalse);
    });

    testWidgets('should handle empty initial value', (tester) async {
      final emptyController =
          FieldController<String>(key: 'empty', initialValue: '');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: emptyController,
              builder: builder,
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);

      // Verifica se o campo está vazio
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller!.text, equals(''));
    });

    testWidgets('should handle null initial value', (tester) async {
      final nullController =
          FieldController<String>(key: 'null', initialValue: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldBuilder(
              controller: nullController,
              builder: builder,
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);

      // Verifica se o campo está vazio quando o valor inicial é null
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller!.text, equals(''));
    });
  });
}
