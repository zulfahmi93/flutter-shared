import 'dart:async';

import 'package:intl/locale.dart';

// ------------------------------- CLASSES ------------------------------
/// Localisation helper.
class SimpleLocalisation {
  // ---------------------------- CONSTRUCTORS ----------------------------
  SimpleLocalisation._({
    required String defaultLanguage,
    required List<String> supportedLanguages,
    required Map<String, LocalisationEntry> localisationData,
    LocalisationNotFoundCallback? onLocalisationNotFound,
    LocalisationChangedCallback? onLanguageChanged,
    bool? isDebug,
  })  : _defaultLanguage = defaultLanguage,
        _language = defaultLanguage,
        _supportedLocales = supportedLanguages.map(Locale.parse).toList(),
        _localisationData = localisationData,
        _onLocalisationNotFound = onLocalisationNotFound,
        _onLanguageChanged = onLanguageChanged,
        _languageChangeStream = StreamController<String>() {
    if (isDebug == null) {
      _isDebug = false;
      assert(_isDebug = true);
    } else {
      _isDebug = isDebug;
    }
    _isInitialised = true;
  }

  // ------------------------------- FIELDS -------------------------------
  /// Default Language.
  final String _defaultLanguage;

  /// Supported locales.
  final List<Locale> _supportedLocales;

  /// Localisation data.
  final Map<String, LocalisationEntry> _localisationData;

  /// Called when localisation not found for a particular key and locale.
  final LocalisationNotFoundCallback? _onLocalisationNotFound;

  /// Called when language changed.
  final LocalisationChangedCallback? _onLanguageChanged;

  /// Stream controller for updating and listening to the language changed
  /// event.
  final StreamController<String> _languageChangeStream;

  /// Flags to determine if the code is running in debug mode.
  bool _isDebug = true;

  /// Flags to determine whether the localisation has been initialised.
  bool _isInitialised = false;

  /// Current Language.
  String _language;

  // ----------------------------- PROPERTIES -----------------------------
  /// Gets list of the supported locales.
  List<Locale> get supportedLocales => _supportedLocales;

  // ------------------------------- METHODS ------------------------------
  /// Gets the localised text of given [key].
  String get(String key) {
    if (!_isInitialised) {
      throw _LocalisationError(reason: 'Localisation is not initialised!');
    }

    if (_localisationData.containsKey(key)) {
      // Key existence check has been done.
      final entry = _localisationData[key]!;
      return _extractText(key, entry.data);
    }

    _onLocalisationNotFound?.call(key, _language);
    return _isDebug ? 'LOCALISE THIS!' : key;
  }

  /// Change to another language given by [newLanguage].
  void changeLanguage(String newLanguage) {
    _language = newLanguage;
    _onLanguageChanged?.call(_language);
    _languageChangeStream.add(_language);
  }

  void appendLocalisationData({
    required Map<String, LocalisationEntry> localisationData,
  }) {
    _localisationData.addAll(localisationData);
  }

  /// Extract localised string for current locale.
  String _extractText(String key, Map<String, String> map) {
    if (map.containsKey(_language)) {
      // Key existence check has been done.
      return map[_language]!;
    }

    // From this, treat all text extracting attempt as localisation
    // was not found.
    _onLocalisationNotFound?.call(key, _language);

    final locale = Locale.parse(_language);
    if (map.containsKey(locale.languageCode)) {
      // Key existence check has been done.
      return map[locale.languageCode]!;
    }
    if (map.containsKey(_defaultLanguage)) {
      // Key existence check has been done.
      return map[_defaultLanguage]!;
    }

    return _isDebug ? 'LOCALISE THIS!' : key;
  }

  // ---------------------------- STATIC FIELDS ---------------------------
  static SimpleLocalisation? _instance;

  // -------------------------- STATIC PROPERTIES -------------------------
  static SimpleLocalisation get instance {
    if (_instance != null) {
      return _instance!;
    }
    throw StateError(
      'Call initialise method before getting the instance of this object.',
    );
  }

  // --------------------------- STATIC METHODS ---------------------------
  static void initialise({
    required String defaultLanguage,
    required List<String> supportedLanguages,
    required Map<String, LocalisationEntry> localisationData,
    LocalisationNotFoundCallback? onLocalisationNotFound,
    LocalisationChangedCallback? onLanguageChanged,
    bool? isDebug,
  }) {
    _instance = SimpleLocalisation._(
      defaultLanguage: defaultLanguage,
      supportedLanguages: supportedLanguages,
      localisationData: localisationData,
      onLocalisationNotFound: onLocalisationNotFound,
      onLanguageChanged: onLanguageChanged,
      isDebug: isDebug,
    );
  }
}

/// Single entry for localisation data.
class LocalisationEntry {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [LocalisationEntry].
  const LocalisationEntry({required this.data});

  // ------------------------------- FIELDS -------------------------------
  /// Localisation data.
  final Map<String, String> data;
}

/// Error
class _LocalisationError extends Error {
  // ---------------------------- CONSTRUCTORS ----------------------------
  _LocalisationError({required this.reason});

  // ------------------------------- FIELDS -------------------------------
  final String reason;
}

// ------------------------------ TYPEDEFS ------------------------------
typedef LocalisationNotFoundCallback = void Function(String key, String locale);
typedef LocalisationChangedCallback = void Function(String newLocale);
