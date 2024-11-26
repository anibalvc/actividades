import 'dart:convert';
import 'dart:io';

import 'package:binance_api_test/core/authentication_client.dart';
import 'package:binance_api_test/core/base/base_view_model.dart';
import 'package:binance_api_test/core/database/tables/equipos_table.dart';
import 'package:binance_api_test/core/models/equipos_response.dart';
import 'package:binance_api_test/core/providers/equipo_seleccionado_provider.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/app_dialogs.dart';
import 'package:binance_api_test/widgets/app_qr_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../core/locator.dart';

class SelectorViewModel extends BaseViewModel {
  final authenticationClient = locator<AuthenticationClient>();
  final listController = ScrollController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _navigationService = locator<NavigatorService>();
  List<String> minas = ["Mina Norte", "Mina Sur", "Mina Este", "Mina Oeste"];
  EquiposDB equiposDB = EquiposDB();

  bool _loading = false;
  bool isLogged = false;

  NavigatorService get navigator => _navigationService;

  final logger = Logger();

  List<EquiposData> equiposList = [];
  SelectorViewModel();

  GlobalKey<ScaffoldState> get drawerKey => _drawerKey;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> onInit(BuildContext context) async {
    loading = true;
    await loadEquipos();
    notifyListeners();
    loading = false;
  }

  void scanQrCode(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => QRViewExample(
        onQrCodeScanned: (String qrData) {
          List<String> qrDataList = qrData.split(",");
          if (qrDataList.length == 2 &&
              equiposList.any((element) => element.id == qrDataList[0]) &&
              minas.any((element) => element == qrDataList[1])) {
            final equipoId = qrDataList[0];
            final mina = qrDataList[1];
            Navigator.of(context).pop();
            showBottomDialog(
                context,
                equiposList.firstWhere((element) => element.id == equipoId),
                mina);
          } else {
            Navigator.of(context).pop();
            Dialogs.error(msg: "QR inválido");
          }
        },
      ),
    ));
  }

  void showBottomDialog(
      BuildContext context, EquiposData equipo, String nombreMina) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading:
                  const Icon(Icons.remove_red_eye_sharp, color: AppColors.blue),
              title: const Text('Mostrar detalles del equipo',
                  style: TextStyle(color: AppColors.blue)),
              onTap: () {
                Navigator.of(context).pop();
                showEquipoDetailsDialog(context, equipo);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_document, color: AppColors.blue),
              title: const Text('Llenar formulario',
                  style: TextStyle(color: AppColors.blue)),
              onTap: () {
                Navigator.of(context).pop();
                goToFormulario(equipo, nombreMina, context);
              },
            ),
          ],
        );
      },
    );
  }

  void showEquipoDetailsDialog(BuildContext context, EquiposData equipo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Detalles del Equipo',
            style:
                TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Nombre: ${equipo.nombre}',
                  style: const TextStyle(color: AppColors.blue)),
              const SizedBox(height: 8.0),
              Text('Código: ${equipo.codigo}',
                  style: const TextStyle(color: AppColors.blue)),
              const SizedBox(height: 8.0),
              Text('Horómetro: ${equipo.valorHorometro}',
                  style: const TextStyle(color: AppColors.blue)),
              const SizedBox(height: 8.0),
              Text('Subequipos: ${equipo.subequipos.join(", ")}',
                  style: const TextStyle(color: AppColors.blue)),
              const SizedBox(height: 8.0),
              Text('Fecha de Actualización: ${equipo.fechaActualizacion}',
                  style: const TextStyle(color: AppColors.blue)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cerrar', style: TextStyle(color: AppColors.blue)),
            ),
          ],
        );
      },
    );
  }

  Future<void> loadEquipos() async {
    final equipos = await equiposDB.selectAll();
    equiposList = equipos.data;
    notifyListeners();
  }

  void goToFormulario(
      EquiposData equipo, String? nombreMina, BuildContext context) {
    var providerEquipoSeleccionado =
        Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
    providerEquipoSeleccionado.setEquipo(equipo: equipo);
    providerEquipoSeleccionado.setNombreMina(nombreMina: nombreMina ?? "");
    _navigationService.navigateToPage("formulario");
  }
}
