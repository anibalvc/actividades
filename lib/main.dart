import 'package:binance_api_test/core/locator.dart';
import 'package:binance_api_test/core/providers.dart';
import 'package:binance_api_test/core/router.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/views/splash/splash_page.dart';
import 'package:binance_api_test/widgets/no_scale_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  /* Quitar barra de notificaciones */
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  //initializeDateFormatting('es');
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  await DependencyInjection.initialize();
  runApp(const MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        title: 'Test',
        debugShowCheckedModeBanner: false,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: SplashPage.route,
        theme: myTheme,
        localizationsDelegates: GlobalMaterialLocalizations.delegates
        //GlobalWidgetsLocalizations.delegate,
        //GlobalCupertinoLocalizations.delegate,
        ,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es'),
        ],
        builder: (context, child) {
          return NoScaleTextWidget(
            child: child!,
          );
        },
      ),
    );
  }
}
