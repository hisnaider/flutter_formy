# Formy

ATENÇÃO: O package esta em fase beta. Ele esta funcional, mas tem alguns pontos a ser melhorado pra melhorar a experiencia do desenvolvedor.

# **Sobre o Formy:**

Formy é uma biblioteca robusta para gerenciamento de formulários em Flutter. Ela simplifica a criação, o controle e a validação de formulários, oferecendo uma abordagem reativa que mantém a interface sincronizada com o estado dos campos em tempo real. Com Formy, você pode construir formulários complexos de forma organizada, reutilizável e fácil de manter, aproveitando recursos como controle granular de estado, validação customizada e construção dinâmica dos campos.

# **Instalando:**

Adicione o Formy no arquivo pubspec.yaml

```yaml
dependencies:
	formy:
```

# Criando um formulário:

Pra criar um formulário é preciso usar a classe `GroupController`. Nele a gente define a `key` e os campos (`fields`):

```dart
final GroupController group = GroupController(
	key: 'login',
  fields: [
   FieldConfig<String>(key: 'email', validators: [IsRequired(), IsRequired()]),
   FieldConfig<String>(key: 'password', validators: [IsRequired(), MinValidator(6)]),
  ],
);
```

Depois de definir, crie o widget pro formulário, deixe o visual como quiser. Pra usar os campos definidos no `fields`, é preciso usar um widget FieldBuilder (exemplo: FormyTextField):

```dart
FormyTextField(
	fieldController: loginGroup.field('email'),
	decoration: (fieldState, firstError) => InputDecoration(
		hintText: 'Digite seu E-mail',
		labelText: 'E-mail',
		errorText: firstError,
	),
),
FormyTextField(
	fieldController: loginGroup.field('password'),
	decoration: (fieldState, firstError) => InputDecoration(
		hintText: 'Digite sua senha',
		labelText: 'Senha',
		errorText: firstError,
	),
),
```

Pra fazer um botão que reaja as mudanças do `GroupController`, é preciso usar um widget `GroupSelector`:

```dart
GroupSelector(
	control: group ,
	selector: (group) => group.state.isValid,
	child: (value) => ElevatedButton(
		onPressed: value
		? () {
			debugPrint('Fazer login');
		}
		: null,
		child: const Text('Entrar'),
	),
),
```

# Recursos:

- Validação automática e customizável
- Agrupamento de campos via `FieldGroup`
- Validação reativa e baseada em contexto
- Geração dinâmica de campos com `FormSchema` (em breve)
- Gerenciamento escopado com `FormyScope` (em breve)

# Validadores (`FormyValidator`):

Os validadores servem pra validar os campos. Um campo pode ter de 1 a any validadores. Toda vez que o valor é atualizado, os validadores vão ser chamados. Após a validação, ele retorna a classe `ValidationResult` que contem a key do validador e uma flag determinando se é ou não valido.

O package já vem com alguns validadores ja definidos pra usar, são eles:

- `IsRequired`: Valida se o campo não esta vazio ou null;
- `EmailValidator`: Valida se o valor do campo é um email;
- `MaxValidator`: Valida se o tamanho do campo, seja String ou List, ultrapassou um limite **maximo** definido;
- `MinValidator`: Valida se o tamanho do campo, seja String ou List, ultrapassou um limite **mínimo** definido;
- `MustMatchValidator`: Valida se dois campos são iguais.

Observação: Mais validadores vão vir, esses são apena os primeiros.

### Criando um validador customizado

Para criar um validador o processo é muito facil. Primeiro crie uma classe, depois estenda ela de `FormyValidator` e pronto. O método `onValidate` é obrigatório e é ele que vai fazer a validação.

Criar um validador no Formy é simples. Basta criar uma classe que estenda `FormyValidator` e implementar o método `onValidate`, responsável por verificar se o valor do campo é válido ou não.

Exemplo: validador de número de telefone no padrão E.164 (ex: +14155552671)

```dart
class PhoneNumberValidator extends FormyValidator<String> {
  final String message;
  PhoneNumberValidator({
    super.message = 'Número de telefone inválido (ex: +14155552671)',
  });

  @override
  ValidationResult onValidate(FieldController<String> control) {
    final value = control.value?.trim();
    final phoneRegex = RegExp(r'^\+[1-9]\d{1,14}$');
    if (!phoneRegex.hasMatch(value)) {
      return ValidationResult.error(key:'phoneValidator',message:message);
    }

    return ValidationResult.ok(key:'phoneValidator');
  }
}
```

Observação: A key no `ValidationResult` serve pra identificar de qual validador esta vindo o resultado, muito útil pra debug.

# Controlador de campo (`FieldController`):

