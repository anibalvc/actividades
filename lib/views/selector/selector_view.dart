library home_view;

import 'package:binance_api_test/theme/theme.dart';
import 'package:binance_api_test/widgets/progress_widget.dart';
import 'package:binance_api_test/widgets/tap_to_hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/global_drawer_widget.dart';
import 'selector_view_model.dart';

part 'selector_mobile.dart';

class SelectorView extends StatelessWidget {
  static const routeName = 'selector';
  const SelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    /*  var menu = Provider.of<MenuProvider>(context, listen: false).menu; */
    SelectorViewModel viewModel = SelectorViewModel();
    return ViewModelBuilder<SelectorViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onViewModelReady: (viewModel) => viewModel.onInit(context),
        builder: (context, viewModel, child) {
          return _SelectorMobile(viewModel);
        });
  }
}
