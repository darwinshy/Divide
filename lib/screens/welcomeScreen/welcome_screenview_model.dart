import 'package:divide/app/size_configuration.dart';
import 'package:divide/model/user.dart';
import 'package:divide/screens/addBills/addbills_screenview.dart';
import 'package:divide/screens/billView/bill_screenview.dart';
import 'package:divide/services/services/api_service.dart';
import 'package:divide/services/services/auth_service.dart';
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

class WelcomeScreenViewModel extends FutureViewModel<Map<String, dynamic>> {
  // __________________________________________________________________________
  // Locating the Dependencies
  final NavigationService _navigatorService = locator<NavigationService>();
  final SnackbarService _snackBarService = locator<SnackbarService>();
  final StorageService _storageService = locator<StorageService>();
  final DataFromApi _dataFromApi = locator<DataFromApi>();
  final APIServices _aPIServices = locator<APIServices>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  // __________________________________________________________________________
  // Variables
  TextEditingController phoneNumber = TextEditingController();
  final phoneNumberFormKey = GlobalKey<FormState>();
  bool isAddingFriends = false;
  bool isBillLoading = false;

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
  Future<Map<String, dynamic>> futureToRun() async {
    try {
      return {
        "name": _storageService.getName!,
        "bills": _dataFromApi.getUser!.bills!
      };
    } catch (e) {
      _snackBarService.showSnackbar(message: e.toString());
    }
    throw UnimplementedError("Error occured on the welcome screen");
  }
  // __________________________________________________________________________

  void openFriendsList(BuildContext ctx) {
    List<Friends> friends = _dataFromApi.getUser!.friends!;
    // signOut();
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              child: SizedBox.expand(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: friends.length,
                      itemBuilder: (builder, index) =>
                          buildFreindList(friends, index))),
            ));
  }

  Widget buildFreindList(List<Friends> friends, int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black87),
      child: ExpansionTile(
        title: Text(friends[index].name!,
            style: const TextStyle(color: Colors.white, fontSize: 24)),
        subtitle: Text(friends[index].upiId!,
            style: const TextStyle(color: Colors.white, fontSize: 12)),
        collapsedIconColor: Colors.white,
        children: [
          Text(friends[index].phone!.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 20))
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
          height: getProportionateScreenHeight(300),
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
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              !isAddingFriends
                  ? buildSimpleOutlineButton(
                      "Add friend", startVerifyPhoneAndAddFriend)
                  : buildOutlineButtonWithLoader(),
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

  void startVerifyPhoneAndAddFriend() async {
    isAddingFriends = !isAddingFriends;
    phoneNumberFormKey.currentState!.save();
    if (!phoneNumberFormKey.currentState!.validate()) {
      isAddingFriends = !isAddingFriends;
      return;
    }
    await _aPIServices.addFriend(phoneNumber.text);
    isAddingFriends = !isAddingFriends;

    _navigatorService.popRepeated(1);
  }

  void navigateToAddBill() {
    _navigatorService.navigateTo(AddBillView.routeName);
  }

  void signOut() {
    _authenticationService.signOut();
  }

  void goToBillDetails(String s) async {
    try {
      isBillLoading = !isBillLoading;
      await _dataFromApi.setBill(s);
      await _dataFromApi.setBillStatus(_dataFromApi.getUser!.sId!, s);
      isBillLoading = !isBillLoading;
      _navigatorService.navigateTo(BillView.routeName);
    } catch (e) {
      _snackBarService.showSnackbar(message: e.toString());
    }
  }
  // __________________________________________________________________________
}
