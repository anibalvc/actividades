library home_view;

import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/progress_widget.dart';
import 'package:binance_api_test/widgets/tap_to_hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/global_drawer_widget.dart';
import 'formulario_view_model.dart';

part 'formulario_mobile.dart';

class FormularioView extends StatelessWidget {
  static const routeName = 'formulario';
  const FormularioView({super.key});

  @override
  Widget build(BuildContext context) {
    /*  var menu = Provider.of<MenuProvider>(context, listen: false).menu; */
    FormularioViewModel viewModel = FormularioViewModel();
    return ViewModelBuilder<FormularioViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onViewModelReady: (viewModel) => viewModel.onInit(context),
        builder: (context, viewModel, child) {
          return _FormularioMobile(viewModel);
        });
  }
}
