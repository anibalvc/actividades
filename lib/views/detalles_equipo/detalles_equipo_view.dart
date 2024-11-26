library home_view;

import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/progress_widget.dart';
import 'package:binance_api_test/widgets/tap_to_hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/global_drawer_widget.dart';
import 'detalles_equipo_view_model.dart';

part 'detalles_equipo_mobile.dart';

class DetallesEquipoView extends StatelessWidget {
  static const routeName = 'detalles_equipo';
  const DetallesEquipoView({super.key});

  @override
  Widget build(BuildContext context) {
    /*  var menu = Provider.of<MenuProvider>(context, listen: false).menu; */
    DetallesEquipoViewModel viewModel = DetallesEquipoViewModel();
    return ViewModelBuilder<DetallesEquipoViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onViewModelReady: (viewModel) => viewModel.onInit(context),
        builder: (context, viewModel, child) {
          return _DetallesEquipoMobile(viewModel);
        });
  }
}
