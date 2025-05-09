import 'package:flutter/material.dart';

class ItemEntry<T> {
  const ItemEntry({
    required this.value,
    required this.text,
    this.enabled = true,
    this.child,
  });
  final T value;
  final Widget text;
  final bool enabled;
  final Widget? child;
}
