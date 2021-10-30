// import 'package:stacked_services/stacked_services.dart';

import 'dart:developer';

import 'package:divide/app/locator.dart';
import 'package:divide/model/bill.dart';
import 'package:divide/model/user.dart';
import 'package:divide/services/services/api_service.dart';
// import 'package:divide/services/services/local_storage.dart';

class DataFromApi {
  // ___________________________________________________________________________
  // Locating the Dependencies
  final APIServices _apiServices = locator<APIServices>();
  // final StorageService _storageService = locator<StorageService>();
  // final NavigationService _navigatorService = locator<NavigationService>();
  // ___________________________________________________________________________
  // Data to be used globally for all billed groups
  static List<Bill>? _billGroupList;
  List<Bill>? get getBillGroups => _billGroupList;
  // ___________________________________________________________________________
  // Data to be used globally for all friends
  static List<User>? _peerList;
  List<User>? get getPeerList => _peerList;
  // ___________________________________________________________________________

  // ___________________________________________________________________________
  // Helper Function
  //-------------------------------------------------------------------
  Future setBillGroupList() async {
    _billGroupList = [];
    // _billGroupList = await _apiServices.getAllClinicEmployee();
    log("All Bill Groups saved");
  }

  Future setPeerList() async {
    _peerList = [];
    // _peerList = await _apiServices.getAllDoctors();
    log("All Peer List saved");
  }
  // ___________________________________________________________________________
}
