import 'package:get_storage/get_storage.dart';

class CacheHelper {
  static late GetStorage _box;

  static Future<void> init() async {
    await GetStorage.init();
    _box = GetStorage();
  }

  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    await _box.write(key, value);
  }

  static T? getData<T>({required String key}) {
    return _box.read<T>(key);
  }

  static Future<void> removeData({required String key}) async {
    await _box.remove(key);
  }

  static Future<void> clear() async {
    await _box.erase();
  }

  static Future<void> saveThemeMode(String mode) async {
    await saveData(key: 'theme_mode', value: mode);
  }

  static String? getThemeMode() {
    return getData<String>(key: 'theme_mode');
  }
}
