// import 'package:stacked_services/stacked_services.dart';

import 'dart:developer';

import 'package:divide/app/locator.dart';
import 'package:divide/model/bill.dart';
import 'package:divide/model/bill_status.dart';
import 'package:divide/model/user.dart';
import 'package:divide/services/services/api_service.dart';
import 'package:divide/services/services/local_storage.dart';
// import 'package:divide/services/services/local_storage.dart';

class DataFromApi {
  // ___________________________________________________________________________
  // Locating the Dependencies
  final APIServices _apiServices = locator<APIServices>();
  final StorageService _storageService = locator<StorageService>();
  // final NavigationService _navigatorService = locator<NavigationService>();
  // ___________________________________________________________________________
  // Data to be used globally for users
  static User? _user;
  User? get getUser => _user;
  // ___________________________________________________________________________
  // Data to be used globally for all billed groups
  static Bill? _bill;
  Bill? get getBill => _bill;
  // ___________________________________________________________________________
  // Data to be used globally for all friends
  static List<User>? _peerList;
  List<User>? get getPeerList => _peerList;
  // ___________________________________________________________________________

  static List<BillStatus>? _statusList;
  List<BillStatus>? get getStatusList => _statusList;

  // ___________________________________________________________________________
  // Helper Function
  //-------------------------------------------------------------------
  Future setUser() async {
    String? uid = _storageService.getUID;

    if (uid != null) {
      User? user = await _apiServices.getUser(uid);
      _user = user;
      log("DATA FROM API : " + user!.toJson().toString());
    }
  }

  Future setUserExplicit(User user) async {
    _user = user;
    log("DATA FROM API : " + user.toJson().toString());
  }

  Future setBill(String billId) async {
    Bill? bill = await _apiServices.getBill(billId);
    if (bill != null) {
      _bill = bill;
      log("DATA FROM API : " + bill.toJson().toString());
    }
    // _billGroupList = await _apiServices.getAllClinicEmployee();
  }

  Future setBillStatus(String userId, String billId) async {
    List<BillStatus>? status = await _apiServices.getBillStatus(userId, billId);
    if (status != null) {
      _statusList = status;
      log("DATA FROM API : " + status.toList().toString());
    }
    // _billGroupList = await _apiServices.getAllClinicEmployee();
  }

  Future setPeerList() async {
    _peerList = [];
    // _peerList = await _apiServices.getAllDoctors();
    log("DATA FROM API : Peer List saved");
  }
  // ___________________________________________________________________________
}