O `FieldController`  serve pra controlar um campo. Ele gerencia os status, o valor, validações e outra informações sobre o campo. Todo `FieldController` tem uma `key`, que vai ser usado pra encontrar o campo certo dentro de um `GroupController`. As propriedades do `FieldController` são:

- `key`: Chave de identificação do campo;
- `validators`: Lista de validadores (`FormyValidator`);
- `initialValue`: Valor inicial do campo, quando não definido o valor inicial é null;
- `showErrorWhen`: Defini quando mostrar o erro. O valor é um enum(`ShowError`) e tem 3 opções
    - `never`: Nunca mostrar;
    - `whenIsTouched`: Quando o status `touched` for verdadeiro (valor padrão);
    - `always`: Mostrar o erro logo em seguida que tiver um erro;

```dart
final email = FieldController<String>(
      key: 'email',
      validators: [IsRequired(), EmailValidator()],
    );
```

Observação: 

- A `key` não pode conter “/”, esse caractere separa a key do campo da key do grupo em que ele esta;
- Alguns validadores funcionam apenas com um tipo de valor (exemplo o EmailValidator, só funciona com String). Importante definir o tipo do campo no parâmetro genérico;
- Quando um FieldController esta fora de um GroupController, ele é considerado um campo independente.

Uma limitação do `FieldController` é não permitir o uso de valores do tipo List, nesse caso o `FieldListControl` deve ser usado.

Além das propriedades, `FieldController` tem alguns métodos quem podem ser usados fora da classe, são eles:

- `validate`: Valida todos os campos (ele é chamado automaticamente quando o valor é modificado);
- `update`: Atualiza o valor do campo e marca como `dirty` (pra identificar se já foi modificado). Quando construir um widget de campo (`FieldBuilder`), é preciso usar esse método pra atualizar o valor do campo;
- `markAsDirty`: Marca o campo como `dirty` manualmente;
- `markAsTouched`: Marca o campo como `touched` manualmente. No `FieldBuilder` é preciso chamar ele caso queira e/ou precise dessa informação;
- `reset`: Reseta o valor do campo pro valor inicial;
- `updateValidators`: Atualiza a lista de validadores. Útil campo trabalhar com internacionalização e tem um campo em que a validação muda dependendo do pais;
- Os método `get` são:
    - `groupRef`: Pega o group (`GroupController`) que ele faz parte;
    - `completeKey`: Pega a key completa do campo (key do group + key do campo);
    - `value`: Pega o valor do campo;
    - `validationResults`: Pega a lista de resultados de validações (`ValidationResult`), util pra debug;
    - `state`: Pega a classe de estado do campo (`FieldState`);
    - `isRequired`: Pega um booleano que identifica se o campo é obrigatório ou não. Isso é determinado pelo uso do validador `IsRequired` na lista de validadores;
    - `firstError`: Pega a mensagem do primeiro `ValidationResult` não valido;
    - `errorKeys`: Pega todas as keys dos `ValidationResult` não validos, util pra debug;
    - `errorMessages`: Pega todas as mensagens dos `ValidationResult` não validos;
    - `valid`: Pega um booleanos que identifica se o campo é valido, ou seja, quando todos o `ValidationResult` forem validos;

## Controlador de campo do tipo lista (`FieldListControl`):

O `FieldListControl` tem as mesmas propriedade e métodos do `FieldController` , mas deve ser usado apenas em campos com valores do tipo List. Essa classe possui 3 métodos exclusivos, são eles:

- `addItem`: Adiciona um item no valor do campo;
- `removeItem`: Remove um item no valor do campo;
- `moveItem`: Move um item do valor de posição;

```dart
final interests = FieldListControl(
      key: 'interests',
      validators: [IsRequired(), MinValidator(5), MaxValidator(10)],
    );
```

## Estado do campo (`FieldState`):

Esse é o estado do `FieldListControl`. O `FieldState` tem as propriedades:

- `value`: Valor do campo;
- `validationResults`: Resultado das validações do campo (lista de `ValidationResult`);
- `dirty`: Determina se o campo foi modificado;
- `touched`: Determina se o campo foi tocado:
- `obscure`: Determina se o valor deve ser mostrado;

# Controlador de grupo (`GroupController`)

O `GroupController`  serve pra controlar um grupo de campos. Ele gerencia os status, validações e dependências dos campos. Todo `GroupController` tem uma `key`, que serve pra encontrar o grupo no `FormManager` (será removido futuramente). As propriedades do `GroupController` são:

- `key`: Chave de identificação do grupo;
- `fields`: Lista de FieldConfig;
    - `FieldConfig` serve pra instanciar `FieldController` dentro do grupo. Ele tem as mesmas propriedades do `FieldController` + `dependsOn`, que serve pra determinar quais campos (`key` dos campos), do mesmo grupo, esse campo é dependente;
