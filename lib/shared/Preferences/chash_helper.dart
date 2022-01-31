import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPrefer;

  static init() async {
    sharedPrefer = await SharedPreferences.getInstance();
  }

  static Future<bool> setValue({required String key, required value}) async {
    if (value is bool) {
      return await sharedPrefer!.setBool(key, value);
    }
    if (value is int) {
      return await sharedPrefer!.setInt(key, value);
    }
    if (value is double) {
      return await sharedPrefer!.setDouble(key, value);
    }
    return await sharedPrefer!.setString(key, value.toString());
  }

  static bool? getBool({required String key}) {
    return sharedPrefer!.getBool(key);
  }

  static String? getString({required String key}) {
    return sharedPrefer!.getString(key);
  }

  static int? getInt({required String key}) {
    return sharedPrefer!.getInt(key);
  }

  static double? getDouble({required String key}) {
    return sharedPrefer!.getDouble(key);
  }

  static void removeKey(String key) {
    sharedPrefer!.remove(key);
  }
}
