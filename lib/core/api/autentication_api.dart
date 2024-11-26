import 'package:binance_api_test/core/api/core/api_status.dart';
import 'package:binance_api_test/core/api/core/http.dart';
import 'package:binance_api_test/core/models/usuarios_response.dart';

class AuthenticationApi {
  final Http _http;
  AuthenticationApi(this._http);

  Future<Object> signIn({
    required String usuario,
    required String clave,
    required List<UsuariosData> usuariosData,
  }) async {
    for (var user in usuariosData) {
      if (user.loginUsuario.toLowerCase() == usuario.toLowerCase() &&
          user.password == clave) {
        return UsuariosData.fromJson({
          'usuario': usuario,
          'clave': clave,
          'nombre': user.nombrePerfil,
          'tipoUsuario': user.tipoUsuario,
          'id': user.id
        });
      }
    }
    return Failure(message: "Usuario o contraseña incorrectos");
  }
}
