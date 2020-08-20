import 'package:hive/hive.dart';

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
  static Future<ISettings> create(List<int> encryptionKey) async {
    return await _Settings._create(encryptionKey);
  }
}

/// Manage the loading and storing settings for this app.
class _Settings extends ISettings {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [_Settings].
  const _Settings(this._box);

  // ------------------------------- FIELDS -------------------------------
  /// Settings accessor.
  final Box _box;

  // ------------------------------- METHODS ------------------------------
  @override
  bool getBool(String key, bool defaultValue) {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  double getDouble(String key, double defaultValue) {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  int getInt(String key, int defaultValue) {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  String getString(String key, String defaultValue) {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  void setBool(String key, bool value) {
    _box.put(key, value);
  }

  @override
  void setDouble(String key, double value) {
    _box.put(key, value);
  }

  @override
  void setInt(String key, int value) {
    _box.put(key, value);
  }

  @override
  void setString(String key, String value) {
    _box.put(key, value);
  }

  // --------------------------- STATIC METHODS ---------------------------
  /// Create new instance of this [_Settings] class.
  static Future<ISettings> _create(List<int> encryptionKey) async {
    final cipher = encryptionKey != null ? HiveAesCipher(encryptionKey) : null;
    final box = await Hive.openBox('settings-box', encryptionCipher: cipher);
    return _Settings(box);
  }
}
