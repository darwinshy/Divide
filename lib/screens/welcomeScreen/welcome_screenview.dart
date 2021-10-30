import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/reusables.dart';
import '../../app/size_configuration.dart';
import 'welcome_screenview_model.dart';

class WelcomeScreenView extends StatelessWidget {
  static const routeName = "/welcomeScreenView";

  const WelcomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeScreenViewModel>.reactive(
      builder: (context, model, child) {
        return !model.isBusy
            ? Scaffold(
                appBar: buildAppBar(context),
                body: SafeArea(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: SizeConfig.screenHeight! * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(50),
                          ),
                          const Text(
                            "Welcome",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(50),
                          ),
                          Text(
                            model.data!["name"]!,
                            style: const TextStyle(fontSize: 26),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                          const Spacer(),
                          buildOutlineButton("Dashboard", () {}),
                        ],
                      ),
                    ),
                  ),
                )),
              )
            : Scaffold(
                appBar: buildAppBar(context),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
      viewModelBuilder: () => WelcomeScreenViewModel(),
    );
  }
}
