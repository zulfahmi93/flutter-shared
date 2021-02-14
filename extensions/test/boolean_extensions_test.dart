import 'package:test/test.dart';
import 'package:simple_extensions/simple_extensions.dart';

void main() {
  group('Boolean Extensions', () {
    _testYesNo();
    _testYesNoUnknown();
  });
}

void _testYesNo() {
  group('yesNo Property Extension', () {
    test('yesNo should returns Yes', () {
      expect(true.yesNo, 'Yes');
    });
    test('yesNo should returns No', () {
      expect(false.yesNo, 'No');
    });
  });
}

void _testYesNoUnknown() {
  group('yesNoUnknown Property Extension', () {
    test('yesNoUnknown should returns Yes', () {
      expect(true.yesNoUnknown, 'Yes');
    });
    test('yesNoUnknown should returns No', () {
      expect(false.yesNoUnknown, 'No');
    });
    test('yesNoUnknown should returns Unknown', () {
      expect(null.yesNoUnknown, 'Unknown');
    });
  });
}
