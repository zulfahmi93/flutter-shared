import 'package:test/test.dart';
import 'package:simple_extensions/simple_extensions.dart';

void main() {
  group('Map<K, V> Extensions', _testIsNullOrEmpty);
}

void _testIsNullOrEmpty() {
  group('isNullOrEmpty Extension Property', () {
    test('should returns true', () {
      final Map? m = null;
      expect(m.isNullOrEmpty, true);
      expect({}.isNullOrEmpty, true);
    });
    test('should returns false', () {
      expect({1: 1}.isNullOrEmpty, false);
    });
  });
}
