import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> writeToken(String value) async {
    await _storage.write(key: "token", value: value);
  }

  Future<String?> readToken() async {
    return await _storage.read(key: "token");
  }
}
