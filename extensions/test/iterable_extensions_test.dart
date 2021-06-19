import 'package:test/test.dart';
import 'package:simple_extensions/simple_extensions.dart';

void main() {
  group('Iterable<T> Extensions', _testIsNullOrEmpty);
}

void _testIsNullOrEmpty() {
  group('isNullOrEmpty Extension Property', () {
    test('should returns true', () {
      final Iterable? i = null;
      expect(i.isNullOrEmpty, true);
      expect([].isNullOrEmpty, true);
    });
    test('should returns false', () {
      expect([1].isNullOrEmpty, false);
    });
  });
}
