import 'package:binance_api_test/core/api/autentication_api.dart';
import 'package:binance_api_test/core/api/core/constants.dart';
import 'package:binance_api_test/core/api/core/http.dart';
import 'package:binance_api_test/core/authentication_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logger.dart';
import 'services/navigator_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static final Logger _log = getLogger('LocatorInjector');

  static Future<void> setupLocator() async {
    _log.d('Initializing Navigator Service');
    locator.registerLazySingleton(() => NavigatorService());
  }
}

abstract class DependencyInjection {
  static Future<void> initialize() async {
    final Dio dio = Dio(BaseOptions(baseUrl: server));
    Logger logger = Logger();
    Http http = Http(dio: dio, logger: logger, logsEnabled: true);
    final storage = await SharedPreferences.getInstance();
    final authenticationClient = AuthenticationClient(storage);
    final authenticationAPI = AuthenticationApi(http);

    locator.registerSingleton<AuthenticationClient>(authenticationClient);
    locator.registerSingleton<AuthenticationApi>(authenticationAPI);
  }
}
