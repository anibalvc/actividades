import 'package:binance_api_test/core/database/tables/actividades_table.dart';
import 'package:binance_api_test/core/database/tables/equipos_asignados_table.dart';
import 'package:binance_api_test/core/database/tables/equipos_table.dart';
import 'package:binance_api_test/views/actividades/actividades_view_model.dart';
import 'package:binance_api_test/widgets/app_dialogs.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    try {
      if (_database != null) {
        return _database!;
      }
      _database = await _initialize();
      return _database!;
    } on DatabaseException catch (e) {
      Dialogs.error(msg: "Error al obtener la Base de Datos");
      throw Exception("Error al obtener la Base de Datos $e");
    }
  }

  Future<String> get fullPath async {
    const name = 'actividades.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path, version: 2, singleInstance: true);
    await EquiposDB().crearTabla(database);
    await EquiposAsignadosDB().crearTabla(database);
    await ActividadesDB().crearTabla(database);
    return database;
  }
}
