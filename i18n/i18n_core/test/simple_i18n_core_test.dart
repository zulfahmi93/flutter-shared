import 'package:clock/clock.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';
import 'package:simple_i18n_core/simple_i18n_core.dart';
import 'package:timeago/timeago.dart';

final dateOnly = DateTime(2020, 10, 1);
final dateTime = DateTime(2020, 10, 1, 15, 30, 29, 567, 344);

void main() {
  SimpleLocalisation.initialise(
    defaultLanguage: 'en',
    supportedLanguages: ['en', 'ms'],
    localisationData: {
      'Test': LocalisationEntry(
        data: {
          'en': 'Test',
          'ms': 'Cubaan',
        },
      ),
    },
  );
  _testLocalisation();
  _testFormatters();
}

void _testLocalisation() {
  test('l10n', () {
    SimpleLocalisation.instance.changeLanguage('ms');
    expect('Cubaan', 'Test'.l10n);
  });
}

void _testFormatters() {
  group('Formatters', () {
    _testNumberFormatter();
    _testDateFormatter();
  });
}

void _testNumberFormatter() {
  test('formatNumber', () {
    final num = 10.934934934;
    expect(num.format(), '10.935');
    expect(num.format(decimalPlacesCount: 9), '10.934934934');
    expect(num.format(includeSign: true), '+10.935');
    expect(
      num.format(
        decimalPlacesCount: 4,
        includeSign: true,
      ),
      '+10.9349',
    );
  });
}

void _testDateFormatter() {
  group('description', () {
    test('formatDate', () {
      final num = 10.934934934;
      expect(num.format(), '10.935');
      expect(num.format(decimalPlacesCount: 9), '10.934934934');
      expect(num.format(includeSign: true), '+10.935');
      expect(
        num.format(
          decimalPlacesCount: 4,
          includeSign: true,
        ),
        '+10.9349',
      );
    });
  });
}

void _testDate() {
  group('date Property Extension', () {
    test('date should returns only the date component', () {
      expect(dateOnly, dateTime.date);
    });
  });
}

void _testDateTimeFormattedString() {
  group('dateTimeFormattedString Property Extension', () {
    test('dateTimeFormattedString should returns 01 Oct 2020 3:30 PM', () {
      expect(dateTime.dateTimeFormattedString, '01 Oct 2020 3:30 PM');
    });
    test('dateTimeFormattedString should returns 01 Okt 2020 3:30 PTG', () {
      initializeDateFormatting('ms');
      Intl.defaultLocale = 'ms';
      expect(dateTime.dateTimeFormattedString, '01 Okt 2020 3:30 PTG');
      Intl.defaultLocale = null;
    });
  });
}

void _testDateFormattedString() {
  group('dateFormattedString Property Extension', () {
    test('dateFormattedString should returns 01 Oct 2020', () {
      expect(dateTime.dateFormattedString, '01 Oct 2020');
    });
    test('dateFormattedString should returns 01 Okt 2020', () {
      initializeDateFormatting('ms');
      Intl.defaultLocale = 'ms';
      expect(dateTime.dateFormattedString, '01 Okt 2020');
      Intl.defaultLocale = null;
    });
  });
}

void _testRelativeTimeString() {
  group('relativeTimeString Property Extension', () {
    test('relativeTimeString should returns 24 days ago', () {
      withClock(Clock.fixed(DateTime(2020, 10, 26)), () {
        expect(dateTime.relativeTimeString, '24 days ago');
      });
    });
    test('relativeTimeString should returns 24 hari lepas', () {
      withClock(Clock.fixed(DateTime(2020, 10, 26)), () {
        setLocaleMessages('ms', MsMyMessages());
        setDefaultLocale('ms');
        expect(dateTime.relativeTimeString, '24 hari lepas');
        setDefaultLocale('en');
      });
    });
  });
}
