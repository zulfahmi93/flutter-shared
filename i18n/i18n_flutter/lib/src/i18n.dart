import 'dart:ui';

import 'package:simple_i18n_core/simple_i18n_core.dart';

// ignore: avoid_classes_with_only_static_members
/// Provides localisation for this app.
class L {
  // ---------------------------- STATIC FIELDS ---------------------------
  /// Supported locales.
  static List<Locale>? _supportedLocales;

  // -------------------------- STATIC PROPERTIES -------------------------
  /// Gets list of the supported locales.
  static List<Locale> get supportedLocales {
    if (_supportedLocales != null) {
      return _supportedLocales!;
    }
    throw StateError('Localisation is not initialised.');
  }

  // --------------------------- STATIC METHODS ---------------------------
  /// Initialise
  static void initialise({
    required String defaultLanguage,
    required List<String> supportedLanguages,
    required Map<String, LocalisationEntry> localisationData,
    LocalisationNotFoundCallback? onLocalisationNotFound,
    LocalisationChangedCallback? onLanguageChanged,
    bool? isDebug,
  }) {
    SimpleLocalisation.initialise(
      defaultLanguage: defaultLanguage,
      supportedLanguages: supportedLanguages,
      localisationData: localisationData,
      onLocalisationNotFound: onLocalisationNotFound,
      onLanguageChanged: onLanguageChanged,
      isDebug: isDebug,
    );
    _supportedLocales = SimpleLocalisation.instance.supportedLocales
        .map((l) => Locale(l.languageCode, l.countryCode))
        .toList();
  }

  /// Gets the localised text of given [key].
  static String get(String key) => SimpleLocalisation.instance.get(key);

  /// Change to another language given by [newLanguage].
  static void changeLanguage(String newLanguage) =>
      SimpleLocalisation.instance.changeLanguage(newLanguage);
}
