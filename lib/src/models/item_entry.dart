import 'package:flutter/material.dart';

class ItemEntry<T> {
  const ItemEntry({
    required this.value,
    required this.text,
    this.enabled = true,
  });
  final T value;
  final Widget text;
  final bool enabled;
}
