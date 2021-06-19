import 'dart:convert';

import 'package:simple_extensions/simple_extensions.dart';

final _alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

final _email = RegExp(
  r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
);
final _creditCard = RegExp(
  r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
);

final _surrogatePairsRegExp = RegExp(r'[\uD800-\uDBFF][\uDC00-\uDFFF]');

final _ipv4Maybe = RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
final _ipv6 = RegExp(
  r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$',
);

final _isbn10Maybe = RegExp(r'^(?:[0-9]{9}X|[0-9]{10})$');
final _isbn13Maybe = RegExp(r'^(?:[0-9]{13})$');

final _threeDigit = RegExp(r'^\d{3}$');
final _fourDigit = RegExp(r'^\d{4}$');
final _fiveDigit = RegExp(r'^\d{5}$');
final _sixDigit = RegExp(r'^\d{6}$');
final _postalCodePatterns = {
  'AD': RegExp(r'^AD\d{3}$'),
  'AT': _fourDigit,
  'AU': _fourDigit,
  'BE': _fourDigit,
  'BG': _fourDigit,
  'CA': RegExp(
    r'^[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][\s\-]?\d[ABCEGHJ-NPRSTV-Z]\d$',
    caseSensitive: false,
  ),
  'CH': _fourDigit,
  'CZ': RegExp(r'^\d{3}\s?\d{2}$'),
  'DE': _fiveDigit,
  'DK': _fourDigit,
  'DZ': _fiveDigit,
  'EE': _fiveDigit,
  'ES': _fiveDigit,
  'FI': _fiveDigit,
  'FR': RegExp(r'^\d{2}\s?\d{3}$'),
  'GB': RegExp(
    r'^(gir\s?0aa|[a-z]{1,2}\d[\da-z]?\s?(\d[a-z]{2})?)$',
    caseSensitive: false,
  ),
  'GR': RegExp(r'^\d{3}\s?\d{2}$'),
  'HR': RegExp(r'^([1-5]\d{4}$)'),
  'HU': _fourDigit,
  'ID': _fiveDigit,
  'IL': _fiveDigit,
  'IN': _sixDigit,
  'IS': _threeDigit,
  'IT': _fiveDigit,
  'JP': RegExp(r'^\d{3}\-\d{4}$'),
  'KE': _fiveDigit,
  'LI': RegExp(r'^(948[5-9]|949[0-7])$'),
  'LT': RegExp(r'^LT\-\d{5}$'),
  'LU': _fourDigit,
  'LV': RegExp(r'^LV\-\d{4}$'),
  'MX': _fiveDigit,
  'MY': _fiveDigit,
  'NL': RegExp(r'^\d{4}\s?[a-z]{2}$', caseSensitive: false),
  'NO': _fourDigit,
  'PL': RegExp(r'^\d{2}\-\d{3}$'),
  'PT': RegExp(r'^\d{4}\-\d{3}?$'),
  'RO': _sixDigit,
  'RU': _sixDigit,
  'SA': _fiveDigit,
  'SE': RegExp(r'^\d{3}\s?\d{2}$'),
  'SI': _fourDigit,
  'SK': RegExp(r'^\d{3}\s?\d{2}$'),
  'TN': _fourDigit,
  'TW': RegExp(r'^\d{3}(\d{2})?$'),
  'UA': _fiveDigit,
  'US': RegExp(r'^\d{5}(-\d{4})?$'),
  'ZA': _fourDigit,
  'ZM': _fiveDigit
};

extension StringValidatorExtensions on String {
  // ----------------------------- PROPERTIES -----------------------------
  /// Check if this string contains only letters and numbers.
  bool get isAlphanumeric => _alphanumeric.hasMatch(this);

  /// Check if this string is an e-mail.
  bool get isEMail => _email.hasMatch(toLowerCase());

  /// Check if this string is a credit card.
  bool get isCreditCard {
    final sanitized = replaceAll(RegExp(r'[^0-9]+'), '');
    if (!_creditCard.hasMatch(sanitized)) {
      return false;
    }

    // Luhn algorithm.
    var sum = 0;
    var shouldDouble = false;

    for (var i = sanitized.length - 1; i >= 0; i--) {
      final digit = sanitized.substring(i, (i + 1));
      var tmpNum = int.parse(digit);

      if (shouldDouble == true) {
        tmpNum *= 2;
        if (tmpNum >= 10) {
          sum += ((tmpNum % 10) + 1);
        } else {
          sum += tmpNum;
        }
      } else {
        sum += tmpNum;
      }
      shouldDouble = !shouldDouble;
    }

    return (sum % 10 == 0);
  }

  /// Check if this string is valid JSON.
  bool get isJSON {
    try {
      jsonDecode(this);
    } catch (e) {
      return false;
    }
    return true;
  }

  // ------------------------------- METHODS ------------------------------
  /// Check if the length of this string falls in a range.
  bool isLength({required int min, int? max}) {
    final surrogatePairs = _surrogatePairsRegExp.allMatches(this);
    final len = length - surrogatePairs.length;
    return len >= min && (max == null || len <= max);
  }

  /// Check if this string's length (in bytes) falls in a range.
  bool isByteLength({required int min, int? max}) {
    return length >= min && (max == null || length <= max);
  }

  /// Check if this string is IP [version] 4 or 6.
  /// * [version] Sets the IP version.
  bool isIP({int? version}) {
    assert(version == null || version == 4 || version == 6);

    if (version == null) {
      return isIP(version: 4) || isIP(version: 6);
    }

    if (version == 4) {
      if (!_ipv4Maybe.hasMatch(this)) {
        return false;
      }

      final parts = split('.');
      parts.sort((a, b) => int.parse(a) - int.parse(b));
      return int.parse(parts[3]) <= 255;
    }

    return version == 6 && _ipv6.hasMatch(this);
  }

