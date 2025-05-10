part of 'field_controller.dart';

class FieldConfig<T> {
  const FieldConfig({
    required this.key,
    this.validators = const [],
    this.initialValue,
    this.showErrorWhen = ShowError.whenIsTouched,
    this.dependsOn = const [],
  });
  final String key;
  final List<FormyValidator<T>> validators;
  final T? initialValue;
  final ShowError showErrorWhen;
  final List<String> dependsOn;

  FieldController<T> _initField(GroupController group) =>
      FieldController<T>._internal(
          key, initialValue, showErrorWhen, validators, dependsOn, group);
}

class FieldListConfig<T> extends FieldConfig<List<T>> {
  FieldListConfig({
    required super.key,
    super.initialValue,
    super.validators,
    super.showErrorWhen,
    super.dependsOn,
  });

  @override
  FieldListControl<T> _initField(GroupController group) =>
      FieldListControl._internal(
          key, initialValue, showErrorWhen, validators, dependsOn, group);
}
