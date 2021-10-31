import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:divide/model/bill.dart';
import 'package:divide/model/bill_status.dart';
import 'package:divide/services/services/data_from_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';

import 'local_storage.dart';
import '../../app/locator.dart';

import 'package:divide/model/user.dart';

class APIServices {
  // ___________________________________________________________________________
  // Variables for API
  String url = "https://divide.azurewebsites.net/";
  // String url = "http://divide.eastus.cloudapp.azure.com:3000/";
  // -------------------------------------------------------------
  // User
  String urlUserCreate = "users/newUser";
  String urlUserAddFriend = "users/addFriend/";
  String urlUserDetails = "users/details/";
  // -------------------------------------------------------------
  // Bill
  String urlGetAllBillsByUserID = "bills/";
  String urlBillCreate = "bills/addBill";
  String urlBillAddUser = "bills/addUser";
  String urlBillDetails = "bills/details/";

  String urlBillStatus = "billStatus/";
  String urlBillStatusUpdate = "billStatus/update";
  // ---------------------------------------------------------------------------
  // Create a new user
  Future<User?> createUser() async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      var uri = Uri.parse('$url$urlUserCreate');
      log('AT CREATE USER HITTING : ' + uri.toString());
      var request = http.Request("POST", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      request.body = jsonEncode({
        'name': _storageService.getName,
        'phone': _storageService.getPhoneNumber,
        'upi_id': _storageService.getUpiId,
      });

      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);
      // _______________________________________________________________________
      log("User created with user id : " + responseJson["_id"].toString());
      // _______________________________________________________________________
      User user = User.fromJson(responseJson);
      log(user.toJson().toString());

      // _______________________________________________________________________
      return user;
    } catch (e) {
      log("AT CREATE USER : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Add a new friend
  Future<User?> addFriend(String phone) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    final DataFromApi _dataFromApi = locator<DataFromApi>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      String? uid = _storageService.getUID;
      var uri = Uri.parse('$url$urlUserAddFriend$uid');
      log('AT ADD FRIEND HITTING : ' + uri.toString());
      var request = http.Request("POST", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      request.body = jsonEncode({'phone': phone});

      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);
      // _______________________________________________________________________
      log("User Friend added with user id : " + responseJson.toString());
      // _______________________________________________________________________
      User user = User.fromJson(responseJson);
      _dataFromApi.setUserExplicit(user);
      // _______________________________________________________________________
      return user;
    } catch (e) {
      log("AT ADD FRIEND : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Add a new friend
  Future addFriendToBill(String friendId, String billId) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    final DataFromApi _dataFromApi = locator<DataFromApi>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      String addUser = "/addUser";
      var uri = Uri.parse('$url$urlGetAllBillsByUserID$billId$addUser');
      log('AT ADD FRIEND TO BILL HITTING : ' + uri.toString());
      var request = http.Request("POST", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      request.body = jsonEncode({'friend_id': friendId});

      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);
      // _______________________________________________________________________
      log("AT ADD FRIEND TO BILL : " + responseJson.toString());
      // _______________________________________________________________________
      return;
    } catch (e) {
      log("AT ADD FRIEND TO BILL : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Add a new bill
  Future<Bill?> addBill(
      {required String billName,
      required int billAmount,
      required DateTime billDate,
      required String billCategory,
      required bool billShare}) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    final DataFromApi _dataFromApi = locator<DataFromApi>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      String? uid = _storageService.getUID;
      var uri = Uri.parse('$url$urlBillCreate');
      log('AT ADD BILL HITTING : ' + uri.toString());
      var request = http.Request("POST", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      request.body = jsonEncode({
        'user_id': uid,
        'bill_name': billName,
        'amount': billAmount,
        'due_date': billDate.toString(),
        'category': billCategory,
        'equalSharing': billShare
      });

      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);
      // _______________________________________________________________________
      log("AT ADD BILL : " + responseJson.toString());

      // _______________________________________________________________________
      return Bill.fromJson(responseJson);
    } catch (e) {
      log("AT ADD BILL : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

// ---------------------------------------------------------------------------
  // Add a new bill
  Future<List<BillStatus>?> getBillStatus(String userId, String billId) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    final DataFromApi _dataFromApi = locator<DataFromApi>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      var uri = Uri.parse('$url$urlBillStatus');
      log('AT GET BILLSTATUS HITTING : ' + uri.toString());
      var request = http.Request("GET", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      request.body = jsonEncode({'bill_id': billId});
      log('AT GET BILLSTATUS HITTING : ' + request.body);
      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      log(responseString);
      var responseJson = json.decode(responseString);

      // _______________________________________________________________________
      log("AT GET BILLSTATUS : " + responseJson.toString());

      List<BillStatus>? billStatusList = responseJson
          .map<BillStatus>((json) => BillStatus.fromJson(json))
          .toList();

      return billStatusList;
      // _______________________________________________________________________

    } catch (e) {
      log("AT GET BILLSTATUS : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // update bill
  Future updateBill(Map<String, dynamic> data) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    final DataFromApi _dataFromApi = locator<DataFromApi>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      var uri = Uri.parse('$url$urlBillStatusUpdate');
      log('AT UPDATE BILL HITTING : ' + uri.toString());
      var request = http.Request("POST", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      request.body = jsonEncode(data);

      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();

      // _______________________________________________________________________
      log("AT UPDATE BILL : " + response.statusCode.toString());
      return;
      // _______________________________________________________________________

    } catch (e) {
      log("AT UPDATE BILL : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return;
    }
  }

  Future<Bill?> getBill(String billId) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    final DataFromApi _dataFromApi = locator<DataFromApi>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      var uri = Uri.parse('$url$urlBillDetails$billId');
      log('AT GET BILL HITTING : ' + uri.toString());
      var request = http.Request("GET", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);
      // _______________________________________________________________________
      log("AT GET BILL : " + responseJson.toString());
      // _______________________________________________________________________
      return Bill.fromJson(responseJson);
    } catch (e) {
      log("AT GET BILL : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Fetches data from the api by using user Id
  Future<User?> getUser(String? uid) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final SnackbarService _snackBarService = locator<SnackbarService>();

    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      var getUri = Uri.parse('$url$urlUserDetails$uid');
      log('AT GET USER BY ID HITTING : ' + getUri.toString());
      // _______________________________________________________________________
      // Creating get requests
      var getRequest = http.Request("GET", getUri);
      // _______________________________________________________________________
      // Receiving the JSON response
      var getResponse = await getRequest.send();
      var getClinicResponseString = await getResponse.stream.bytesToString();
      var getResponseJson = json.decode(getClinicResponseString);
      return User.fromJson(getResponseJson);
    } catch (e) {
      log("AT GET USER BY ID : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }
}
