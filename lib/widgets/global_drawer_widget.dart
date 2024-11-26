import 'dart:convert';

import 'package:binance_api_test/core/authentication_client.dart';
import 'package:binance_api_test/core/providers/equipo_seleccionado_provider.dart';
import 'package:binance_api_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';

class GlobalDrawerDartDesktop extends StatelessWidget {
  GlobalDrawerDartDesktop({super.key, required this.notify});

  final _navigationService = locator<NavigatorService>();
  final _autenticationClient = locator<AuthenticationClient>();

  final getIt = GetIt.instance;
  final void Function() notify;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var providerEquipoSeleccionado =
        Provider.of<EquipoSeleccionadoProvider>(context, listen: false);
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(25))),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                  )),
              height: size.height * .27,
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  if (_autenticationClient.isLogged) ...[
                    Positioned(
                      top: 10,
                      child: SvgPicture.asset(
                        "assets/icons/user-circle.svg",
                        height: 80,
                        width: 80,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: size.width > 370 ? 90 : 70,
                      child: TextButton(
                          child: Text(
                            _autenticationClient.loadUsuario.nombrePerfil,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white),
                          ),
                          onPressed: () {
                            _navigationService
                                .navigateToPageAndRemoveUntil("perfil");
                          }),
                    ),
                    Positioned(
                      top: size.width > 370 ? 130 : 110,
                      child: ElevatedButton(
                          onPressed: () {
                            _navigationService
                                .navigateToPageAndRemoveUntil("login");
                            _autenticationClient.clear();
                            notify();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            "Cerrar Sesión",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    )
                  ] else ...[
                    Positioned(
                      top: size.width > 370 ? 30 : 10,
                      child: SvgPicture.asset(
                        "assets/icons/user-circle.svg",
                        height: 80,
                        width: 80,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: size.width > 370 ? 130 : 110,
                      child: ElevatedButton(
                          onPressed: () {
                            _navigationService.navigateToPage("login");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blue),
                          )),
                    )
                  ]
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  /* Opciones del menu */
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(children: [
                      if (providerEquipoSeleccionado
                          .equipoSeleccionado.id.isNotEmpty)
                        ListTile(
                          leading: const Icon(Icons.info_outline_rounded,
                              color: AppColors.blue),
                          title: const Text(
                            "Detalles del Equipo",
                            style: TextStyle(color: AppColors.blue),
                          ),
                          onTap: () {
                            _navigationService
                                .navigateToPage("detalles_equipo");
                          },
                        ),
                    ]),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "© 2024 Formulario-Test - App v1.0",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
