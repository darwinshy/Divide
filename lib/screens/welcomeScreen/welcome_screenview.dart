import 'package:divide/model/user.dart';
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
        if (!model.isBusy) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: buildSimpleOutlineButton("Show friends list",
                      () => model.openFriendsList(context)),
                )),
            appBar: buildAppBarWithText(context),
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
                      const Text(
                        "Welcome,",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.data != null ? model.data!["name"]! : "",
                            style: const TextStyle(fontSize: 28),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: model.navigateToAddBill,
                                child: const Text("Add Bills",
                                    style: TextStyle(color: Colors.blueGrey)),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              InkWell(
                                onTap: () => model.openAddFriendPopUp(context),
                                child: const Text("Add Friends",
                                    style: TextStyle(color: Colors.blueGrey)),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      if (model.data!["bills"] != null &&
                          model.data!["bills"]!.isNotEmpty)
                        Column(
                          children: [
                            if (model.isBillLoading)
                              const LinearProgressIndicator(
                                backgroundColor: Colors.teal,
                                minHeight: 5,
                              ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.58,
                              child: ListView.builder(
                                primary: true,
                                shrinkWrap: true,
                                itemCount: model.data!["bills"]!.length,
                                itemBuilder: (builder, index) {
                                  return Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white60),
                                      child: ListTile(
                                        onTap: () => model.goToBillDetails(
                                            (model.data!["bills"]![index]
                                                    as UserBills)
                                                .sId!),
                                        minVerticalPadding: 15,
                                        leading: const Icon(
                                            Icons.pending_actions,
                                            color: Colors.redAccent,
                                            size: 30),
                                        title: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                (model.data!["bills"]![index]
                                                        as UserBills)
                                                    .billName!,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 20)),
                                            Text(
                                                "Due date : " +
                                                    (model.data!["bills"]![
                                                            index] as UserBills)
                                                        .dueDate!
                                                        .substring(0, 10),
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 12)),
                                          ],
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                (model.data!["bills"]![index]
                                                        as UserBills)
                                                    .amount
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 20))
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ],
                        )
                      else
                        const Text("No bills found")
                    ],
                  ),
                ),
              ),
            )),
          );
        } else {
          return Scaffold(
            appBar: buildAppBar(context),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      viewModelBuilder: () => WelcomeScreenViewModel(),
    );
  }
}
