import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUsername = 'id';
  static const _keyToken = 'token';
  static const _keyName = 'name';
  static const _keyCorreo = 'correo';

  static Future setId(String id) async =>
      await _storage.write(key: _keyUsername, value: id);

  static Future<String?> getId() async {
    return _storage.read(key: _keyUsername);
  }

  static Future deleteId(String id) async =>
      await _storage.delete(key: _keyUsername);

  //Guardar el token
  static Future setToken(String token) async =>
      await _storage.write(key: _keyToken, value: token);

  static Future<String?> getToken() async {
    return _storage.read(key: _keyToken);
  }

  static Future deleteToken(String token) async =>
      await _storage.delete(key: _keyToken);

  //Guardar el name
  static Future setName(String name) async =>
      await _storage.write(key: _keyName, value: name);

  static Future<String?> getName() async {
    return _storage.read(key: _keyName);
  }

  static Future deleteName(String token) async =>
      await _storage.delete(key: _keyName);

  //Guardar el correo
  static Future setCorreo(String correo) async =>
      await _storage.write(key: _keyCorreo, value: correo);

  static Future<String?> getCorreo() async {
    return _storage.read(key: _keyCorreo);
  }

  static Future deleteCorreo(String correo) async =>
      await _storage.delete(key: _keyCorreo);
}
