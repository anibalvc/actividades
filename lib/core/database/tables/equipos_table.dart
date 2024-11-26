import 'package:binance_api_test/core/database/database_service.dart';
import 'package:binance_api_test/core/models/equipos_response.dart';
import 'package:sqflite/sqflite.dart';

class EquiposDB {
  final tableName = 'equipos';

  Future<void> crearTabla(Database database) async {
    await database.execute("""
    CREATE TABLE IF NOT EXISTS equipos (
      id_equipo INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre_equipo TEXT NOT NULL,
      codigo_equipo TEXT NOT NULL,
      valor_horometro REAL NOT NULL,
      subequipos TEXT NOT NULL,
      fecha_actualizacion TEXT NOT NULL
    );
  """);
    var result = await database.rawQuery('SELECT COUNT(*) FROM equipos');
    int count = Sqflite.firstIntValue(result) ?? 0;

    if (count == 0) {
      // Insertar registros de ejemplo solo si la tabla está vacía
      await database.execute("""
      INSERT INTO equipos (nombre_equipo, codigo_equipo, valor_horometro, subequipos, fecha_actualizacion)
      VALUES
        ('Excavadora CAT 320', 'EXC320', 120.5, '["Sub1", "Sub2"]', '2024-11-18 14:30:00'),
        ('Cargador Komatsu', 'CAR450', 340.0, '["Sub3", "Sub4"]', '2024-11-19 10:00:00'),
        ('Perforadora Sandvik', 'PERF580', 45.7, '["Sub5"]', '2024-11-19 08:45:00'),
        ('Bulldozer CAT D11', 'BULLD11', 210.9, '[]', '2024-11-18 16:00:00'),
        ('Camión Liebherr T 284', 'CAMT284', 500.0, '["Sub6", "Sub7"]', '2024-11-19 09:15:00');
    """);
    }
  }

  Future<void> actualizarValorHorometro({
    required int idEquipo,
    required double incrementoValorHorometro,
  }) async {
    final database = await DatabaseService().database;

    List<Map<String, dynamic>> result = await database.query(
      tableName,
      columns: ['valor_horometro'],
      where: 'id_equipo = ?',
      whereArgs: [idEquipo],
    );

    if (result.isNotEmpty) {
      double valorActualHorometro = result.first['valor_horometro'];

      double nuevoValorHorometro =
          valorActualHorometro + incrementoValorHorometro;

      await database.update(
        tableName,
        {
          'valor_horometro': nuevoValorHorometro,
          'fecha_actualizacion': DateTime.now().toIso8601String(),
        },
        where: 'id_equipo = ?',
        whereArgs: [idEquipo],
      );
    }
  }

  Future<EquiposData?> selectById(int idEquipo) async {
    final database = await DatabaseService().database;
    final result = await database.query(
      tableName,
      where: 'id_equipo = ?',
      whereArgs: [idEquipo],
    );

    if (result.isNotEmpty) {
      return EquiposData.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<EquiposResponse> selectAll() async {
    final database = await DatabaseService().database;
    final equipos = await database.rawQuery(""" SELECT * from $tableName""");
    return EquiposResponse.fromList(equipos);
  }
}
