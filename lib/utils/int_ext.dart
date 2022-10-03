import 'dart:math';

extension IntExt on int {
  String formatCount([int decimals = 2]) {
    const k = 1000;
    final dm = decimals < 0 ? 0 : decimals;
    const sizes = ['', 'K', 'M', 'B', 'T', 'Q'];

    final i = (log(this) / log(k)).floor();
    final text = (this / pow(k, i)).toStringAsFixed(dm);
    final digit = sizes[i];

    return '$text$digit';
  }
}
