import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  late FlutterSecureStorage secureStorage;
  late SharedPreferences sharedPreferences;

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_PKCS1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding);

  PrefUtils() {
    secureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  // Future<void> saveData<T>(String key, T value) async {
  //   if (value is String || value is int || value is double || value is bool) {
  //     await secureStorage.write(key: key, value: value.toString());
  //   }
  // }
  Future<void> saveData<T>(String key, T value) async {
    if (value is Map<String, dynamic>) {
      await secureStorage.write(key: key, value: jsonEncode(value));
    } else if (value is String || value is int || value is double || value is bool) {
      await secureStorage.write(key: key, value: value.toString());
    }
  }

  Future<dynamic> getData<T>(String key) async {
    final storedValue = await secureStorage.read(key: key);
    if (storedValue != null) {
      if (T == Map<String, dynamic>) {
        return jsonDecode(storedValue);
      }
      return storedValue as T?;
    }
    return null;
  }

  Future<void> removeData(String key) async {
    await secureStorage.delete(key: key);
  }

  Future<void> clearData() async {
    await secureStorage.deleteAll();
  }
}
