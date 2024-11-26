import 'dart:convert';

EquiposAsignadosResponse equiposAsignadosResponseFromJson(String str) =>
    EquiposAsignadosResponse.fromList(json.decode(str));

String equiposAsignadosResponseToJson(EquiposAsignadosResponse data) =>
    json.encode(data.toJson());

class EquiposAsignadosResponse {
  EquiposAsignadosResponse({
    required this.data,
  });

  List<EquiposAsignadosData> data;

  factory EquiposAsignadosResponse.fromList(List<dynamic> list) =>
      EquiposAsignadosResponse(
        data: list
            .map<EquiposAsignadosData>((e) => EquiposAsignadosData.fromJson(e))
            .toList(),
      );

  factory EquiposAsignadosResponse.fromJson(Map<String, dynamic> json) =>
      EquiposAsignadosResponse(
        data: List<Map<String, dynamic>>.from(json["data"])
            .map<EquiposAsignadosData>((e) => EquiposAsignadosData.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()).toList(),
      };
}

class EquiposAsignadosData {
  EquiposAsignadosData({
    required this.idEquipoAsignado,
    required this.idEquipo,
    required this.idUsuario,
    required this.fechaAsignacion,
    required this.labor,
    required this.horasDia,
  });

  int idEquipoAsignado;
  int idEquipo;
  int idUsuario;
  String fechaAsignacion;
  String labor;
  double horasDia;

  factory EquiposAsignadosData.fromJson(Map<String, dynamic> json) =>
      EquiposAsignadosData(
        idEquipoAsignado: json["id_equipo_asignado"],
        idEquipo: json["id_equipo"],
        idUsuario: json["id_usuario"],
        labor: json["labor"],
        fechaAsignacion: json["fecha_asignacion"],
        horasDia: json["horas_dia"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id_equipo_asignado": idEquipoAsignado,
        "id_equipo": idEquipo,
        "id_usuario": idUsuario,
        "labor": labor,
        "fecha_asignacion": fechaAsignacion,
        "horas_dia": horasDia,
      };
}
