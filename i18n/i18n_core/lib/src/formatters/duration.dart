/// Gets the week component of the given [duration].
int getWeekComponent(Duration duration) {
  return (duration.inDays / 7).floor();
}

/// Gets the day component of the given [duration].
int getDayComponent(Duration duration) {
  return duration.inDays;
}

/// Gets the hour component of the given [duration].
int getHourComponent(Duration duration) {
  return duration.inHours - (duration.inDays * Duration.hoursPerDay);
}

/// Gets the minute component of the given [duration].
int getMinuteComponent(Duration duration) {
  return duration.inMinutes - (duration.inHours * Duration.minutesPerHour);
}

/// Gets the second component of the given [duration].
int getSecondComponent(Duration duration) {
  return duration.inSeconds - (duration.inMinutes * Duration.secondsPerMinute);
}

/// Gets the millisecond component of the given [duration].
int getMillisecondComponent(Duration duration) {
  return duration.inMilliseconds -
      (duration.inSeconds * Duration.millisecondsPerSecond);
}
