library login_view;

import 'package:binance_api_test/core/locator.dart';
import 'package:binance_api_test/core/services/navigator_service.dart';
import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/app_buttons.dart';
import 'package:binance_api_test/widgets/app_textfield.dart';
import 'package:binance_api_test/widgets/progress_widget.dart';
import 'package:binance_api_test/widgets/tap_to_hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/app_obscure_text_icon.dart';
import '../widgets/auth_page_widget.dart';
import 'login_view_model.dart';

part 'login_mobile.dart';

class LoginView extends StatelessWidget {
  static const routeName = 'login';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = LoginViewModel();
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onViewModelReady: (viewModel) {
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _LoginMobile(viewModel);
        });
  }
}
