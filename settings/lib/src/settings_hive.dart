import 'package:hive/hive.dart';

import 'settings.dart';

/// Manage the loading and storing settings for this app using the
/// [hive] package.
class HiveSettings extends ISettings {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [HiveSettings].
  const HiveSettings(this._box);

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
  static Future<ISettings> create(String name, List<int> encryptionKey) async {
    final storageName = name != null ? name : 'settings-box';
    final cipher = encryptionKey != null ? HiveAesCipher(encryptionKey) : null;
    final box = await Hive.openBox(storageName, encryptionCipher: cipher);
    return HiveSettings(box);
  }
}
