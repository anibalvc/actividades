import 'package:binance_api_test/theme/theme.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final bool opacity;
  const ProgressWidget({
    this.opacity = true,
    required this.child,
    required this.inAsyncCall,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: inAsyncCall,
      blurEffectIntensity: 8,
      progressIndicator: const CircularProgressIndicator(),
      opacity: opacity ? 0.3 : 1.0,
      color: AppColors.blueScaffold,
      child: child,
    );
  }
}
