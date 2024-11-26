library home_view;

import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/progress_widget.dart';
import 'package:binance_api_test/widgets/tap_to_hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/global_drawer_widget.dart';
import 'actividades_view_model.dart';

part 'actividades_mobile.dart';

class ActividadesView extends StatelessWidget {
  static const routeName = 'actividades';
  const ActividadesView({super.key});

  @override
  Widget build(BuildContext context) {
    /*  var menu = Provider.of<MenuProvider>(context, listen: false).menu; */
    ActividadesViewModel viewModel = ActividadesViewModel();
    return ViewModelBuilder<ActividadesViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onViewModelReady: (viewModel) => viewModel.onInit(context),
        builder: (context, viewModel, child) {
          return _ActividadesMobile(viewModel);
        });
  }
}
