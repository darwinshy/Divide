import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'name_screen_viewmodel.dart';
import '../../../widgets/reusables.dart';
import '../../../app/size_configuration.dart';
import '../../../theme/theme.dart';

class NameScreenView extends StatelessWidget {
  static const routeName = "/nameScreenView";

  const NameScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NameViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: buildAppBar(context),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: SizeConfig.screenHeight! * 0.8,
                child: Form(
                  key: model.nameFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Divide",
                        style: GoogleFonts.anton(
                            color: Colors.teal,
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(60),
                      ),
                      const Text(
                        "Tell us your name",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      TextFormField(
                        maxLength: 30,
                        validator: (value) => model.validateName(value!),
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(
                            "Name",
                            Icon(
                              Icons.account_circle,
                              color: primaryColor,
                            )),
                        controller: model.name,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      const Text(
                        "Enter your UPI address",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      TextFormField(
                        maxLength: 30,
                        validator: (value) => model.validateName(value!),
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(
                            "UPI Address",
                            Icon(
                              Icons.attach_money_rounded,
                              color: primaryColor,
                            )),
                        controller: model.name,
                      ),
                      const Spacer(),
                      buildOutlineButton("Continue", model.saveName),
                      SizedBox(
                        height: getProportionateScreenHeight(60),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        );
      },
      viewModelBuilder: () => NameViewModel(),
    );
  }
}
