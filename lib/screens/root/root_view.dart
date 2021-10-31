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
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Center(child: CircularProgressIndicator()),
                Column(
                  children: const [
                    Text("made by"),
                    SizedBox(height: 20),
                    Text(
                      "Shashwat Priyadarshy",
                      style: TextStyle(letterSpacing: 3),
                    ),
                    Text(
                      "Daniyal Mahmood",
                      style: TextStyle(letterSpacing: 3),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      onModelReady: (model) => model.handleStartupLogic(),
      viewModelBuilder: () => RootViewModel(),
    );
  }
}
