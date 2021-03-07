import 'package:intl/intl.dart';

// ------------------------------ PROPERTIES -----------------------------

/**
 * The following are defined as properties as it must be newly constructed each
 * time format request is made. The reason is so that the changes made to the
 * Intl.defaultLocale property will be reflected to the requested formatters
 * below. Otherwise, the formatters will always has en_US as their default
 * locale.
 */

/// Date formatter.
DateFormat get _dateFormatter => DateFormat.yMMMd();

/// Date & time formatter.
DateFormat get _dateTimeFormatter => DateFormat.yMMMd().add_jm();

/// Date & time with seconds formatter.
DateFormat get _dateTimeWithSecondsFormatter => DateFormat.yMMMd().add_jms();

/// Time formatter.
DateFormat get _timeFormatter => DateFormat.jm();

/// Time with seconds formatter.
DateFormat get _timeWithSecondsFormatter => DateFormat.jms();

/// Day of week formatter.
DateFormat get _shortDayOfWeekFormatter => DateFormat.E();

/// Day of week formatter.
DateFormat get _longDayOfWeekFormatter => DateFormat.EEEE();

// ------------------------------ FUNCTIONS -----------------------------
String formatDate({
  required DateTime dateTime,
  bool includeTime = false,
  bool includeSeconds = false,
}) {
  return includeTime
      ? includeSeconds
          ? _dateTimeWithSecondsFormatter.format(dateTime)
          : _dateTimeFormatter.format(dateTime)
      : _dateFormatter.format(dateTime);
}

String formatTime({required DateTime dateTime, bool includeSeconds = false}) {
  return includeSeconds
      ? _timeWithSecondsFormatter.format(dateTime)
      : _timeFormatter.format(dateTime);
}

String getDayOfWeek({required DateTime dateTime, bool long = true}) {
  return long
      ? _longDayOfWeekFormatter.format(dateTime)
      : _shortDayOfWeekFormatter.format(dateTime);
}
