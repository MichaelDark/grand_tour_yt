import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  T getArgs<T>() {
    final modaRoute = ModalRoute.of(this)!;
    final args = modaRoute.settings.arguments as T;
    return args;
  }
}
