import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage? secureStorage;

  SecureStorageService({required this.secureStorage});

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<Map<String, String>> get getAllValues async =>
      await _secureStorage.readAll();

  Future<void> get deleteAllValues async => await _secureStorage.deleteAll();

  //!TOKEN
  Future<void> saveToken(String? value) =>
      _secureStorage.write(key: 'token', value: value);
  Future<String?> get token async => await _secureStorage.read(key: 'token');
  Future<void> get removeToken => _secureStorage.delete(key: 'token');
  Future<bool> get hasToken async =>
      (await _secureStorage.read(key: 'token')) != null;
}
