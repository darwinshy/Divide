import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'phone_screenview_model.dart';
import '../../../theme/theme.dart';
import '../../../widgets/reusables.dart';
import '../../../app/size_configuration.dart';

class PhoneScreenView extends StatelessWidget {
  static const routeName = "/phoneScreenView";

  const PhoneScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhoneViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: buildAppBar(context),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: SizeConfig.screenHeight! * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    const Text(
                      "Welcome,",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(50),
                    ),
                    const Text(
                      "Please enter your mobile number",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Form(
                        key: model.phoneNumberFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          validator: (value) =>
                              model.validatePhoneNumber(value!),
                          maxLength: 10,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          keyboardType: TextInputType.phone,
                          decoration: buildInputDecoration(
                              "Mobile Number",
                              Icon(
                                Icons.mobile_friendly_sharp,
                                color: primaryColor,
                              )),
                          controller: model.phoneNumber,
                        )),
                    Spacer(),
                    !model.isBusy
                        ? buildOutlineButton(
                            "Continue", model.startVerifyPhoneAuthentication)
                        : buildOutlineButtonCustomWidget(
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenHeight(20),
                                  vertical: 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("    "),
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      backgroundColor: white,
                                    ),
                                  ),
                                  const Text("    "),
                                  SizedBox(
                                    width: getProportionateScreenWidth(10),
                                  ),
                                ],
                              ),
                            ),
                            null),
                    SizedBox(
                      height: getProportionateScreenHeight(60),
                    ),
                    const Text(
                      "by clicking on continue, you are indicating that you have read and agree to our terms of use & privacy policy",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ))),
          );
        },
        viewModelBuilder: () => PhoneViewModel());
  }
}
