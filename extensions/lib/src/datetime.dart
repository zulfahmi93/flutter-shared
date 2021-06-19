import 'package:clock/clock.dart';
import 'package:simple_i18n_core/simple_i18n_core.dart';

extension DateTimeExtensions on DateTime {
  int get age {
    final endDate = clock.now().date.add(Duration(days: 1));
    final years = endDate.year - year;

    if (month > endDate.month) {
      return years - 1;
    }
    if (month == endDate.month) {
      if (day > endDate.day) {
        return years - 1;
      }
    }
    return years;
  }
}
