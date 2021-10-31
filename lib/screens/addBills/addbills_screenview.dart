import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'addbills_screen_viewmodel.dart';
import '../../../widgets/reusables.dart';
import '../../../app/size_configuration.dart';
import '../../../theme/theme.dart';

class AddBillView extends StatelessWidget {
  static const routeName = "/addBillView";

  const AddBillView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddBillViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: buildAppBarWithText(context),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  // height: SizeConfig.screenHeight! * 0.8,
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bill Name",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
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
                          controller: model.bName,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        const Text(
                          "Bill Category",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        TextFormField(
                          maxLength: 30,
                          validator: (value) => model.validateName(value!),
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              "Category",
                              Icon(
                                Icons.category,
                                color: primaryColor,
                              )),
                          controller: model.bCategory,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        const Text(
                          "Amount",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        TextFormField(
                          maxLength: 30,
                          validator: (value) => model.validateName(value!),
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          decoration: buildInputDecoration(
                              "Amount",
                              Icon(
                                Icons.monetization_on_rounded,
                                color: primaryColor,
                              )),
                          controller: model.bAmount,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        const Text(
                          "Bill Due date",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => model.validateDate(),
                          onTap: () => model.selectAssignedDate(context),
                          controller: model.bDueDate,
                          readOnly: true,
                          keyboardType: TextInputType.datetime,
                          decoration: buildInputDecoration(
                              "Select Date",
                              Icon(
                                Icons.calendar_today,
                                color: primaryColor,
                              )),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        const Text(
                          "Partition Type",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Center(
                          child: ToggleSwitch(
                            minWidth: getProportionateScreenWidth(150),
                            initialLabelIndex: 0,
                            activeBgColor: [offWhite],
                            activeFgColor: offWhite2,
                            inactiveBgColor: offWhite2,
                            inactiveFgColor: offBlack2,
                            activeBgColors: const [
                              [Colors.blue],
                              [Colors.pink]
                            ],
                            labels: const ['EQUAL', 'UNEQUAL'],
                            onToggle: (index) => {
                              index == 0
                                  ? model.setPartitionValue("EQUAL")
                                  : model.setPartitionValue("UNEQUAL")
                            },
                            totalSwitches: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: !model.isBusy
                    ? buildOutlineButton("Add Bill", model.saveBill)
                    : buildOutlineButtonWithLoader(),
              )),
        );
      },
      viewModelBuilder: () => AddBillViewModel(),
    );
  }
}
