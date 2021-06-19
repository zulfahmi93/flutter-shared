import 'package:clock/clock.dart';
import 'package:test/test.dart';
import 'package:simple_extensions/simple_extensions.dart';

final dateTime = DateTime(1993, 10, 1, 15, 30, 29, 567, 344);

void main() {
  group('DateTime Extensions', () {
    test('age extension property should returns 26', () {
      final newClock = Clock.fixed(DateTime(2020, 6, 19));
      final actual = withClock(newClock, () {
        return dateTime.age;
      });
      expect(actual, 26);
    });
  });
}
