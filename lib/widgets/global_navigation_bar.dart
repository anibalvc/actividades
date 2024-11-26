import 'package:binance_api_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';

class GlobalNavigationBar extends StatelessWidget {
  GlobalNavigationBar({super.key, required this.index});

  final _navigationService = locator<NavigatorService>();
  final int index;
  @override
  Widget build(BuildContext context) {
    return GNav(
        backgroundColor: AppColors.white,
        activeColor: AppColors.blueNoticias,
        tabBackgroundColor: AppColors.white,
        padding: const EdgeInsets.all(7),
        gap: 8,
        selectedIndex: index,
        textStyle: const TextStyle(color: Colors.white),
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Inicio",
            onPressed: () {
              _navigationService.navigateToPageAndRemoveUntil("home");
            },
          ),
          GButton(
            icon: Icons.gamepad,
            text: "Jugadores",
            onPressed: () {
              _navigationService.navigateToPageAndRemoveUntil("jugadores");
            },
          ),
          GButton(
            icon: Icons.groups,
            text: "Equipos",
            onPressed: () {
              _navigationService.navigateToPageAndRemoveUntil("equipos");
            },
          ),
          GButton(
            icon: Icons.calendar_month_outlined,
            text: "Calendario",
            onPressed: () {
              _navigationService.navigateToPageAndRemoveUntil("calendario");
            },
          ),
        ]);
  }
}
