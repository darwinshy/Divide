import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'bill_screen_viewmodel.dart';
import '../../../widgets/reusables.dart';
import '../../../app/size_configuration.dart';

class BillView extends StatelessWidget {
  static const routeName = "/billView";

  const BillView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BillViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: !model.isBusy
                  ? buildSimpleOutlineButton(
                      "Save", () => model.saveBill(context))
                  : buildOutlineButtonWithLoader(),
            ),
          ),
          appBar: buildAppBar(context),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: model.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.bill!.billName!,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Amount : " + model.bill!.amount!.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () => model.selectFriends(context),
                            icon: const Icon(Icons.add_box_sharp)),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.bill!.users!.length,
                        itemBuilder: (builder, index) {
                          return ListTile(
                            title: Text(model.bill!.users![index].name!),
                            subtitle: Text(
                                model.amount[model.bill!.users![index].sId] ??
                                    "0"),
                            trailing: SizedBox(
                              width: 100,
                              // height: 50,
                              child: TextFormField(
                                maxLength: 3,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                decoration:
                                    buildSimpleInputDecoration("%share"),
                                controller:
                                    model.mp[model.bill!.users![index].sId],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          )),
        );
      },
      onModelReady: (model) => model.handleStartupLogic(),
      viewModelBuilder: () => BillViewModel(),
    );
  }
}
