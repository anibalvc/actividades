import 'package:binance_api_test/core/database/database_service.dart';
import 'package:binance_api_test/core/models/equipos_asignados_response.dart';
import 'package:sqflite/sqflite.dart';

class EquiposAsignadosDB {
  final tableName = 'equipos_asignados';

  Future<void> crearTabla(Database database) async {
    await database.execute("""
    CREATE TABLE IF NOT EXISTS equipos_asignados (
      id_equipo_asignado INTEGER PRIMARY KEY AUTOINCREMENT,
      id_equipo INTEGER NOT NULL,
      id_usuario INTEGER NOT NULL,
      fecha_asignacion TEXT NOT NULL,
      labor TEXT NOT NULL,
      horas_dia REAL NOT NULL DEFAULT 0
    );
  """);
  }

  Future<void> actualizarLabor({
    required int idEquipoAsignado,
    required String nuevaLabor,
  }) async {
    final database = await DatabaseService().database;
    await database.update(
      tableName,
      {
        'labor': nuevaLabor,
      },
      where: 'id_equipo_asignado = ?',
      whereArgs: [idEquipoAsignado],
    );
  }

  Future<int> insert({
    required int idEquipo,
    required int idUsuario,
    required String fechaAsignacion,
    required String labor,
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      """INSERT INTO $tableName (id_equipo, id_usuario, fecha_asignacion, labor) VALUES (?, ?, ?, ?)""",
      [
        idEquipo,
        idUsuario,
        fechaAsignacion,
        labor,
      ],
    );
  }

  Future<EquiposAsignadosResponse> getEquipoAsignadoDelDia({
    required int idUsuario,
  }) async {
    final database = await DatabaseService().database;
    String fechaActual = DateTime.now()
        .toIso8601String()
        .split('T')[0]; // Obtener solo la parte de la fecha
    return EquiposAsignadosResponse.fromList(await database.query(
      tableName,
      where: 'id_usuario = ? AND strftime("%Y-%m-%d", fecha_asignacion) = ?',
      whereArgs: [idUsuario, fechaActual],
    ));
  }

  Future<void> eliminarEquipoAsignado(int idEquipoAsignado) async {
    final database = await DatabaseService().database;
    await database.delete(
      tableName,
      where: 'id_equipo_asignado = ?',
      whereArgs: [idEquipoAsignado],
    );
  }

  Future<EquiposAsignadosResponse> selectAll() async {
    final database = await DatabaseService().database;
    final equipos = await database.rawQuery(""" SELECT * from $tableName""");
    return EquiposAsignadosResponse.fromList(equipos);
  }
}
