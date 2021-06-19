import 'package:test/test.dart';
import 'package:simple_extensions/simple_extensions.dart';
import 'package:simple_i18n_core/simple_i18n_core.dart';

void main() {
  _init();
  group('Boolean Extensions', () {
    _testYesNo();
    _testYesNoUnknown();
  });
}

void _init() {
  SimpleLocalisation.initialise(
    defaultLanguage: 'en',
    supportedLanguages: ['en', 'ms'],
    localisationData: extensionsLocalisationEntries,
    isDebug: false,
  );
}

void _testYesNo() {
  group('yesNo Extension Property', () {
    test('should returns Yes', () {
      SimpleLocalisation.instance.changeLanguage('en');
      expect(true.yesNo, 'Yes');
    });
    test('should returns No', () {
      SimpleLocalisation.instance.changeLanguage('en');
      expect(false.yesNo, 'No');
    });
    test('should returns Ya', () {
      SimpleLocalisation.instance.changeLanguage('ms');
      expect(true.yesNo, 'Ya');
    });
    test('should returns Tidak', () {
      SimpleLocalisation.instance.changeLanguage('ms');
      expect(false.yesNo, 'Tidak');
    });
  });
}

void _testYesNoUnknown() {
  group('yesNoUnknown Extension Property', () {
    test('should returns Yes', () {
      SimpleLocalisation.instance.changeLanguage('en');
      expect(true.yesNoUnknown, 'Yes');
    });
    test('should returns No', () {
      SimpleLocalisation.instance.changeLanguage('en');
      expect(false.yesNoUnknown, 'No');
    });
    test('should returns Unknown', () {
      SimpleLocalisation.instance.changeLanguage('en');
      expect(null.yesNoUnknown, 'Unknown');
    });
    test('should returns Ya', () {
      SimpleLocalisation.instance.changeLanguage('ms');
      expect(true.yesNo, 'Ya');
    });
    test('should returns Tidak', () {
      SimpleLocalisation.instance.changeLanguage('ms');
      expect(false.yesNo, 'Tidak');
    });
    test('should returns Tidak Diketahui', () {
      SimpleLocalisation.instance.changeLanguage('ms');
      expect(null.yesNoUnknown, 'Tidak Diketahui');
    });
  });
}
