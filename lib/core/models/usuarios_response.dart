import 'dart:convert';

UsuariosResponse usuariosResponseFromJson(String str) =>
    UsuariosResponse.fromList(json.decode(str));

String usuariosResponseToJson(UsuariosResponse data) =>
    json.encode(data.toJson());

class UsuariosResponse {
  UsuariosResponse({
    required this.data,
  });

  List<UsuariosData> data;

  factory UsuariosResponse.fromList(List<dynamic> list) => UsuariosResponse(
        data: list.map<UsuariosData>((e) => UsuariosData.fromJson(e)).toList(),
      );

  factory UsuariosResponse.fromJson(Map<String, dynamic> json) =>
      UsuariosResponse(
        data: json["data"]
            .map<UsuariosData>((e) => UsuariosData.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()),
      };
}

class UsuariosData {
  UsuariosData(
      {required this.id,
      required this.loginUsuario,
      required this.nombrePerfil,
      required this.tipoUsuario,
      required this.password});

  String id;
  String loginUsuario;
  String nombrePerfil;
  String tipoUsuario;
  String password;

  factory UsuariosData.fromJson(Map<String, dynamic> json) => UsuariosData(
      id: json["id"] ?? "",
      loginUsuario: json["usuario"] ?? '',
      nombrePerfil: json["nombre"] ?? '',
      tipoUsuario: json["tipoUsuario"] ?? '',
      password: json["clave"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": loginUsuario,
        "nombre": nombrePerfil,
        "tipoUsuario": tipoUsuario,
        "clave": password,
      };
}
