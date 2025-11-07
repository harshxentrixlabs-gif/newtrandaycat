import 'package:get_storage/get_storage.dart';

/// A singleton class to manage app storage using GetStorage
class AppStorage {
  static final AppStorage _instance = AppStorage._internal();
  factory AppStorage() => _instance;
  AppStorage._internal();

  final _box = GetStorage();

  /// Call this before runApp()
  static Future<void> init() async {
    await GetStorage.init();
  }

  /// Save data
  Future<void> save(String key, dynamic value) async {
    await _box.write(key, value);
  }

  /// Read data
  T? read<T>(String key) {
    return _box.read<T>(key);
  }

  /// Delete single key
  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  /// Clear all data
  Future<void> clear() async {
    await _box.erase();
  }

  /// Check if key exists
  bool has(String key) {
    return _box.hasData(key);
  }
}



