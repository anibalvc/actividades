import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/global_drawer_widget.dart';
import 'package:binance_api_test/widgets/global_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPageWidget extends StatelessWidget {
  const AuthPageWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlobalDrawerDartDesktop(
        notify: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Inicio de sesión',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 25),
                  child: SvgPicture.asset(
                    "assets/icons/user-circle.svg",
                    height: 80,
                    width: 80,
                    color: Colors.white,
                  ),
                ),
                Center(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
