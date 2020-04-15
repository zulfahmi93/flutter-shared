import 'package:shared_preferences/shared_preferences.dart';

/// Contracts for loading and storing settings for this app.
abstract class ISettings {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [ISettings].
  const ISettings();

  // ------------------------------- METHODS ------------------------------
  /// Get settings of specified [key] which has a runtime type of [bool].
  ///
  /// If [key] is not yet defined, store [defaultValue] into settings for
  /// specified [key] and returns the [defaultValue] to user.
  // ignore: avoid_positional_boolean_parameters
  bool getBool(String key, bool defaultValue);

  /// Get settings of specified [key] which has a runtime type of [double].
  ///
  /// If [key] is not yet defined, store [defaultValue] into settings for
  /// specified [key] and returns the [defaultValue] to user.
  double getDouble(String key, double defaultValue);

  /// Get settings of specified [key] which has a runtime type of [int].
  ///
  /// If [key] is not yet defined, store [defaultValue] into settings for
  /// specified [key] and returns the [defaultValue] to user.
  int getInt(String key, int defaultValue);

  /// Get settings of specified [key] which has a runtime type of [String].
  ///
  /// If [key] is not yet defined, store [defaultValue] into settings for
  /// specified [key] and returns the [defaultValue] to user.
  String getString(String key, String defaultValue);

  /// Set settings of specified [key] which has a runtime type of [bool] to the
  ///given [value].
  // ignore: avoid_positional_boolean_parameters
  void setBool(String key, bool value);

  /// Set settings of specified [key] which has a runtime type of [double] to
  /// the given [value].
  void setDouble(String key, double value);

  /// Set settings of specified [key] which has a runtime type of [int] to the
  /// given [value].
  void setInt(String key, int value);

  /// Set settings of specified [key] which has a runtime type of [String] to
  /// the given [value].
  void setString(String key, String value);

  // --------------------------- STATIC METHODS ---------------------------
  /// Creates new object which implements [ISettings].
  static Future<ISettings> create() async {
    return await _Settings._create();
  }
}

/// Manage the loading and storing settings for this app.
class _Settings extends ISettings {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [_Settings].
  const _Settings(this._sp);

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
  static Future<ISettings> _create() async {
    final sp = await SharedPreferences.getInstance();
    return _Settings(sp);
  }
}
