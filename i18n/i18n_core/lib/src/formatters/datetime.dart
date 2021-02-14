import 'package:intl/intl.dart';

// ------------------------------ VARIABLES -----------------------------
/// Date formatter.
final DateFormat _dateFormatter = DateFormat.yMMMd();

/// Date & time formatter.
final DateFormat _dateTimeFormatter = DateFormat.yMMMd().add_jm();

/// Date & time with seconds formatter.
final DateFormat _dateTimeWithSecondsFormatter = DateFormat.yMMMd().add_jms();

/// Time formatter.
final DateFormat _timeFormatter = DateFormat.jm();

/// Time with seconds formatter.
final DateFormat _timeWithSecondsFormatter = DateFormat.jms();

/// Day of week formatter.
final DateFormat _shortDayOfWeekFormatter = DateFormat.E();

/// Day of week formatter.
final DateFormat _longDayOfWeekFormatter = DateFormat.EEEE();

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
