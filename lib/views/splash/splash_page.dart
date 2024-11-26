import 'package:binance_api_test/views/auth/login/login_view.dart';
import 'package:binance_api_test/views/selector/selector_view.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const route = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    move();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/app.png',
                height: MediaQuery.of(context).size.height * .70,
                width: MediaQuery.of(context).size.width * .70),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> move() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }
}
