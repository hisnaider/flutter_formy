part of 'field_controller.dart';

class FieldConfig<T> {
  const FieldConfig({
    required this.key,
    this.validators = const [],
    this.initialValue,
    this.showErrorWhen = ShowError.whenIsTouched,
  });
  final String key;
  final List<FormyValidator<T>> validators;
  final T? initialValue;
  final ShowError showErrorWhen;

  FieldController<T> _initField(GroupController group) =>
      FieldController<T>._internal(
          key, initialValue, showErrorWhen, validators, group);
}

class FieldListConfig<T> extends FieldConfig<List<T>> {
  FieldListConfig({
    required super.key,
    super.initialValue,
    super.validators,
    super.showErrorWhen,
  });

  @override
  FieldListController<T> _initField(GroupController group) =>
      FieldListController._internal(
          key, initialValue, showErrorWhen, validators, group);
}
