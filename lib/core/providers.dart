import 'package:binance_api_test/core/providers/equipo_seleccionado_provider.dart';
import 'package:binance_api_test/core/providers/usuarios_provider.dart';
import 'package:provider/single_child_widget.dart';
import 'locator.dart';
import 'services/navigator_service.dart';
import 'package:provider/provider.dart';

class ProviderInjector {
  static List<SingleChildWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];

  static final List<SingleChildWidget> _independentServices = [
    Provider.value(value: locator<NavigatorService>()),
  ];

  static final List<SingleChildWidget> _dependentServices = [];

  static final List<SingleChildWidget> _consumableServices = [
    ChangeNotifierProvider(create: (_) => EquipoSeleccionadoProvider()),
    ChangeNotifierProvider(create: (_) => UsuariosProvider()),
  ];
}
