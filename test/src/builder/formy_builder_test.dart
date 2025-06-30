import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/controller/field_controller.dart';
import 'package:flutter_formy/src/models/field_instace_management/form_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFormyBuilder extends FormyBuilder<FieldController, FieldState> {
  MockFormyBuilder(
      {super.key, required super.field, super.buildWhen, super.child});

  bool insertCalled = false;
  bool removeCalled = false;
  int addListenerCount = 0;
  int removeListenerCount = 0;
  int buildCount = 0;

  @override
  State<StatefulWidget> createState() => _MockFormyBuilder();

  @override
  void insertIntoFormManager() {
    insertCalled = !insertCalled;
  }

  @override
  void removeFromFormManager() {
    removeCalled = !removeCalled;
  }
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
    final MockFormyBuilder mock = MockFormyBuilder(
      field: controller,
    );
    await tester.pumpWidget(MaterialApp(home: mock));
    expect(mock.insertCalled, isTrue);
    expect(mock.addListenerCount, equals(1));
    await tester.pump();
    expect(mock.insertCalled, isTrue);
    expect(mock.addListenerCount, equals(1));

    await tester.pumpWidget(Container());
    expect(mock.removeCalled, isTrue);
    expect(mock.removeListenerCount, equals(1));
    await tester.pump();
    expect(mock.insertCalled, isTrue);
    expect(mock.addListenerCount, equals(1));
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



/*


/*

Perfeito 👏
Esse FormyBuilder e seu FormyBuilderState são o core framework do seu sistema de formulários. Eles não fazem UI diretamente — são responsáveis por gerenciar:

lifecycle (initState, dispose)

adicionar/remover listeners

controlar quando rebuilda com buildWhen

garantir que chama insertIntoFormManager e removeFromFormManager

Portanto, os testes para eles precisam ser focados no comportamento estrutural e no contrato do ciclo de vida, não em UI.

🚀 Lista de testes para o FormyBuilder e FormyBuilderState
Vou te passar o que testar e como testar, sem código, só descritivo, bem organizado.

✅ 1. Testes de lifecycle: initState e dispose
O que testar
Ao montar o widget:

chama insertIntoFormManager

chama addListener

Ao desmontar (dispose):

chama removeListener

chama removeFromFormManager

Como testar
Monte um widget fake baseado no FormyBuilder (ex: FakeFieldBuilder) que sobrescreva insertIntoFormManager, removeFromFormManager, addListener e removeListener.

Use variáveis (bool ou contador) ou um mock para verificar se esses métodos foram chamados na ordem correta.

✅ 2. Teste do buildWhen: decide quando rebuildar
O que testar
Se buildWhen retornar false, não chama setState (logo, não rebuilda).

Se buildWhen retornar true, chama setState e rebuilda.

Como testar
Monte o widget passando um buildWhen customizado que você consegue controlar (ex: fecha para false no primeiro e true depois).

Use um contador para saber quantas vezes o build foi chamado (ex: incrementa numa variável local).

Dispare o triggerUpdate() e confira se o número de rebuilds está correto.

✅ 3. Teste do oldState: atualiza corretamente o snapshot antigo
O que testar
Quando triggerUpdate roda, se buildWhen permitir rebuild, o oldState passa a refletir o novo estado.

Como testar
Use um mock ou FieldController / GroupController com estado modificável.

Chame triggerUpdate e verifique que o oldState mudou para o novo getState().

✅ 4. Testes gerais do contrato do FormyBuilderState
O que testar
addListener é sempre chamado uma única vez no initState, não em rebuilds.

removeListener é sempre chamado uma única vez no dispose.

O widget.child é repassado corretamente para build.

Como testar
Use contadores dentro do addListener e removeListener.

Monte, force rebuild (ex: trocando Key) e confira se não re-chama addListener.

Desmonte e verifique que chama removeListener uma única vez.

✅ 5. Teste de regressão para triggerUpdate
O que testar
Chamar triggerUpdate duas vezes seguidas só faz rebuild se o buildWhen deixar.

Se o estado não mudou, o buildWhen pode bloquear o rebuild.

Como testar
Mude o estado do controller controladamente e chame triggerUpdate diversas vezes.

Conte quantos rebuilds ocorreram.

✅ 6. Teste para garantir contrato do FormManager
O que testar
insertIntoFormManager é chamado sempre no initState.

removeFromFormManager sempre no dispose.

Como testar
Faça um mock do FormManager que capture chamadas para insert e remove.

Monte e desmonte o widget, verificando se foi chamado exatamente uma vez em cada.

💡 Extra: testes que não precisa fazer aqui
✅ Não precisa testar foco, markAsTouched, etc — isso pertence ao FocusableFieldBuilder.
✅ Não precisa testar o FormManager em si aqui — ele só precisa ser chamado. Os testes unitários do FormManager devem estar separados.

✅ Resumo final dos testes do FormyBuilder
Categoria	O que confirmar
🚀 Lifecycle	Chama insertIntoFormManager, addListener, removeListener, removeFromFormManager no tempo certo
⚖ Controle de rebuild	Respeita buildWhen: só rebuilda quando deve
🔁 Estado anterior	oldState é atualizado corretamente após rebuild
🧩 Child e builder	Repassa child e chama builder como esperado

🎯 Próximo passo se quiser:
Posso montar pra você um roteiro de casos de teste (tipo “Gherkin style”), para você depois converter em código, ou já um esqueleto de arquivo .dart com todos esses testes anotados como test('...', () {...});.
Só dizer! 🚀

*/


*/