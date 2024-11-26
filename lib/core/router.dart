import 'package:binance_api_test/views/actividades/actividades_view.dart';
import 'package:binance_api_test/views/auth/login/login_view.dart';
import 'package:binance_api_test/views/detalles_equipo/detalles_equipo_view.dart';
import 'package:binance_api_test/views/formulario/formulario_view.dart';
import 'package:binance_api_test/views/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../views/selector/selector_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SelectorView.routeName:
      return MaterialPageRoute(builder: (context) => const SelectorView());

    case SplashPage.route:
      return MaterialPageRoute(builder: (context) => const SplashPage());

    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());

    case FormularioView.routeName:
      return MaterialPageRoute(builder: (context) => const FormularioView());

    case ActividadesView.routeName:
      return MaterialPageRoute(builder: (context) => const ActividadesView());

    case DetallesEquipoView.routeName:
      return MaterialPageRoute(
          builder: (context) => const DetallesEquipoView());
    default:
      return MaterialPageRoute(builder: (context) => const LoginView());
  }
}
