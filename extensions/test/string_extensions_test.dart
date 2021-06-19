import 'package:test/test.dart';
import 'package:simple_extensions/simple_extensions.dart';

void main() {
  group('String Extensions', _testIsNullOrWhiteSpace);
}

void _testIsNullOrWhiteSpace() {
  group('isNullOrWhiteSpace Extension Property', () {
    test('should returns true', () {
      final String? s = null;
      expect(s.isNullOrWhiteSpace, true);
      expect(''.isNullOrWhiteSpace, true);
      expect(' '.isNullOrWhiteSpace, true);
    });
    test('should returns false', () {
      expect('Not Empty'.isNullOrWhiteSpace, false);
    });
  });
}
