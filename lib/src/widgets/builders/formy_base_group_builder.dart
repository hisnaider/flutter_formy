import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';
import 'package:flutter_formy/src/models/group_state.dart';

abstract class FormyBaseGroupBuilder extends StatefulWidget {
  const FormyBaseGroupBuilder({
    super.key,
    required this.groupFields,
    this.buildWhen,
    required this.buidChild,
  });
  final GroupFields groupFields;
  final Function(GroupState oldState, GroupState currentState)? buildWhen;
  final Widget Function(Widget builder) buidChild;

  Widget builder(
      BuildContext context,
      VoidCallback touchAndValidateAllFields,
      VoidCallback resetAll,
      GroupState groupState,
      Map<String, dynamic> values);

  @override
  State<FormyBaseGroupBuilder> createState() => _FormyBaseGroupBuilderState();
}

class _FormyBaseGroupBuilderState extends State<FormyBaseGroupBuilder> {
  late GroupState _oldState;
  int numberOfRebuilds = 0;

  @override
  void initState() {
    super.initState();
    _oldState = widget.groupFields.state;
    widget.groupFields.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return widget.buidChild(widget.builder(
      context,
      widget.groupFields.touchAndValidateAllFields,
      widget.groupFields.resetAll,
      widget.groupFields.state,
      widget.groupFields.values,
    ));
  }

  void _debugLog() {
    assert(() {
      final key = widget.groupFields.groupKey;
      debugPrint(
          '\n\x1B[36m[GroupFields: $key]==================Rebuild number $numberOfRebuilds\x1B[0m');
      debugPrint('wasValidated: ${widget.groupFields.state.wasValidated}');
      debugPrint('errorMessages: ${widget.groupFields.state.errorMessages}');
      debugPrint(
          'firstErrorFieldKey: ${widget.groupFields.state.firstErrorFieldKey}\x1B[0m');

      if (widget.groupFields.state.isValid) {
        debugPrint('\x1B[32mValid\x1B[0m');
      } else {
        debugPrint('\x1B[31mInvalid\x1B[0m');
      }
      debugPrint('\x1B[36m[GroupFields: $key]==================\x1B[0m\n');
      return true;
    }());
  }

  void _listener() {
    final shouldRebuild =
        widget.buildWhen?.call(_oldState, widget.groupFields.state) ?? true;
    _debugLog();
    _oldState = widget.groupFields.state;
    if (mounted && shouldRebuild) {
      setState(() {});
      numberOfRebuilds++;
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.groupFields.removeListener(_listener);
  }
}
