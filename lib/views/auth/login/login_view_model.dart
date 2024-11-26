import 'package:binance_api_test/core/api/autentication_api.dart';
import 'package:binance_api_test/core/api/core/api_status.dart';
import 'package:binance_api_test/core/authentication_client.dart';
import 'package:binance_api_test/core/base/base_view_model.dart' as custom_base;
import 'package:binance_api_test/core/database/tables/equipos_asignados_table.dart';
import 'package:binance_api_test/core/database/tables/equipos_table.dart';
import 'package:binance_api_test/core/locator.dart';
import 'package:binance_api_test/core/models/equipos_asignados_response.dart';
import 'package:binance_api_test/core/models/usuarios_response.dart';
import 'package:binance_api_test/core/providers/equipo_seleccionado_provider.dart';
import 'package:binance_api_test/core/providers/usuarios_provider.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/views/actividades/actividades_view.dart';
import 'package:binance_api_test/views/selector/selector_view.dart';
import 'package:binance_api_test/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends custom_base.BaseViewModel {
  final _navigationService = locator<NavigatorService>();
  final _autenticationClient = locator<AuthenticationClient>();
  final _authenticationAPI = locator<AuthenticationApi>();
  final GlobalKey<FormState> formKey = GlobalKey();
  EquiposAsignadosDB equiposAsignadosDB = EquiposAsignadosDB();
  EquiposDB equiposDB = EquiposDB();

  bool _loading = false;
  TextEditingController tcEmail = TextEditingController();
  TextEditingController tcPassword = TextEditingController();
  bool obscurePassword = true;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loading = true;
      var providerUsuarios =
          Provider.of<UsuariosProvider>(context, listen: false);
      var providerEquipoUsuario =
          Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
      var resp = await _authenticationAPI.signIn(
        usuario: tcEmail.text,
        clave: tcPassword.text,
        usuariosData: providerUsuarios.usuarios,
      );
      if (resp is UsuariosData) {
        _autenticationClient.isLogged = true;
        _autenticationClient.saveUsuario(resp);
        EquiposAsignadosResponse asignados =
            await equiposAsignadosDB.selectAll();
        notifyListeners();
        loading = false;
        if (asignados.data.isNotEmpty &&
            asignados.data.any((element) =>
                (element.idUsuario.toString() == resp.id &&
                    isSameDate(DateTime.now(),
                        DateTime.parse(element.fechaAsignacion))))) {
          var asignado = asignados.data.firstWhere((element) =>
              (element.idUsuario.toString() == resp.id &&
                  isSameDate(DateTime.now(),
                      DateTime.parse(element.fechaAsignacion))));
          providerEquipoUsuario.setLabor(labor: asignado.labor);
          await equiposDB.selectById(asignado.idEquipo).then((value) {
            providerEquipoUsuario.setEquipo(equipo: value!);
          });
          _navigationService
              .navigateToPageAndRemoveUntil(ActividadesView.routeName);
        } else {
          _navigationService
              .navigateToPageAndRemoveUntil(SelectorView.routeName);
        }
      } else if (resp is Failure) {
        loading = false;
        notifyListeners();
        Dialogs.error(
          msg: resp.message,
        );
      }
    }
  }

  void changeObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /*  void goToRecoveryPassword() {
    _navigationService.navigateToPage(RecoveryPasswordView.routeName);
  } */

  @override
  void dispose() {
    tcEmail.dispose();
    tcPassword.dispose();
    super.dispose();
  }
}
