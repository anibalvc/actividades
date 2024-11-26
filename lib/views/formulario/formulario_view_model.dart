import 'dart:convert';
import 'dart:io';

import 'package:binance_api_test/core/authentication_client.dart';
import 'package:binance_api_test/core/base/base_view_model.dart';
import 'package:binance_api_test/core/database/tables/equipos_asignados_table.dart';
import 'package:binance_api_test/core/database/tables/equipos_table.dart';
import 'package:binance_api_test/core/models/equipos_response.dart';
import 'package:binance_api_test/core/providers/equipo_seleccionado_provider.dart';
import 'package:binance_api_test/core/providers/usuarios_provider.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/views/actividades/actividades_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../core/locator.dart';

class FormularioViewModel extends BaseViewModel {
  final authenticationClient = locator<AuthenticationClient>();
  final listController = ScrollController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _navigationService = locator<NavigatorService>();
  EquiposDB equiposDB = EquiposDB();
  EquiposAsignadosDB equiposAsignadosDB = EquiposAsignadosDB();

  bool _loading = false;
  bool isLogged = false;

  NavigatorService get navigator => _navigationService;

  final logger = Logger();

  List<EquiposData> equiposList = [];
  FormularioViewModel();

  List<String> jefesDeMina = [];
  List<String> minas = ["Mina Norte", "Mina Sur", "Mina Este", "Mina Oeste"];
  List<String> labores = ["Labor 1", "Labor 2", "Labor 3"];

  String fechaActual = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? jefeDeMina;
  String? mina;
  String? labor;

  EquiposData? equipoSeleccionado;

  GlobalKey<ScaffoldState> get drawerKey => _drawerKey;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> onInit(BuildContext context) async {
    loading = true;
    var providerUsuarios =
        Provider.of<UsuariosProvider>(context, listen: false);
    var providerEquipoSeleccionado =
        Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
    equipoSeleccionado = providerEquipoSeleccionado.equipoSeleccionado;
    for (var element in providerUsuarios.usuarios) {
      if (element.tipoUsuario == "Jefe de Mina") {
        jefesDeMina.add(element.nombrePerfil);
      }
    }
    for (var element in minas) {
      if (element == providerEquipoSeleccionado.nombreMina) {
        mina = element;
      }
    }
    notifyListeners();
    loading = false;
  }

  void setJefeDeMina(String? value, BuildContext context) {
    jefeDeMina = value;
    var providerEquipoSeleccionado =
        Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
    providerEquipoSeleccionado.setJefeMina(jefeMina: value ?? "");
    notifyListeners();
  }

  Future<void> goToActividades() async {
    loading = true;
    await equiposAsignadosDB.insert(
      idEquipo: int.tryParse(equipoSeleccionado!.id) ?? 0,
      idUsuario: int.tryParse(authenticationClient.loadUsuario.id) ?? 0,
      fechaAsignacion: DateTime.now().toString(),
      labor: labor ?? "",
    );
    loading = false;
    _navigationService.navigateToPageAndRemoveUntil(ActividadesView.routeName);
  }

  void setMina(String? value, BuildContext context) {
    mina = value;
    var providerEquipoSeleccionado =
        Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
    providerEquipoSeleccionado.setNombreMina(nombreMina: value ?? "");
    notifyListeners();
  }

  void setLabor(String? value, BuildContext context) {
    labor = value;
    var providerEquipoSeleccionado =
        Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
    providerEquipoSeleccionado.setLabor(labor: value ?? "");
    notifyListeners();
  }
}
