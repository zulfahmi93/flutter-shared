import 'package:clock/clock.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';
import 'package:simple_i18n_core/simple_i18n_core.dart';
import 'package:timeago/timeago.dart';

final dateOnly = DateTime(2020, 10, 1);
final dateTime = DateTime(2020, 10, 1, 15, 30, 29, 567, 344);
final duration = Duration(
  days: 8,
  hours: 12,
  minutes: 36,
  seconds: 22,
  milliseconds: 233,
  microseconds: 125,
);

void main() {
  _testLocalisation();
  _testFormatters();
}

void _initialiseLocalisation({
  String defaultLanguage = 'en',
  bool debug = false,
}) {
  SimpleLocalisation.initialise(
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

void _testLocalisation() {
  group('Localisations', () {
    test(
      'StateError should be thrown when localisation is not initialised',
      () {
        expect(() => 'Test'.l10n, throwsA(TypeMatcher<StateError>()));
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

    test('l10n extension method should return "Test" for default locale', () {
      _initialiseLocalisation();
      expect('Test', 'Test'.l10n);
    });
    test('l10n extension method should return "Cubaan" for ms locale', () {
      _initialiseLocalisation();
      SimpleLocalisation.instance.changeLanguage('ms');
      expect('Cubaan', 'Test'.l10n);
    });
    test(
      'changeLanguage should throw UnsupportedError when changing to an'
      'unsupported language',
      () {
        _initialiseLocalisation();
        expect(
          () => SimpleLocalisation.instance.changeLanguage('az'),
          throwsA(TypeMatcher<UnsupportedError>()),
        );
      },
    );
    test(
      'l10n extension method should return "Test 2" for ms locale (non-debug)',
      () {
        _initialiseLocalisation();
        SimpleLocalisation.instance.changeLanguage('ms');
        expect('Test 2', 'Test 2'.l10n);
      },
    );
    test(
      'l10n extension method should return "LOCALISE THIS!" for ms locale '
      '(debug)',
      () {
        _initialiseLocalisation(debug: true);
        SimpleLocalisation.instance.changeLanguage('ms');
        expect('LOCALISE THIS!', 'Test 2'.l10n);
      },
    );
  });
}

void _testFormatters() {
  group('Formatters', () {
    _testNumberFormatter();
    _testDateFormatter();
    _testDurationFormatter();
  });
}

void _testNumberFormatter() {
  group('Number Formatter', () {
    final num = 10.934934934;
    test(
      'format() extension method should returns 10.935 for default locale',
      () {
        expect(num.format(), '10.935');
      },
    );
    test(
      'format() extension method should returns 10,935 fr locale',
      () {
        Intl.defaultLocale = 'fr';
        expect(num.format(), '10.935');
        Intl.defaultLocale = null;
      },
    );
    test(
      'format() extension method should returns 10.934934934 default locale',
      () {
        expect(num.format(decimalPlacesCount: 9), '10.934934934');
      },
    );
    test(
      'format() extension method should returns +10.935 default locale',
      () {
        expect(num.format(includeSign: true), '+10.935');
      },
    );
    test(
      'format() extension method should returns +10.9349 default locale',
      () {
        expect(
            num.format(decimalPlacesCount: 4, includeSign: true), '+10.9349');
      },
    );
  });
}

void _testDateFormatter() {
  group('Date Formatter', () {
    _testDate();
    _testDateTimeWithSecondsFormattedString();
    _testDateTimeFormattedString();
    _testDateFormattedString();
    _testTimeWithSecondsFormattedString();
    _testTimeFormattedString();
    _testDayOfWeekString();
    _testAbbrDayOfWeekString();
    _testRelativeTimeString();
  });
}

void _testDurationFormatter() {
  group('Duration Formatter', () {
    _testWeeks();
    _testDays();
    _testHours();
    _testMinutes();
    _testSeconds();
    _testMilliseconds();
  });
}

void _testDate() {
  test('date extension property should returns only the date component', () {
    expect(dateOnly, dateTime.date);
  });
}

void _testDateTimeWithSecondsFormattedString() {
  group('dateTimeWithSecondsFormattedString Extension Property', () {
    test('should returns Oct 1, 2020 3:30:29 PM for default locale', () {
      expect(
        dateTime.dateTimeWithSecondsFormattedString,
        'Oct 1, 2020 3:30:29 PM',
      );
    });
    test('should returns 1 Okt 2020 3:30:29 PTG for ms locale', () async {
      await initializeDateFormatting('ms');
      Intl.defaultLocale = 'ms';
      expect(
        dateTime.dateTimeWithSecondsFormattedString,
        '1 Okt 2020 3:30:29 PTG',
      );
      Intl.defaultLocale = null;
    });
  });
}

void _testDateTimeFormattedString() {
  group('dateTimeFormattedString Extension Property', () {
    test('should returns Oct 1, 2020 3:30 PM for default locale', () {
      expect(dateTime.dateTimeFormattedString, 'Oct 1, 2020 3:30 PM');
    });
    test('should returns 1 Okt 2020 3:30 PTG for ms locale', () async {
      await initializeDateFormatting('ms');
      Intl.defaultLocale = 'ms';
      expect(dateTime.dateTimeFormattedString, '1 Okt 2020 3:30 PTG');
      Intl.defaultLocale = null;
    });
  });
}

void _testDateFormattedString() {
  group('dateFormattedString Extension Property', () {
    test('should returns Oct 1, 2020 for default locale', () {
      expect(dateTime.dateFormattedString, 'Oct 1, 2020');
    });
    test('should returns 1 Okt 2020 ms locale', () {
      initializeDateFormatting('ms');
      Intl.defaultLocale = 'ms';
      expect(dateTime.dateFormattedString, '1 Okt 2020');
      Intl.defaultLocale = null;
    });
  });
}

void _testTimeWithSecondsFormattedString() {
  group('timeWithSecondsFormattedString Extension Property', () {
    test('should returns 3:30:29 PM for default locale', () {
      expect(dateTime.timeWithSecondsFormattedString, '3:30:29 PM');
    });
    test('should returns 3:30:29 PTG for ms locale', () async {
      await initializeDateFormatting('ms');
      Intl.defaultLocale = 'ms';
      expect(dateTime.timeWithSecondsFormattedString, '3:30:29 PTG');
      Intl.defaultLocale = null;
    });
  });
}

void _testTimeFormattedString() {
  group('timeFormattedString Extension Property', () {
    test('should returns 3:30 PM for default locale', () {
      expect(dateTime.timeFormattedString, '3:30 PM');
    });
    test('should returns 3:30 PTG for ms locale', () async {
      await initializeDateFormatting('ms');
      Intl.defaultLocale = 'ms';
      expect(dateTime.timeFormattedString, '3:30 PTG');
      Intl.defaultLocale = null;
    });
  });
}

void _testDayOfWeekString() {
  group('dayOfWeekString Extension Property', () {
    test('should returns Thursday for default locale', () {
      expect(dateTime.dayOfWeekString, 'Thursday');
    });
    test('should returns Khamis for ms locale', () async {
      await initializeDateFormatting('ms');
      Intl.defaultLocale = 'ms';
      expect(dateTime.dayOfWeekString, 'Khamis');
      Intl.defaultLocale = null;
    });
  });
}

void _testAbbrDayOfWeekString() {
  group('abbrDayOfWeekString Extension Property', () {
    test('should returns Thu for default locale', () {
      expect(dateTime.abbrDayOfWeekString, 'Thu');
    });
    test('should returns Kha for ms locale', () async {
      await initializeDateFormatting('ms');
      Intl.defaultLocale = 'ms';
      expect(dateTime.abbrDayOfWeekString, 'Kha');
      Intl.defaultLocale = null;
    });
  });
}

void _testRelativeTimeString() {
  group('relativeTimeString Extension Property', () {
    test('should returns 24 days ago', () {
      withClock(Clock.fixed(DateTime(2020, 10, 26)), () {
        expect(dateTime.relativeTimeString, '24 days ago');
      });
    });
    test('should returns 24 hari lepas', () {
      withClock(Clock.fixed(DateTime(2020, 10, 26)), () {
        setLocaleMessages('ms', MsMyMessages());
        setDefaultLocale('ms');
        expect(dateTime.relativeTimeString, '24 hari lepas');
        setDefaultLocale('en');
      });
    });
  });
}

void _testWeeks() {
  test('weeks extension property should returns only the week component', () {
    expect(duration.weeks, 1);
  });
}

void _testDays() {
  test('days extension property should returns only the day component', () {
    expect(duration.days, 8);
  });
}

void _testHours() {
  test('hours extension property should returns only the hour component', () {
    expect(duration.hours, 12);
  });
}

void _testMinutes() {
  test(
    'minutes extension property should returns only the minute component',
    () {
      expect(duration.minutes, 36);
    },
  );
}

void _testSeconds() {
  test(
    'seconds extension property should returns only the second component',
    () {
      expect(duration.seconds, 22);
    },
  );
}

void _testMilliseconds() {
  test(
    'milliseconds extension property should returns only the millisecond '
    'component',
    () {
      expect(duration.milliseconds, 233);
    },
  );
}
