import 'package:flutter/material.dart';
import 'package:flutter_formy/src/controller/field_controller.dart';

/// A base widget for building forms using the Formy system.
///
/// The [FormyForm] provides a structure for creating forms with
/// automatic integration to a [GroupController]. It encapsulates the
/// initialization and lifecycle of the controller, so that developers
/// only need to define the form fields and build the UI.
///
/// This class is abstract and should be extended by concrete forms.
/// Subclasses must implement [fields] and [formBody], and can optionally
/// override [groupKey] to provide a custom identifier.
///
/// ## Lifecycle
///
/// * On creation, a [GroupController] is initialized with the form's
///   [fields] and the unique [groupKey].
/// * The controller is then passed to [formBody], which is responsible
///   for rendering the form UI.
/// * On disposal (`dispose`), the [GroupController] is automatically
///   disposed to free up resources.
///
/// ## Properties
///
/// * [fields]: A list of [FieldConfig] that defines the structure and
///   behavior of each field in the form.
/// * [groupKey]: A unique identifier for the form group. Defaults to the
///   current timestamp in microseconds. Override if deterministic keys
///   are required.
/// * [formBody]: A function that builds the form UI. It receives:
///   * `context`: The [BuildContext] from the widget tree.
///   * `controller`: The [GroupController] managing the form state.
///
/// ## Example
/// ```dart
///  class LoginForm extends FormyForm {
///    const LoginForm({super.key});
///
///    @override
///    List<FieldConfig> fields() => [
///      FieldConfig(key: 'email', validators: [EmailValidator(), IsRequired()]),
///      FieldConfig(key: 'password', validators: [MinLengthValidator(6), IsRequired()]),
///    ];
///
///    @override
///    Widget formBody(BuildContext context, GroupController controller) {
///      return Column(
///        children: [
///          FormyTextField(controller: controller.field('email')),
///          FormyTextField(controller: controller.field('password')),
///          ElevatedButton(
///            onPressed: controller.isValid ? () => print('is valid') : null,
///            child: const Text('Login'),
///          ),
///        ],
///      );
///    }
///  }
/// ```
///
/// ## See also
///
/// * [GroupController], which manages the state of a group of fields.
/// * [FieldConfig], which describes the configuration of a single field.
abstract class FormyForm extends StatefulWidget {
  const FormyForm({super.key});

  List<FieldConfig> fields();
  String groupKey() => DateTime.now().microsecondsSinceEpoch.toString();

  Widget formBody(BuildContext context, GroupController controller);

  @override
  State<FormyForm> createState() => _FormyFormState();
}

class _FormyFormState extends State<FormyForm> {
  late final GroupController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GroupController(
      key: widget.groupKey(),
      fields: widget.fields(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.formBody(context, _controller);
  }
}
