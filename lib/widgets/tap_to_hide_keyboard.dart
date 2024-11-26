import 'package:flutter/material.dart';

class MyTapToHideKeyboard extends StatelessWidget {
  const MyTapToHideKeyboard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
