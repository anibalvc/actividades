import 'package:binance_api_test/theme/theme.dart';
import 'package:flutter/material.dart';

class AppObscureTextIcon extends StatelessWidget {
  const AppObscureTextIcon({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: AppColors.blue,
      ),
      onPressed: onPressed,
    );
  }
}
