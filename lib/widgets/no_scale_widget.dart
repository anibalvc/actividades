import 'dart:math' as math;

import 'package:flutter/material.dart';

class NoScaleTextWidget extends StatelessWidget {
  final Widget child;

  const NoScaleTextWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaxScaleTextWidget(
      max: 0.95,
      child: child,
    );
  }
}

class MaxScaleTextWidget extends StatelessWidget {
  final double max;
  final Widget child;

  const MaxScaleTextWidget({
    super.key,
    this.max = 1.2,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    var scale = math.min(max, data.textScaleFactor);
    return MediaQuery(
      data: data.copyWith(textScaler: TextScaler.linear(scale)),
      child: child,
    );
  }
}
