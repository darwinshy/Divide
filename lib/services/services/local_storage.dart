import 'dart:developer';

import 'package:divide/misc/localKeys/local_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // ___________________________________________________________________________
  // User Variables and their getters
  // ...........................................................................
  static int? _phoneNumber;
  int? get getPhoneNumber => _phoneNumber;
  // ...........................................................................
  static String? _uid;
  String? get getUID => _uid;
  // ...........................................................................
  static String? _name;
  String? get getName => _name;
  // ...........................................................................
  static String? _emailAddress;
  String? get getEmailAddress => _emailAddress;
  // ...........................................................................
  // ___________________________________________________________________________
  // Assign the variables if present

  Future initLocalStorages() async {
    try {
      SharedPreferences _localStorage = await SharedPreferences.getInstance();
      // .......................................................................
      _uid = _localStorage.getString(uidLocalStorageKey);
      // ------------------------------------------------------------------
      _phoneNumber = _localStorage.getInt(phoneNumberLocalStorageKey);
      // .......................................................................
      _name = _localStorage.getString(nameLocalStorageKey);
      // .......................................................................
      _emailAddress = _localStorage.getString(emailAddressLocalStorageKey);
      // .......................................................................
    } catch (e) {
      log("Inititialising Local Storage Failed :  " + e.toString());
    }
  }

  // ___________________________________________________________________________
  // Setters into local

  Future setUID(String uid) async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    _uid = uid;
    await _localStorage.setString(uidLocalStorageKey, _uid!);
  }

  Future setName(String name) async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    _name = name;
    await _localStorage.setString(nameLocalStorageKey, _name!);
  }

  Future setPhoneNumber(int phone) async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    _phoneNumber = phone;
    await _localStorage.setInt(phoneNumberLocalStorageKey, _phoneNumber!);
  }

  Future setEmailAddress(String emailAddress) async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    _emailAddress = emailAddress;
    await _localStorage.setString(emailAddressLocalStorageKey, _emailAddress!);
  }

// ...........................................................................
  Future setUserDetails({
    required String name,
    required int phone,
    required String emailAddress,
    required String uid,
  }) async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();

    _uid = uid;
    _phoneNumber = phone;
    _emailAddress = emailAddress;
    _name = name;

    await _localStorage.setString(uidLocalStorageKey, uid);
    await _localStorage.setInt(phoneNumberLocalStorageKey, phone);
    await _localStorage.setString(emailAddressLocalStorageKey, emailAddress);
    await _localStorage.setString(nameLocalStorageKey, name);
  }

// _____________________________________________________________________________
// Individual Getters from Local
//..............................................................................
  Future<int?> getPhoneNumberFromLocal() async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    return _localStorage.getInt(phoneNumberLocalStorageKey);
  }

  Future<String?> getUIDFromLocal() async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    return _localStorage.getString(uidLocalStorageKey);
  }

  Future<String?> getNameFromLocal() async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    return _localStorage.getString(nameLocalStorageKey);
  }

// .............................................................................
// _____________________________________________________________________________
// Getter for all user details from local
  Future<Map<String, String>> getUserDetailFromLocalAsMap() async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    return {
      uidLocalStorageKey:
          _localStorage.getString(uidLocalStorageKey).toString(),
      phoneNumberLocalStorageKey:
          _localStorage.getInt(phoneNumberLocalStorageKey).toString(),
      nameLocalStorageKey: _localStorage.getString(nameLocalStorageKey)!,
      emailAddressLocalStorageKey:
          _localStorage.getString(emailAddressLocalStorageKey)!,
    };
  }

// _____________________________________________________________________________
  void clear() {
    _uid = null;
    _phoneNumber = null;
    _name = null;
    _emailAddress = null;
  }
  // ___________________________________________________________________________
}
