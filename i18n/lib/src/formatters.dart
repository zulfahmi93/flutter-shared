import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Formatters {
  // ------------------------------- FIELDS -------------------------------
  /// Simple number formatter.
  final _simpleNumberFormatter = NumberFormat('#');

  /// Simple number with sign formatter.
  final _signedNumberFormatter = NumberFormat('+#;-#');

  // ------------------------------- METHODS ------------------------------
  String formatNumber({
    @required num number,
    int decimalPlacesCount,
    bool includeSign = false,
  }) {
    assert(number != null);
    assert(includeSign != null);

    if (decimalPlacesCount == null) {
      return includeSign
          ? _signedNumberFormatter.format(number)
          : _simpleNumberFormatter.format(number);
    }

    final formatBuffer = StringBuffer('0.');
    for (var i = 0; i < decimalPlacesCount; i++) {
      formatBuffer.write('0');
    }

    final format = formatBuffer.toString();
    return includeSign
        ? NumberFormat('+$format;-$format').format(number)
        : NumberFormat(format).format(number);
  }
}
