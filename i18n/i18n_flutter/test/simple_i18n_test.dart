import 'package:test/test.dart';
import 'package:simple_i18n/simple_i18n.dart';

void main() {
  group('Localisations', () {
    test(
      'StateError should be thrown when localisation is not initialised',
      () {
        expect(() => L.get('Test'), throwsA(TypeMatcher<StateError>()));
        expect(() => L.supportedLocales, throwsA(TypeMatcher<StateError>()));
      },
    );
    test(
      'StateError should be thrown when default language is not include in the '
      'list of supported languages',
      () {
        expect(
          () => _initialiseLocalisation(defaultLanguage: 'az'),
          throwsA(TypeMatcher<StateError>()),
        );
      },
    );

    test('get should return "Test" for default locale', () {
      _initialiseLocalisation();
      expect('Test', L.get('Test'));
    });
    test('get should return "Cubaan" for ms locale', () {
      _initialiseLocalisation();
      SimpleLocalisation.instance.changeLanguage('ms');
      expect('Cubaan', L.get('Test'));
    });
    test(
      'changeLanguage should throw UnsupportedError when changing to an'
      'unsupported language',
      () {
        _initialiseLocalisation();
        expect(
          () => L.changeLanguage('az'),
          throwsA(TypeMatcher<UnsupportedError>()),
        );
      },
    );
    test('get should return "Test 2" for ms locale (non-debug)', () {
      _initialiseLocalisation();
      L.changeLanguage('ms');
      expect('Test 2', L.get('Test 2'));
    });
    test('get should return "LOCALISE THIS!" for ms locale (debug)', () {
      _initialiseLocalisation(debug: true);
      SimpleLocalisation.instance.changeLanguage('ms');
      expect('LOCALISE THIS!', L.get('Test 2'));
    });
  });
}

void _initialiseLocalisation({
  String defaultLanguage = 'en',
  bool debug = false,
}) {
  L.initialise(
    defaultLanguage: defaultLanguage,
    supportedLanguages: ['en', 'ms', 'fr'],
    localisationData: {
      'Test': LocalisationEntry(
        data: {
          'en': 'Test',
          'ms': 'Cubaan',
        },
      ),
    },
    isDebug: debug,
  );
}
