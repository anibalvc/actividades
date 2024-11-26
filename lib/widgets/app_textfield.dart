import 'package:binance_api_test/theme/theme.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? iconButton;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Color? colorError;
  const AppTextField({
    required this.text,
    required this.controller,
    this.validator,
    this.colorError,
    this.obscureText,
    this.iconButton,
    this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .6,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          controller: controller,
          cursorColor: AppColors.blue,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.blue,
              ),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
              isDense: true,
              errorStyle: const TextStyle(color: AppColors.binanceYellow),
              contentPadding:
                  const EdgeInsets.only(top: 10, bottom: 5, left: 10),
              fillColor: AppColors.white,
              hintText: text,
              alignLabelWithHint: true,
              filled: true,
              hintStyle: const TextStyle(
                color: AppColors.blue,
                fontSize: 15,
              ),
              suffixIcon: iconButton),
          obscureText: obscureText ?? false,
        ),
      ),
    );
  }
}
