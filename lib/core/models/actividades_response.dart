import 'dart:convert';

ActividadesResponse actividadesResponseFromJson(String str) =>
    ActividadesResponse.fromList(json.decode(str));

String actividadesResponseToJson(ActividadesResponse data) =>
    json.encode(data.toJson());

class ActividadesResponse {
  ActividadesResponse({
    required this.data,
  });

  List<ActividadData> data;

  factory ActividadesResponse.fromList(List<dynamic> list) =>
      ActividadesResponse(
        data:
            list.map<ActividadData>((e) => ActividadData.fromJson(e)).toList(),
      );

  factory ActividadesResponse.fromJson(Map<String, dynamic> json) =>
      ActividadesResponse(
        data: List<Map<String, dynamic>>.from(json["data"])
            .map<ActividadData>((e) => ActividadData.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()).toList(),
      };
}

class ActividadData {
  ActividadData({
    required this.idActividad,
    required this.idEquipo,
    required this.idUsuario,
    required this.fechaActividad,
    required this.horaInicio,
    required this.horaFin,
    required this.horaHorometro,
    required this.labor,
    required this.nombre,
    required this.jefeMina,
    required this.nombreMina,
  });

  int idActividad;
  int idEquipo;
  int idUsuario;
  String fechaActividad;
  String nombre;
  String horaInicio;
  String horaFin;
  String jefeMina;
  String nombreMina;
  double horaHorometro;
  String labor;

  factory ActividadData.fromJson(Map<String, dynamic> json) => ActividadData(
        idActividad: json["id_actividad"],
        jefeMina: json["jefe_mina"],
        nombreMina: json["nombre_mina"],
        nombre: json["nombre"],
        idEquipo: json["id_equipo"],
        idUsuario: json["id_usuario"],
        fechaActividad: json["fecha_actividad"],
        horaInicio: json["hora_inicio"],
        horaFin: json["hora_fin"],
        horaHorometro: json["hora_horometro"].toDouble(),
        labor: json["labor"],
      );

  Map<String, dynamic> toJson() => {
        "id_actividad": idActividad,
        "id_equipo": idEquipo,
        "id_usuario": idUsuario,
        "fecha_actividad": fechaActividad,
        "hora_inicio": horaInicio,
        "nombre": nombre,
        "hora_fin": horaFin,
        "hora_horometro": horaHorometro,
        "labor": labor,
      };
}
