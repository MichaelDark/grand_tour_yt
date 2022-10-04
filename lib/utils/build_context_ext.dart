import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  T getArgs<T>() {
    final modaRoute = ModalRoute.of(this)!;
    final args = modaRoute.settings.arguments as T;
    return args;
  }

  /// Copied from [AppBar]
  Color resolveAppBarColor() {
    Color resolveColor(Color? themeColor, Color defaultColor) {
      return MaterialStateProperty.resolveAs<Color?>(themeColor, {}) ??
          MaterialStateProperty.resolveAs<Color>(defaultColor, {});
    }

    final context = this;
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final defaultBackgroundColor = theme.useMaterial3
        ? theme.colorScheme.surface
        : (colors.brightness == Brightness.dark
            ? colors.surface
            : colors.primary);
    return resolveColor(appBarTheme.backgroundColor, defaultBackgroundColor);
  }
}
