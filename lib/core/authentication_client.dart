import 'dart:convert';

import 'package:binance_api_test/core/models/usuarios_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationClient {
  SharedPreferences _storage;

  AuthenticationClient(
    this._storage,
  );

  Future<void> initPrefs() async {
    _storage = await SharedPreferences.getInstance();
  }

  UsuariosData get loadUsuario {
    final data = _storage.getString('USUARIO') ?? "";
    var session = UsuariosData(
        id: "",
        loginUsuario: "",
        nombrePerfil: "",
        password: "",
        tipoUsuario: "");
    if (data != "") session = UsuariosData.fromJson(jsonDecode(data));
    return session;
  }

  set isLogged(bool v) {
    _storage.setBool('isLogged', v);
  }

  bool get isLogged {
    return _storage.getBool('isLogged') ?? false;
  }

  void saveUsuario(UsuariosData usuariosData) {
    final data = jsonEncode(usuariosData.toJson());
    _storage.setString('USUARIO', data);
  }

  Future<void> clear() async {
    await _storage.clear();
  }
}