- `subGroups`: Lista de `SubGroupConfig`.
    - `SubGroupConfig` serve pra instanciar `GroupController` como subgrupo dentro do grupo (grupos aninhados). Ele tem as mesmas propriedade do `GroupController` + `dependsOn`, que serve pra determinar quais campos, do mesmo grupo principal, esse subgrupo é dependente. `dependsOn` é do tipo `DependsOn`, que tem as propriedades:
        - `fieldKey`: chave do campo que o subgrupo é dependente;
        - `enabledWhen`: Função que contem um `FieldController`, referente ao `FieldController` da `key` mencionado na propriedade `fieldKey`, como parâmetro e retorna um booleano indicando se o subgrupo deve ou não ser ativo. Quando ativo, ele entra na lista de validações do grupo principal. Quando desativo, o grupo principal pode ser valido independente do subgrupo e seus validadores.

```dart
final GroupController group = GroupController(
      key: 'community',
      fields: [
        FieldConfig<String>(key: 'name', validators: [IsRequired()]),
        FieldConfig<String>(key: 'email', validators: [IsRequired()]),
        FieldConfig<bool>(key: 'addAddress')
      ],
      subGroups: [
        SubGroupConfig(
          key: 'address',
          dependsOn: [
            DependsOn(
                fieldKey: 'addAddress',
                enabledWhen: (FieldController controller) {
                  return controller.state.value == true;
                })
          ],
          fields: [
            FieldConfig<String>(
                key: 'country', validators: [IsRequired()]),
            FieldConfig<String>(key: 'state', validators: [IsRequired()]),
            FieldConfig<String>(key: 'city', validators: [IsRequired()]),
            FieldConfig<String>(key: 'street'),
          ],
        ),
      ],
    );
```

Observação: 

- A `key` não pode conter “/”, esse caractere separa a `key` do subgrupo da `key` do grupo principal;
- Os subgrupos são `GroupController`, isso faz com que eles tenham as mesmas propriedades e métodos do grupo principal.

`GroupController` tem uma lista de métodos muito uteis pra trabalhar, são eles:

- `getAllFields`: Pega todos o `FieldController` do grupo;
- `field`: Pega um campo especifico do grupo usando a `key` do campo;
- `subGroup`: Pega um subgrupo especifico do grupo usando a `key` do subgrupo
- `findFieldByCompleteKey`: Pega um campo especifico dentro do grupo aninhado. Se usar por exemplo ‘address/country’, ele vai pegar o campo de key ‘country’ que esta no subgrupo de key ‘address’;
- `findSubGroupByCompleteKey`: Função semelhante ao `findFieldByCompleteKey`, mas invés de pegar um campo, ele pega um subgrupo dentro do grupo aninhado;
- `getFormData`: Retorna os valores dos campos do grupo e dos campos dos subgrupos formatados em um map. Util pra quando precisa transformar os valores do grupo em uma entidade;
- `resetAll`: Reseta os valores dos campos do grupo pros seus valores iniciais;
- `setInitialValues`: Define os valores atuais como valores iniciais dos campos do grupos e seus subgrupos. Útil pra quando tem um formulário que após ser salvo, se torna apenas pra leitura;
- `touchAndValidateAllFields`: Define todos os campos do grupo e de seus subgrupos como `touched` e valida eles;
- `dispose`: Remove todos os listeners dentro do grupo, útil pra não vazar memoria. Esse método é chamado automaticamente após o grupo não ser mais usado.
- Os método `get` são:
    - `parentGroup`: Pega o grupo que ele faz parte. No grupo principal o método retorna null;
    - `completeKey`: Retoda a key completa do subgrupo (key do grupo princial + key do subgrupo). No grupo principal retorna apenas a `key` dele;
    - `state`: Pega a classe de estado do grupo(`GroupState`);

## Estado do grupo(`GroupState`)

Esse é o estado do `GroupController`. O `GroupState` tem as propriedades:

- `isEnabled`: Determina se o grupo esta ativo;
- `isValid`: Determina se o grupo esta valido;
- `wasValidated`: Determina se o grupo foi validado uma vez;
- `errorMessages`: Todos os erros dos campos do grupo:
- `firstErrorField`: A mensagem do primeiro erro do primeiro campo não valido do grupo;
- `validCount`: Numero de campos validos no grupo.

# Criando um widget customizado

Com o Formy é possível criar os mais variados tipos de campos para o formulário, campo de texto, dropdown, checkbox, radio, qualquer tipo, apenas usando o widget `FieldBuilder`. `FieldBuilder` é um widget poderoso na criação de campos customizados e com poucas propriedades:

