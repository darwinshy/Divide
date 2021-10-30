import 'package:divide/app/size_configuration.dart';
import 'package:divide/screens/root/root_view_model.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

class Root extends StatelessWidget {
  static const routeName = "/root";

  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<RootViewModel>.reactive(
      builder: (context, child, model) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
      onModelReady: (model) => model.handleStartupLogic(),
      viewModelBuilder: () => RootViewModel(),
    );
  }
}
