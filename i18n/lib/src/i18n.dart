import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'formatters.dart';

// ignore: avoid_classes_with_only_static_members
/// Provides localisation for this app.
class L {
  // ---------------------------- STATIC FIELDS ---------------------------
  /// Formatters.
  static final Formatters _formatters = Formatters();

  /// Default Language.
  static String _defaultLanguage;

  /// Current Language.
  static String _language;

  /// Current Locale.
  static Locale _locale;

  /// Default Locale.
  static List<Locale> _supportedLocales;

  /// Default Locale.
  static Map<String, _LE> _localisationData;

  /// Debug mode flag.
  static bool _isDebug;

  // -------------------------- STATIC PROPERTIES -------------------------
  static void initialise({
    @required String defaultLanguage,
    @required List<String> supportedLanguages,
    @required Map<String, _LE> localisationData,
    bool isDebug = false,
  }) {
    assert(supportedLanguages != null);
    assert(defaultLanguage != null);
    _defaultLanguage = defaultLanguage;
    changeLanguage(defaultLanguage);
    _supportedLocales = supportedLanguages.map(getLocale).toList();
    _localisationData = localisationData;
    _isDebug = isDebug;
  }

  /// Gets list of supported locales.
  static List<Locale> get supportedLocales => _supportedLocales;

  /// Gets the simple number formatter.
  static Formatters get formatter => _formatters;

  // --------------------------- STATIC METHODS ---------------------------
  /// Gets the localised text of given [key].
  static String get(String key) {
    if (_localisationData.containsKey(key)) {
      final entry = _localisationData[key];
      final text = _extractText(entry.data);

      return text;
    }

    return _isDebug ? 'LOCALISE THIS!' : key;
  }

  /// Change to another language given by [newLanguage].
  static void changeLanguage(String newLanguage) {
    _language = newLanguage;
    _locale = getLocale(newLanguage);
  }

  /// Construct [Locale] from given [language].
  static Locale getLocale(String language) {
    final split = language.split('-');
    final languageCode = split[0];
    final countryCode = split.length > 1 ? split[1] : null;
    return Locale(languageCode, countryCode);
  }

  /// Extract localised string for current locale.
  static String _extractText(Map<String, String> map) {
    if (map.containsKey(_language)) {
      return map[_language];
    } else if (map.containsKey(_locale.languageCode)) {
      return map[_locale.languageCode];
    } else {
      return map[_defaultLanguage];
    }
  }
}

/// Single entry for localisation data.
class _LE {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [_LE].
  const _LE({@required this.data});

  // ------------------------------- FIELDS -------------------------------
  /// Localisation data.
  final Map<String, String> data;
}

extension LStringExtensions on String {
  /// Gets the localised text of current [String].
  String get l10n => L.get(this);
}

extension LNumberExtensions on num {
  /// Gets the formatted text of current [num].
  String format({int decimalPlacesCount, bool includeSign = false}) {
    return L.formatter.formatNumber(
      number: this,
      decimalPlacesCount: decimalPlacesCount,
      includeSign: includeSign,
    );
  }
}
