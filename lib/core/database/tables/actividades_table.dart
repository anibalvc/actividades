import 'package:binance_api_test/core/database/database_service.dart';
import 'package:binance_api_test/core/models/actividades_response.dart';
import 'package:binance_api_test/core/models/equipos_asignados_response.dart';
import 'package:sqflite/sqflite.dart';

class ActividadesDB {
  final tableName = 'actividades';

  Future<void> crearTabla(Database database) async {
    await database.execute("""
    CREATE TABLE IF NOT EXISTS actividades (
      id_actividad INTEGER PRIMARY KEY AUTOINCREMENT,
      id_equipo INTEGER NOT NULL,
      id_usuario INTEGER NOT NULL,
      nombre TEXT NOT NULL,
      jefe_mina TEXT NOT NULL,
      nombre_mina TEXT NOT NULL,
      fecha_actividad TEXT NOT NULL,
      hora_inicio TEXT NOT NULL,
      hora_fin TEXT NOT NULL,
      hora_horometro REAL NOT NULL DEFAULT 0,
      labor TEXT NOT NULL
    );
  """);
  }

  Future<int> insert({
    required int idEquipo,
    required int idUsuario,
    required String fechaActividad,
    required String horaInicio,
    required String horaFin,
    required double horaHorometro,
    required String labor,
    required String nombre,
    required String jefeMina,
    required String nombreMina,
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      """INSERT INTO $tableName (id_equipo, id_usuario, fecha_actividad, hora_inicio, hora_fin, hora_horometro, labor, nombre, jefe_mina, nombre_mina) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
      [
        idEquipo,
        idUsuario,
        fechaActividad,
        horaInicio,
        horaFin,
        horaHorometro,
        labor,
        nombre,
        jefeMina,
        nombreMina,
      ],
    );
  }

  Future<void> eliminarActividadesPorFecha(String fechaActividad) async {
    final database = await DatabaseService().database;
    await database.delete(
      tableName,
      where: 'fecha_actividad = ?',
      whereArgs: [fechaActividad],
    );
  }

  Future<ActividadesResponse> selectActividadesDelDia({
    required int idEquipo,
    required int idUsuario,
  }) async {
    final database = await DatabaseService().database;
    String fechaActual = DateTime.now()
        .toIso8601String()
        .split('T')[0]; // Obtener solo la parte de la fecha
    return ActividadesResponse.fromList(await database.query(
      tableName,
      where: 'id_equipo = ? AND id_usuario = ? AND fecha_actividad = ?',
      whereArgs: [idEquipo, idUsuario, fechaActual],
    ));
  }

  Future<ActividadesResponse> selectAll() async {
    final database = await DatabaseService().database;
    final equipos = await database.rawQuery(""" SELECT * from $tableName""");
    return ActividadesResponse.fromList(equipos);
  }
}
