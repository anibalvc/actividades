import 'package:binance_api_test/core/models/equipos_response.dart';
import 'package:flutter/material.dart';

class EquipoSeleccionadoProvider with ChangeNotifier {
  late String _nombreMina = "";
  late EquiposData _equipoSeleccionado = EquiposData(
    codigo: "",
    fechaActualizacion: DateTime.now(),
    id: "",
    subequipos: [],
    valorHorometro: 0,
    nombre: "",
  );
  late String _labor = "";
  late String _jefeMina = "";

  String get nombreMina => _nombreMina;
  EquiposData get equipoSeleccionado => _equipoSeleccionado;
  String get labor => _labor;
  String get jefeMina => _jefeMina;

  void setNombreMina({required String nombreMina}) {
    _nombreMina = nombreMina;
    notifyListeners();
  }

  void setJefeMina({required String jefeMina}) {
    _jefeMina = jefeMina;
    notifyListeners();
  }

  void setEquipo({required EquiposData equipo}) {
    _equipoSeleccionado = equipo;
    notifyListeners();
  }

  void setLabor({required String labor}) {
    _labor = labor;
    notifyListeners();
  }
}
