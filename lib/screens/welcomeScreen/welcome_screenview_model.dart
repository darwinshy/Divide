import 'package:divide/app/size_configuration.dart';
import 'package:divide/screens/addBills/addbills_screenview.dart';
import 'package:divide/services/services/data_from_api_service.dart';
import 'package:divide/services/services/local_storage.dart';
import 'package:divide/theme/theme.dart';
import 'package:divide/widgets/reusables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';

class WelcomeScreenViewModel extends FutureViewModel<Map<String, String>> {
  // __________________________________________________________________________
  // Locating the Dependencies
  final NavigationService _navigatorService = locator<NavigationService>();
  final SnackbarService _snackBarService = locator<SnackbarService>();
  final StorageService _storageService = locator<StorageService>();
  final DataFromApi _dataFromApiService = locator<DataFromApi>();
  // __________________________________________________________________________
  // Variables
  TextEditingController phoneNumber = TextEditingController();
  final phoneNumberFormKey = GlobalKey<FormState>();

  String? validatePhoneNumber(String phone) {
    return phone.isEmpty
        ? "Phone number cannot be empty"
        : phone.length == 10
            ? null
            : "Phone number should be 10 digits";
  }

  // __________________________________________________________________________
  // Streams/Futures
  @override
  Future<Map<String, String>> futureToRun() async {
    try {
      return {
        "name": _storageService.getName!,
      };
    } catch (e) {
      _snackBarService.showSnackbar(message: e.toString());
    }
    throw UnimplementedError("Error occured on the welcome screen");
  }
  // __________________________________________________________________________

  void openFriendsList(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              child: SizedBox.expand(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (builder, index) => buildFreindList())),
            ));
  }

  Widget buildFreindList() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black87),
      child: const ExpansionTile(
        title: Text("Friend Name",
            style: TextStyle(color: Colors.white, fontSize: 24)),
        subtitle: Text("abcdefgighijkl@oksbi",
            style: TextStyle(color: Colors.white, fontSize: 12)),
        collapsedIconColor: Colors.white,
        children: [
          Text("9876543210",
              style: TextStyle(color: Colors.white, fontSize: 20))
        ],
      ),
    );
  }

// __________________________________________________________________________
  void openAddFriendPopUp(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        elevation: 0,
        context: ctx,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              child: buildAddFriendPopUp(),
            ));
  }

  Widget buildAddFriendPopUp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: getProportionateScreenHeight(250),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              const Text(
                "Please enter your friend's number",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Form(
                  key: phoneNumberFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                      validator: (value) => validatePhoneNumber(value!),
                      maxLength: 10,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      keyboardType: TextInputType.number,
                      decoration: buildInputDecoration(
                          "Mobile Number",
                          Icon(Icons.mobile_friendly_sharp,
                              color: primaryColor)),
                      controller: phoneNumber)),
              const Spacer(),
              const Text(
                "In order to add a friend, make sure they have installed the app.",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Container()
      ],
    );
  }

  // __________________________________________________________________________
  void navigateToAddBill() {
    _navigatorService.navigateTo(AddBillView.routeName);
  }

  void navigateToHomePageView() {}
  // __________________________________________________________________________
}
