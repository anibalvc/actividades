import 'package:binance_api_test/core/authentication_client.dart';
import 'package:binance_api_test/core/database/tables/equipos_asignados_table.dart';
import 'package:binance_api_test/core/database/tables/equipos_table.dart';
import 'package:binance_api_test/core/locator.dart';
import 'package:binance_api_test/core/models/equipos_response.dart';
import 'package:binance_api_test/core/providers/equipo_seleccionado_provider.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetallesEquipoViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  final _navigationService = locator<NavigatorService>();

  EquiposDB equiposDB = EquiposDB();
  EquiposAsignadosDB equiposAsignadosDB = EquiposAsignadosDB();
  final authenticationClient = locator<AuthenticationClient>();

  late EquiposData equipoSeleccionado;

  void cargarDetallesEquipo(BuildContext context) {
    var providerEquipoSeleccionado =
        Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
    equipoSeleccionado = providerEquipoSeleccionado.equipoSeleccionado;
    notifyListeners();
  }

  Future<void> onInit(BuildContext context) async {
    loading = true;
    cargarDetallesEquipo(context);
    notifyListeners();
    loading = false;
  }

  void goToSelector() {
    _navigationService.navigateToPageAndRemoveUntil('selector');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
