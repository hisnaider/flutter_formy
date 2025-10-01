import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/flutter_formy_generic_validators.dart';
import 'package:flutter_test/flutter_test.dart';

// Test implementation of FormyForm
class TestFormyForm extends FormyForm {
  final List<FieldConfig> testFields;
  final String? testGroupKey;
  final Widget Function(BuildContext, GroupController) testFormBody;

  const TestFormyForm({
    super.key,
    required this.testFields,
    this.testGroupKey,
    required this.testFormBody,
  });

  @override
  List<FieldConfig> fields() => testFields;

  @override
  String groupKey() => testGroupKey ?? super.groupKey();

  @override
  Widget formBody(BuildContext context, GroupController controller) {
    return testFormBody(context, controller);
  }
}

void main() {
  group('FormyForm', () {
    testWidgets('should create GroupController on initState', (tester) async {
      GroupController? capturedController;

      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testFields: const [
              FieldConfig(
                  key: 'field1', initialValue: 'value1', validators: []),
              FieldConfig(
                  key: 'field2', initialValue: 'value2', validators: []),
            ],
            testFormBody: (context, controller) {
              capturedController = controller;
              return Container();
            },
          ),
        ),
      );

      expect(capturedController, isNotNull);
      expect(capturedController!.key, isNotEmpty);
    });

    testWidgets('should use custom groupKey when provided', (tester) async {
      const customKey = 'custom_group_key';
      GroupController? capturedController;

      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testGroupKey: customKey,
            testFields: const [
              FieldConfig(key: 'field1', initialValue: '', validators: []),
            ],
            testFormBody: (context, controller) {
              capturedController = controller;
              return Container();
            },
          ),
        ),
      );

      expect(capturedController!.key, equals(customKey));
    });

    testWidgets('should generate unique groupKey when not provided',
        (tester) async {
      final capturedKeys = <String>[];

      for (int i = 0; i < 3; i++) {
        await tester.pumpWidget(
          MaterialApp(
            home: TestFormyForm(
              key: ValueKey(i),
              testFields: const [
                FieldConfig(key: 'field1', initialValue: '', validators: []),
              ],
              testFormBody: (context, controller) {
                if (!capturedKeys.contains(controller.key)) {
                  capturedKeys.add(controller.key);
                }
                return Container();
              },
            ),
          ),
        );
        await tester.pumpAndSettle();
      }
      expect(capturedKeys.length, equals(3));
      expect(capturedKeys.toSet().length, equals(3));
    });

    testWidgets('should initialize controller with provided fields',
        (tester) async {
      GroupController? capturedController;

      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testFields: const [
              FieldConfig(
                  key: 'username', initialValue: 'john', validators: []),
              FieldConfig(
                  key: 'email',
                  initialValue: 'john@example.com',
                  validators: []),
              FieldConfig<int>(key: 'age', initialValue: 25, validators: []),
            ],
            testFormBody: (context, controller) {
              capturedController = controller;
              return Container();
            },
          ),
        ),
      );
      expect(capturedController!.field('username').value, equals('john'));
      expect(
          capturedController!.field('email').value, equals('john@example.com'));
      expect(capturedController!.field<int>('age').value, equals(25));
    });

    testWidgets('should pass controller to formBody', (tester) async {
      GroupController? capturedController;

      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testFields: const [
              FieldConfig(key: 'field1', initialValue: '', validators: []),
            ],
            testFormBody: (context, controller) {
              capturedController = controller;
              return Text('Field value: ${controller.field('field1').value}');
            },
          ),
        ),
      );

      expect(capturedController, isNotNull);
      expect(find.text('Field value: '), findsOneWidget);
    });

    testWidgets('should render formBody widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testFields: const [
              FieldConfig(key: 'field1', initialValue: '', validators: []),
            ],
            testFormBody: (context, controller) {
              return const Text('Test Form Body');
            },
          ),
        ),
      );

      expect(find.text('Test Form Body'), findsOneWidget);
    });

    testWidgets('should dispose controller when widget is disposed',
        (tester) async {
      GroupController? capturedController;
      bool isDisposed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testFields: const [
              FieldConfig(key: 'field1', initialValue: '', validators: []),
            ],
            testFormBody: (context, controller) {
              capturedController = controller;
              return Container();
            },
          ),
        ),
      );

      final controller = capturedController!;
      controller.addListener(() {});

      await tester.pumpWidget(const MaterialApp(home: SizedBox()));

      try {
        controller.notifyListeners();
      } catch (e) {
        isDisposed = true;
      }

      expect(isDisposed, isTrue);
    });

    testWidgets('should maintain controller state during rebuild',
        (tester) async {
      GroupController? capturedController;

      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testGroupKey: 'stable_key',
            testFields: const [
              FieldConfig(
                  key: 'field1', initialValue: 'initial', validators: []),
            ],
            testFormBody: (context, controller) {
              capturedController = controller;
              return Container();
            },
          ),
        ),
      );

      final firstController = capturedController;
      firstController!.field('field1').update('updated');

      await tester.pump();

      expect(capturedController, equals(firstController));
      expect(capturedController!.field('field1').value, equals('updated'));
    });

    testWidgets('should work with empty fields list', (tester) async {
      GroupController? capturedController;

      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testFields: const [],
            testFormBody: (context, controller) {
              capturedController = controller;
              return const Text('Empty Form');
            },
          ),
        ),
      );

      expect(capturedController, isNotNull);
      expect(capturedController!.getAllFields(), isEmpty);
      expect(find.text('Empty Form'), findsOneWidget);
    });

    testWidgets('should handle field updates through controller',
        (tester) async {
      GroupController? capturedController;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return TestFormyForm(
                testFields: const [
                  FieldConfig(key: 'field1', initialValue: '', validators: []),
                ],
                testFormBody: (context, controller) {
                  capturedController = controller;
                  return Column(
                    children: [
                      Text('Value: ${controller.field('field1').value}'),
                      ElevatedButton(
                        onPressed: () {
                          controller.field('field1').update('new value');
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      );

      expect(find.text('Value: '), findsOneWidget);

      await tester.tap(find.text('Update'));
      await tester.pump();

      expect(capturedController!.field('field1').value, equals('new value'));
    });

    testWidgets('should handle validators in field configuration',
        (tester) async {
      GroupController? capturedController;

      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testFields: [
              FieldConfig(
                  key: 'email',
                  initialValue: '',
                  validators: [IsRequired()],
                  showErrorWhen: ShowError.always),
            ],
            testFormBody: (context, controller) {
              capturedController = controller;
              return Container();
            },
          ),
        ),
      );

      expect(capturedController!.field('email').valid, isFalse);
      expect(
          capturedController!.field('email').errorKeys, contains('isRequired'));

      capturedController!.field('email').update('test@example.com');
      await tester.pump();

      expect(capturedController!.field('email').valid, isTrue);
      expect(capturedController!.field('email').errorKeys, isEmpty);
    });

    testWidgets('should support multiple field types', (tester) async {
      GroupController? capturedController;

      await tester.pumpWidget(
        MaterialApp(
          home: TestFormyForm(
            testFields: const [
              FieldConfig<String>(
                  key: 'name', initialValue: 'John', validators: []),
              FieldConfig<int>(key: 'age', initialValue: 30, validators: []),
              FieldConfig<bool>(
                  key: 'active', initialValue: true, validators: []),
              FieldConfig<double>(
                  key: 'score', initialValue: 95.5, validators: []),
            ],
            testFormBody: (context, controller) {
              capturedController = controller;
              return Container();
            },
          ),
        ),
      );

      expect(capturedController!.field<String>('name').value, equals('John'));
      expect(capturedController!.field<int>('age').value, equals(30));
      expect(capturedController!.field<bool>('active').value, equals(true));
      expect(capturedController!.field<double>('score').value, equals(95.5));
    });

    testWidgets('should rebuild when controller state changes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return TestFormyForm(
                testFields: const [
                  FieldConfig<int>(
                      key: 'counter', initialValue: 0, validators: []),
                ],
                testFormBody: (context, controller) {
                  return ListenableBuilder(
                    listenable: controller.field('counter'),
                    builder: (context, child) {
                      return Column(
                        children: [
                          Text(
                              'Counter: ${controller.field<int>('counter').value}'),
                          ElevatedButton(
                            onPressed: () {
                              final current =
                                  controller.field<int>('counter').value ?? 0;
                              controller.field('counter').update(current + 1);
                            },
                            child: const Text('Increment'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      );

      expect(find.text('Counter: 0'), findsOneWidget);

      await tester.tap(find.text('Increment'));
      await tester.pump();

      expect(find.text('Counter: 1'), findsOneWidget);

      await tester.tap(find.text('Increment'));
      await tester.pump();

      expect(find.text('Counter: 2'), findsOneWidget);
    });
  });
}
