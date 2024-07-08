import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_ams_mobile_official/helpers/services/secure_storage_service.dart';

class StorageService {
  final SecureStorageService _secureStorageService = SecureStorageService();
  final _storage = const FlutterSecureStorage();

  Future saveInteger(String key, int value) async {
    await _secureStorageService.setIntValue(key, value);
  }

  Future<int?> getInteger(String key) async {
    var result = await _secureStorageService.getIntValue(key);
    return result;

    ///hmmmmmmmmmmmm
  }

  Future saveString(String key, String Value) async {
    await _secureStorageService.setStringValue(key, Value);
  }

  Future<String> getString(String key) async {
    return await _secureStorageService.getStringValue(key);

    ///hmmmmmmmmmmmm
  }

  Future saveBoolean(String key, bool value) async {
    _secureStorageService.setBooleanValue(key, value);
  }

  Future<bool> getBoolean(String key) async {
    return await _secureStorageService.getBooleanValue(key);
  }

  void deleteValue(String key) async {
    await _secureStorageService.removeValue(key);
  }

  // Store and update  liked products
  Future<void> updateAndSaveLikedProducts(List<int> updatedArray) async {
    // convert the updated array to a string for storage

    final updatedArrayString =
        updatedArray.map((number) => number.toString()).join(',');
    await _storage.write(key: 'likedProducts', value: updatedArrayString);
  }

  // Reterieve liked products ids
  Future<List<int>> getStoreLikedProducts() async {
    final storedArrayString = await _storage.read(key: 'likedProducts');

    if (storedArrayString != null) {
      // use try catch to handle potential formal-exception
      try {
        // convert the stores string back to a list of integers
        final storedArray =
            storedArrayString.split(',').map((str) => int.parse(str)).toList();
        return storedArray;
      } catch (e) {
        debugPrint('Error parsing stored array: $e');
        // handle the error , perhaps return a default value or show an error message
        return <int>[];
      }
    } else {
      return <int>[];
    }
  }

  Future<void> clearOldData() async {
    const _storage = FlutterSecureStorage();
    await _storage.deleteAll();
  }
}