  /// Check if this string is a fully qualified domain name (e.g. domain.com).
  /// * [requireTld] Sets if top-level domain is required.
  /// * [allowUnderscore] Sets if underscores are allowed.
  bool isFQDN({
    bool requireTld = true,
    bool allowUnderscores = false,
  }) {
    final parts = split('.');
    if (requireTld) {
      final tld = parts.removeLast();
      if (parts.isEmpty || !RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
        return false;
      }
    }

    for (final part in parts) {
      if (allowUnderscores) {
        if (part.contains('__')) {
          return false;
        }
      }

      if (!RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
        return false;
      }

      if (part[0] == '-' ||
          part[part.length - 1] == '-' ||
          part.indexOf('---') >= 0) {
        return false;
      }
    }

    return true;
  }

  /// Check if the string [str] is a URL.
  /// * [protocols] Sets the list of allowed protocols.
  /// * [requireTld] Sets if TLD is required.
  /// * [requireProtocol] Is a `bool` that sets if protocol is required for
  ///   validation.
  /// * [allowUnderscores] Sets if underscores are allowed.
  /// * [hostWhitelist] Sets the list of allowed hosts.
  /// * [hostBlacklist] Sets the list of disallowed hosts.
  bool isURL({
    List<String> protocols = const ['http', 'https', 'ftp'],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscores = false,
    List<String> hostWhitelist = const [],
    List<String> hostBlacklist = const [],
  }) {
    if (isNullOrWhiteSpace || length > 2083 || startsWith('mailto:')) {
      return false;
    }

    var tmp = this;
    var split = tmp.split('://');

    // check protocol
    if (split.length > 1) {
      final protocol = _shift(split);
      if (protocols.indexOf(protocol) == -1) {
        return false;
      }
    } else if (requireProtocol == true) {
      return false;
    }
    tmp = split.join('://');

    // check hash
    split = tmp.split('#');
    tmp = _shift(split);
    final hash = split.join('#');
    if (!hash.isNullOrWhiteSpace && RegExp(r'\s').hasMatch(hash)) {
      return false;
    }

    // check query params
    split = tmp.split('?');
    tmp = _shift(split);
    final query = split.join('?');
    if (!query.isNullOrWhiteSpace && RegExp(r'\s').hasMatch(query)) {
      return false;
    }

    // check path
    split = tmp.split('/');
    tmp = _shift(split);
    final path = split.join('/');
    if (!path.isNullOrWhiteSpace && RegExp(r'\s').hasMatch(path)) {
      return false;
    }

    // check auth type urls
    split = tmp.split('@');
    if (split.length > 1) {
      final auth = _shift(split);
      if (auth.indexOf(':') >= 0) {
        final auth2 = auth.split(':');
        final user = _shift(auth2);
        if (!RegExp(r'^\S+$').hasMatch(user)) {
          return false;
        }
        if (!RegExp(r'^\S*$').hasMatch(user)) {
          return false;
        }
      }
    }

    // check hostname
    final hostname = split.join('@');
    split = hostname.split(':');
    final host = _shift(split);
    if (split.isNotEmpty) {
      final portStr = split.join(':');
      int port;
      try {
        port = int.parse(portStr, radix: 10);
      } catch (e) {
        return false;
      }
      if (!RegExp(r'^[0-9]+$').hasMatch(portStr) || port <= 0 || port > 65535) {
        return false;
      }
    }

    if (!host.isIP() &&
        !host.isFQDN(
          requireTld: requireTld,
          allowUnderscores: allowUnderscores,
        ) &&
        host != 'localhost') {
      return false;
    }

    if (hostWhitelist.isNotEmpty && !hostWhitelist.contains(host)) {
      return false;
    }

    if (hostBlacklist.isNotEmpty && hostBlacklist.contains(host)) {
      return false;
    }

    return true;
  }

  /// Check if the string is an ISBN (version 10 or 13).
  bool isISBN({int? version}) {
    assert(version == null || version == 10 || version == 13);

    if (version == null) {
      return isISBN(version: 10) || isISBN(version: 13);
    }

    final sanitized = replaceAll(RegExp(r'[\s-]+'), '');
    var checksum = 0;

    // Version 10.
    if (version == 10) {
      if (!_isbn10Maybe.hasMatch(sanitized)) {
        return false;
      }

      for (var i = 0; i < 9; i++) {
        checksum += (i + 1) * int.parse(sanitized[i]);
      }

      if (sanitized[9] == 'X') {
        checksum += 10 * 10;
      } else {
        checksum += 10 * int.parse(sanitized[9]);
      }

      return (checksum % 11 == 0);
    }

    // Version 13.
    if (version == 13) {
      if (!_isbn13Maybe.hasMatch(sanitized)) {
        return false;
      }

      final factor = [1, 3];
      for (var i = 0; i < 12; i++) {
        checksum += factor[i % 2] * int.parse(sanitized[i]);
      }

      return (int.parse(sanitized[12]) - ((10 - (checksum % 10)) % 10) == 0);
    }

    return false;
  }

  bool isPostalCode({required String countryCode}) {
    final pattern = _postalCodePatterns[countryCode.trim().toUpperCase()];
    return pattern != null ? pattern.hasMatch(this) : false;
  }
}

String _shift(List<String> list) {
  return list.isNullOrEmpty ? '' : list.removeAt(0);
}
