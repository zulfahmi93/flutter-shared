import 'package:clock/clock.dart';
import 'package:timeago/timeago.dart';

import 'formatters/formatters.dart';
import 'localisation.dart';

extension SimpleLocalisationStringExtensions on String {
  /// Gets the localised text of the current [String].
  String get l10n => SimpleLocalisation.instance.get(this);
}

extension SimpleLocalisationNumExtensions on num {
  /// Gets the formatted text of the current [num].
  String format({int? decimalPlacesCount, bool includeSign = false}) {
    return formatNumber(
      number: this,
      decimalPlacesCount: decimalPlacesCount,
      includeSign: includeSign,
    );
  }
}

extension SimpleLocalisationDateTimeExtensions on DateTime {
  /// Gets the date component (only year, month and day) of the current
  /// [DateTime].
  DateTime get date {
    return DateTime(year, month, day);
  }

  /// Gets the formatted date and time with seconds string of the current
  /// [DateTime].
  String get dateTimeWithSecondsFormattedString {
    return formatDate(
      dateTime: this,
      includeTime: true,
      includeSeconds: true,
    );
  }

  /// Gets the formatted date and time string of the current [DateTime].
  String get dateTimeFormattedString {
    return formatDate(
      dateTime: this,
      includeTime: true,
      includeSeconds: false,
    );
  }

  /// Gets the formatted date string of the current [DateTime].
  String get dateFormattedString {
    return formatDate(
      dateTime: this,
      includeTime: false,
      includeSeconds: false,
    );
  }

  /// Gets the formatted time with seconds string of the current [DateTime].
  String get timeWithSecondsFormattedString {
    return formatTime(dateTime: this, includeSeconds: true);
  }

  /// Gets the formatted time string of the current [DateTime].
  String get timeFormattedString {
    return formatTime(dateTime: this, includeSeconds: false);
  }

  /// Gets the full day of week string of the current [DateTime].
  String get dayOfWeekString {
    return getDayOfWeek(dateTime: this, long: true);
  }

  /// Gets the abbreviated day of week string of the current [DateTime].
  String get abbrDayOfWeekString {
    return getDayOfWeek(dateTime: this, long: false);
  }

  /// Gets the formatted date and time string of the current [DateTime].
  String get relativeTimeString {
    return format(this, clock: clock.now());
  }
}

extension SimpleLocalisationDurationExtensions on Duration {
  /// Gets only the week component of the current [Duration].
  int get weeks {
    return getWeekComponent(this);
  }

  /// Gets only the day component of the current [Duration].
  int get days {
    return getDayComponent(this);
  }

  /// Gets only the hour component of the current [Duration].
  int get hours {
    return getHourComponent(this);
  }

  /// Gets only the minute component of the current [Duration].
  int get minutes {
    return getMinuteComponent(this);
  }

  /// Gets only the second component of the current [Duration].
  int get seconds {
    return getSecondComponent(this);
  }

  /// Gets only the millisecond component of the current [Duration].
  int get milliseconds {
    return getMillisecondComponent(this);
  }
}
