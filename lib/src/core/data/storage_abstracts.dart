// Interface for non-secure key-value data source
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IKeyValueDataSource {
  String? getValue(String key);
  Future<String?> getValueAsync(String key);
  Future<void> setValue(String key, String value);
  Future<void> removeValue(String key);
}

// Interface for secure key-value data source
abstract class IKeyValueSecureDataSource {
  Future<String?> getValueAsync(String key);
  Future<void> setValue(String key, String value);
  Future<void> removeValue(String key);
}

// Non-secure key-value data source implementation
class KeyValueDataSource implements IKeyValueDataSource {
  KeyValueDataSource._();
  static late SharedPreferences prefs;

  static Future<KeyValueDataSource> create() async {
    prefs = await SharedPreferences.getInstance();
    return KeyValueDataSource._();
  }

  @override
  String? getValue(String key) {
    return prefs.getString(key);
  }

  @override
  Future<void> setValue(String key, String value) async {
    await prefs.setString(key, value);
  }

  @override
  Future<String?> getValueAsync(String key) async {
    return prefs.getString(key);
  }

  @override
  Future<void> removeValue(String key) async {
    // Implementation of removeValue
    await prefs.remove(key);
  }
}

// Secure key-value data source implementation
class KeyValueSecureDataSource implements IKeyValueSecureDataSource {
  KeyValueSecureDataSource._();
  static late FlutterSecureStorage secureStorage;

  static Future<KeyValueSecureDataSource> create() async {
    secureStorage = const FlutterSecureStorage();
    return KeyValueSecureDataSource._();
  }

  @override
  Future<void> setValue(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getValueAsync(String key) async {
    return secureStorage.read(key: key);
  }

  @override
  Future<void> removeValue(String key) async {
    // Implementation of removeValue
    await secureStorage.delete(key: key);
  }
}
