import 'package:flutter/material.dart';
import 'package:flutter_formy/flutter_formy.dart';

enum ListenerLifecycle {
  manual,
  autoDispose,
}

class AdditionalListener<T extends ChangeNotifier> {
  AdditionalListener({
    T? listenerType,
    this.createListener,
    required this.onListen,
    this.lifecycle = ListenerLifecycle.manual,
  }) : _listenerType = listenerType;

  final T Function()?
      createListener; // Função que cria o listener, se necessário
  final void Function(T listener, FieldController controller) onListen;
  final ListenerLifecycle lifecycle;

  T? _listenerType;
  VoidCallback? _callback;

  T get listener {
    _listenerType ??= createListener!.call();
    return _listenerType!;
  }

  void attach(FieldController controller, State state) {
    _callback = () {
      if (!state.mounted) return;
      onListen(listener, controller);
    };
    listener.addListener(_callback!);
  }

  void detach() {
    if (_callback != null) {
      listener.removeListener(_callback!);
      _callback = null;
    }
    if (lifecycle == ListenerLifecycle.autoDispose) {
      listener.dispose();
    }
  }
}
