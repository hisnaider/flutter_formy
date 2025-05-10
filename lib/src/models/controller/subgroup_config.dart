part of 'field_controller.dart';

class SubGroupConfig {
  SubGroupConfig({
    required this.key,
    this.dependsOn = const [],
    required this.fields,
    this.subGroups = const [],
  });
  final String key;
  final List<DependsOn> dependsOn;
  final List<FieldConfig> fields;
  final List<SubGroupConfig> subGroups;
}

class DependsOn {
  const DependsOn({
    required this.fieldKey,
    required this.enabledWhen,
  });
  final String fieldKey;
  final bool Function(FieldController controller) enabledWhen;
}
