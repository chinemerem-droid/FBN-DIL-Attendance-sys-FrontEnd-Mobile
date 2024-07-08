import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> setStringValue(String key, String data) async {
    await _storage.write(key: key, value: data);
  }

  Future<String> getStringValue(String key) async {
    return await _storage.read(key: key) ?? "";
  }

  Future<void> setBooleanValue(String key, bool data) async {
    await _storage.write(key: key, value: data.toString());
  }

  Future<bool> getBooleanValue(String key) async {
    String? val = await _storage.read(key: key);
    if (val == null) {
      return false;
    } else if (val.toLowerCase() == "true") {
      return true;
    }
    return false;
  }

  Future<void> setIntValue(String key, int data) async {
    await _storage.write(key: key, value: data.toString());
  }

  Future<int?> getIntValue(String key) async {
    String? val = await _storage.read(key: key) ?? "0";
    return int.tryParse(val) ?? 0;
  }

  Future<void> removeValue(dynamic key) async {
    await _storage.delete(key: key);
  }
}
