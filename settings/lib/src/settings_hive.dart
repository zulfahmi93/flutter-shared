import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'settings.dart';

/// Manage the loading and storing settings for this app using the
/// [hive] package.
class HiveSettings extends ISettings {
  // ---------------------------- CONSTRUCTORS ----------------------------
  /// Create new [HiveSettings].
  @visibleForTesting
  const HiveSettings(
    this._boolBox,
    this._doubleBox,
    this._intBox,
    this._stringBox,
  );

  // ------------------------------- FIELDS -------------------------------
  /// Settings accessor.
  final Box<bool> _boolBox;
  final Box<double> _doubleBox;
  final Box<int> _intBox;
  final Box<String> _stringBox;

  // ------------------------------- METHODS ------------------------------
  @override
  bool getBool(String key, bool defaultValue) {
    final value = _boolBox.get(key);
    if (value != null) {
      return value;
    }
    _boolBox.put(key, defaultValue);
    return defaultValue;
  }

  @override
  double getDouble(String key, double defaultValue) {
    final value = _doubleBox.get(key);
    if (value != null) {
      return value;
    }
    _doubleBox.put(key, defaultValue);
    return defaultValue;
  }

  @override
  int getInt(String key, int defaultValue) {
    final value = _intBox.get(key);
    if (value != null) {
      return value;
    }
    _intBox.put(key, defaultValue);
    return defaultValue;
  }

  @override
  String getString(String key, String defaultValue) {
    final value = _stringBox.get(key);
    if (value != null) {
      return value;
    }
    _stringBox.put(key, defaultValue);
    return defaultValue;
  }

  @override
  void setBool(String key, bool value) {
    _boolBox.put(key, value);
  }

  @override
  void setDouble(String key, double value) {
    _doubleBox.put(key, value);
  }

  @override
  void setInt(String key, int value) {
    _intBox.put(key, value);
  }

  @override
  void setString(String key, String value) {
    _stringBox.put(key, value);
  }

  // --------------------------- STATIC METHODS ---------------------------
  /// Create new instance of this [_Settings] class.
  static Future<ISettings> create(
    String? name,
    List<int>? encryptionKey,
  ) async {
    final storageName = name != null ? name : 'settings-box';
    final cipher = encryptionKey != null ? HiveAesCipher(encryptionKey) : null;
    final boolBox = await Hive.openBox<bool>(
      '$storageName-bool',
      encryptionCipher: cipher,
    );
    final doubleBox = await Hive.openBox<double>(
      '$storageName-double',
      encryptionCipher: cipher,
    );
    final intBox = await Hive.openBox<int>(
      '$storageName-int',
      encryptionCipher: cipher,
    );
    final stringBox = await Hive.openBox<String>(
      '$storageName-string',
      encryptionCipher: cipher,
    );
    return HiveSettings(boolBox, doubleBox, intBox, stringBox);
  }
}
