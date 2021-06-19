import 'dart:math';

extension IterableExtensions<T> on Iterable<T>? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}

extension NumIterableExtensions<T extends num> on Iterable<T> {
  T get maximum {
    if (isEmpty) {
      return 0 as T;
    }

    if (length == 1) {
      return elementAt(0);
    }

    return reduce(max);
  }

  T get minimum {
    if (isEmpty) {
      return 0 as T;
    }

    if (length == 1) {
      return elementAt(0);
    }

    return reduce(min);
  }
}