- `field`: O `FieldController` que o widget vai manipular;
- `buildWhen`: Uma função que determina quando o widget deve sofrer rebuild. Quando `null`, ele vai sofrer rebuild com qualquer atualização do `FieldController`. A função possui dois parâmetros:
    - `oldState`: Estado antigo do `FieldController`;
    - `currentState`: Estado atual do `FieldController`;
- `child`: Serve como um widget fixo ou estático. Ele não vai sofrer rebuild quando o estado do `FieldController` mudar;
- `builder`: É uma função obrigatória que define como renderizar a UI com base no estado do `FieldController`, sendo o principal ponto de personalização visual. Ele tem 3 parâmetros:
    - `context`: `BuildContext` do widget na árvore Flutter;
    - `field`: `FieldController` que vai manipular;
    - `child`: Widget fixo definido na propriedade `child` do `FieldBuilder`.

```dart
class ColorDotPickerField extends FieldBuilder<Color> {
  ColorDotPickerField({
    super.key,
    required super.field,
    super.buildWhen,
    this.colors = const [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
    ],
    this.size = 32,
    this.spacing = 8,
  }) : super(
          builder: (context, field, child) {
            return Wrap(
              spacing: spacing,
              children: colors.map((color) {
                final isSelected = field.value == color;
                return GestureDetector(
                  onTap: () => field.update(color),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 3)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        );

  final List<Color> colors;
  final double size;
  final double spacing;
}
```

Observações:

- Além do `FieldBuilder`, o Formy possui o `FocusableFieldBuilder`. É um widget que estende de `FieldBuilder` e tem a mesma funcionalidade do `FieldBuilder`, mas focado em campos em que o foco é importante. Ele tem a propriedade `focusNode`, que é do tipo `FocusNode`. Essa propriedade é passado pro `builder` como parâmetro.

```dart
// Um campo de texto simples que estende de FocusableFieldBuilder
class SimpleTextInput extends FocusableFieldBuilder {
  final String? label;
  final String? hintText;
  SimpleTextInput ({
    super.key,
    required super.field,
    this.label,
    this.hintText,
  }) : super(
          builder: (context, field, focusNode, child) {
            return TextFormField(
              initialValue: field.initialValue,
              onChanged: field.update,
              focusNode: focusNode,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                label: Text(label ?? 'Label'),
                errorText: field.firstError,
                hintText: hintText,
              ),
            );
          },
        );
}
```

## Widgets já prontos

Aqueles campos mais usados, mais comuns, já foram criados no Formy pra aumentar sua produtividade. Abaixo esta os campos: 

- `FormyTextField`: É um `TextFormField` adaptado pro Formy;
- `FormyDropdown`: É um `DropdownMenu` adaptado pro Formy;
- `FormyCheckbox`: É um `Checkbox` adaptado pro Formy;
- `FormyListCheckbox`: Serve pra criar uma lista de `Checkbox`. A propriedade `itemsEntry` define o texto e o valor do checkbox, e `layout` define como vai ficar organizado a lista. Com a propriedade `layout` é possivel organizar os checkbox em linhas, colunas, wrap, do jeito que você quiser;
    
    ```dart
    //Exemplo de um FormyListCheckbox
    
    List<String> packagesName = [
    	'Formy', 'Get', 'Dartz', 'Equatable', 'Bloc', 'Slang', 'Dio',
    ];
    return FormyListCheckbox<String>(
    	fieldController: group.field('favoritePackages'),
    	title: Text('Your favorite packages (min 2, max 5)'),
    	itemsEntry: packagesName.map((e) => 
    		ItemEntry(value: e, text: Text(e))).
    		toList(),
    	layout: (List<Widget> children) => Wrap(
    		runSpacing: 5,
    		spacing: 5,
    		children: children,
    	),
    ),
    ```
    
- `FormyRadio`: Serve pra criar uma lista de `Radio`. Tem as mesmas propriedades do `FormyListCheckbox`;

Observações:

- Todos esses widgets possuem um campo `fieldController`, é obrigatório pra qualquer widget que utilize `FieldBuilder`;
- Mais campos já prontos vai ser criado em atualizações futuras.

Só com esses widgets já é possível criar um formulário, mas se acha que precisa de um detalhe a mais, você pode criar um widget e usar eles como usa qualquer outro widget.

```dart
// Exemplo de um widget que usa um widget de campo do Formy

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.fieldController,
    this.label,
    this.hintText,
    this.maxLines,
  });
  final FieldController<String> fieldController;
  final String? label;
  final String? hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label ?? 'Text field'),
        FormyTextField(
          fieldController: fieldController,
          maxLines: maxLines,
          decoration: (FieldState<dynamic> fieldState, String? firstError) =>
              InputDecoration(errorText: firstError, hintText: hintText),
        )
      ],
    );
  }
}
```
