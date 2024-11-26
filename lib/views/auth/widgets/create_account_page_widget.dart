import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/global_navigation_bar.dart';
import 'package:flutter/material.dart';

class CreateAccountPageWidget extends StatelessWidget {
  const CreateAccountPageWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GlobalNavigationBar(
          index: 0,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Registrate en Test',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(child: Center(child: child)),
          ),
        ],
      ),
    );
  }
}
