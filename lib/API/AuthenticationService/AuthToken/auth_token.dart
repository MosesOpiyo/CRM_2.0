import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  storeToken(token) async {
    await secureStorage.write(key: 'access_token', value: token);
  }

  Future<String?> readToken() async =>
      await secureStorage.read(key: 'access_token');
}
