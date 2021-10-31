import 'package:divide/model/bill.dart';
import 'package:divide/model/bill_status.dart';
import 'package:divide/model/user.dart';
import 'package:divide/screens/root/root_view.dart';
import 'package:divide/services/services/api_service.dart';
import 'package:divide/services/services/data_from_api_service.dart';
import 'package:divide/widgets/reusables.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/services/local_storage.dart';
import '../../../app/locator.dart';

class BillViewModel extends BaseViewModel {
  // _________________________________________________________________________
  // Locating the Dependencies
  final NavigationService _navigatorService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final APIServices _aPIServices = locator<APIServices>();
  final DataFromApi _dataFromApiService = locator<DataFromApi>();

  // _________________________________________________________________________
  // Controllers
  Bill? bill;
  Map<String, TextEditingController> mp = {};
  Map<String, String> amount = {};
  List<String> friendId = [];
  bool isAddingFriend = false;
  final formKey = GlobalKey<FormState>();
  // _________________________________________________________________________

  void selectFriends(BuildContext ctx) {
    List<Friends> friends = _dataFromApiService.getUser!.friends!;
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: !isAddingFriend
                            ? buildSimpleOutlineButton(
                                "Add", () => addFriendsToBill(setState))
                            : buildOutlineButtonWithLoader(),
                      )),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 10),
                    child: SizedBox.expand(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: friends.length,
                            itemBuilder: (builder, index) =>
                                buildFreindList(friends, index, setState))),
                  ),
                )));
  }

  Widget buildFreindList(
      List<Friends> friends, int index, StateSetter setState) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black87),
      child: CheckboxListTile(
        onChanged: (b) {
          if (friendId.contains(friends[index].sId!)) {
            friendId.remove(friends[index].sId!);
          } else {
            friendId.add(friends[index].sId!);
          }
          setState(() {});
        },
        value: friendId.contains(friends[index].sId!),
        title: Text(friends[index].name!,
            style: const TextStyle(color: Colors.white, fontSize: 24)),
        subtitle: Text(friends[index].upiId!,
            style: const TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }

  // _________________________________________________________________________
  // Update Bill
  void saveBill(BuildContext context) async {
    FocusScope.of(context).unfocus();
    setBusy(true);
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      setBusy(false);
      return;
    }
    Map<String, dynamic> data = {};

    data['user_id'] = _storageService.getUID;
    data['bill_id'] = bill!.sId;
    data['equalSharing'] = false;

    List<Map<String, String>> shared = [];

    mp.forEach((key, value) => shared.add({'id': key, 'share': value.text}));

    data['shares'] = shared;

    await _aPIServices.updateBill(data);
    _navigatorService.popRepeated(1);
    setBusy(false);
  }

  // _________________________________________________________________________
  // Add friend Bill

  void addFriendsToBill(StateSetter setState) async {
    setState(() {
      isAddingFriend = !isAddingFriend;
    });
    for (var fId in friendId) {
      await _aPIServices.addFriendToBill(fId, bill!.sId!);
    }
    _navigatorService.clearStackAndShow(Root.routeName);
    setState(() {
      isAddingFriend = !isAddingFriend;
    });
  }

  // _________________________________________________________________________
  handleStartupLogic() {
    bill = _dataFromApiService.getBill;

    for (var us in bill!.users!) {
      mp[us.sId!] = TextEditingController();
    }

    List<BillStatus>? billStatus = _dataFromApiService.getStatusList;

    for (var billStatus in billStatus!) {
      amount[billStatus.userId!] = billStatus.share!.toString();
    }
  }

  // _________________________________________________________________________
}
