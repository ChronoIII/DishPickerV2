import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  SecureStorageUtil();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getFromStorage(String key) async {
    return await _storage.read(
      key: key,
    );
  }

  Future<void> saveToStorage(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
    );
  }

  Future<void> deleteFromStorage(String key) async {
    await _storage.delete(
      key: key,
    );
  }

  Future<Map<String, String>> readAllItems() async {
    return await _storage.readAll();
  }

  Future<void> deleteAllItems() async {
    await _storage.deleteAll();
  }
}
