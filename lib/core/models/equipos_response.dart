import 'dart:convert';

EquiposResponse equiposResponseFromJson(String str) =>
    EquiposResponse.fromList(json.decode(str));

String equiposResponseToJson(EquiposResponse data) =>
    json.encode(data.toJson());

class EquiposResponse {
  EquiposResponse({
    required this.data,
  });

  List<EquiposData> data;

  factory EquiposResponse.fromList(List<dynamic> list) => EquiposResponse(
        data: list.map<EquiposData>((e) => EquiposData.fromJson(e)).toList(),
      );

  factory EquiposResponse.fromJson(Map<String, dynamic> json) =>
      EquiposResponse(
        data: List<Map<String, dynamic>>.from(json["data"])
            .map<EquiposData>((e) => EquiposData.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()).toList(),
      };
}

class EquiposData {
  EquiposData({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.fechaActualizacion,
    required this.subequipos,
    required this.valorHorometro,
  });

  String id;
  String codigo;
  String nombre;
  double valorHorometro;
  List<String> subequipos;
  DateTime fechaActualizacion;

  factory EquiposData.fromJson(Map<String, dynamic> json) => EquiposData(
        id: json["id_equipo"].toString(),
        nombre: json["nombre_equipo"],
        codigo: json["codigo_equipo"],
        valorHorometro: json["valor_horometro"].toDouble(),
        subequipos: List<String>.from(jsonDecode(json["subequipos"])),
        fechaActualizacion: DateTime.parse(json["fecha_actualizacion"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
        "valorHorometro": valorHorometro,
        "subequipos": jsonEncode(subequipos),
        "fechaActualizacion": fechaActualizacion,
      };
}
