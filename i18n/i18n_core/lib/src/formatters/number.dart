import 'package:intl/intl.dart';

// ------------------------------ VARIABLES -----------------------------
/// Simple number formatter.
final NumberFormat _simpleNumberFormatter = NumberFormat.decimalPattern();

/// Simple number with sign formatter.
NumberFormat? _signedNumberFormatter;

// ------------------------------ FUNCTIONS -----------------------------
String formatNumber({
  required num number,
  int? decimalPlacesCount,
  bool includeSign = false,
}) {
  if (_signedNumberFormatter == null) {
    final decimalPattern = _simpleNumberFormatter.symbols.DECIMAL_PATTERN;
    final plusSign = _simpleNumberFormatter.symbols.PLUS_SIGN;
    final minusSign = _simpleNumberFormatter.symbols.MINUS_SIGN;
    final pattern = '$plusSign$decimalPattern;$minusSign$decimalPattern';
    _signedNumberFormatter = NumberFormat(pattern);
  }

  if (decimalPlacesCount == null) {
    return includeSign
        ? _signedNumberFormatter!.format(number)
        : _simpleNumberFormatter.format(number);
  }

  final decimalPattern = _simpleNumberFormatter.symbols.DECIMAL_PATTERN;
  final f = decimalPattern.substring(0, decimalPattern.indexOf('.') + 1);
  final formatBuffer = StringBuffer(f);
  for (var i = 0; i < decimalPlacesCount; i++) {
    formatBuffer.write('0');
  }

  final format = formatBuffer.toString();
  return includeSign
      ? NumberFormat('+$format;-$format').format(number)
      : NumberFormat(format).format(number);
}
