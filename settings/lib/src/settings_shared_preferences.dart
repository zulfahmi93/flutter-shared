import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings.dart';

/// Manage the loading and storing settings for this app using the
/// [shared_preferences] package.
class SharedPreferencesSettings extends ISettings {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [SharedPreferencesSettings].
  @visibleForTesting
  const SharedPreferencesSettings(this._sp);

  // ------------------------------- FIELDS -------------------------------
  /// Settings accessor.
  final SharedPreferences _sp;

  // ------------------------------- METHODS ------------------------------
  @override
  bool getBool(String key, bool defaultValue) {
    final value = _sp.getBool(key);
    if (value == null) {
      _sp.setBool(key, defaultValue);
      return defaultValue;
    }

    return value;
  }

  @override
  double getDouble(String key, double defaultValue) {
    final value = _sp.getDouble(key);
    if (value == null) {
      _sp.setDouble(key, defaultValue);
      return defaultValue;
    }

    return value;
  }

  @override
  int getInt(String key, int defaultValue) {
    final value = _sp.getInt(key);
    if (value == null) {
      _sp.setInt(key, defaultValue);
      return defaultValue;
    }

    return value;
  }

  @override
  String getString(String key, String defaultValue) {
    final value = _sp.getString(key);
    if (value == null) {
      _sp.setString(key, defaultValue);
      return defaultValue;
    }

    return value;
  }

  @override
  void setBool(String key, bool value) {
    _sp.setBool(key, value);
  }

  @override
  void setDouble(String key, double value) {
    _sp.setDouble(key, value);
  }

  @override
  void setInt(String key, int value) {
    _sp.setInt(key, value);
  }

  @override
  void setString(String key, String value) {
    _sp.setString(key, value);
  }

  // --------------------------- STATIC METHODS ---------------------------
  /// Create new instance of this [_Settings] class.
  static Future<ISettings> create() async {
    final sp = await SharedPreferences.getInstance();
    return SharedPreferencesSettings(sp);
  }
}
