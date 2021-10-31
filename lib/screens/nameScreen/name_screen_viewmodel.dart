import 'dart:developer';

import 'package:divide/model/user.dart';
import 'package:divide/screens/root/root_view.dart';
import 'package:divide/screens/welcomeScreen/welcome_screenview.dart';
import 'package:divide/services/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/services/local_storage.dart';
import '../../../app/locator.dart';

class NameViewModel extends BaseViewModel {
  // _________________________________________________________________________
  // Locating the Dependencies
  final NavigationService _navigatorService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final APIServices _aPIServices = locator<APIServices>();
  // _________________________________________________________________________
  // Controllers
  TextEditingController name = TextEditingController();
  TextEditingController upi = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // _________________________________________________________________________
  //Validating entered Name

  String? validateName(String value) {
    return value.isEmpty
        ? "Cannot be empty"
        : value.length > 2
            ? null
            : "Should be atleast 3 characters long";
  }

  // _________________________________________________________________________
  // Saving Name
  void saveName() async {
    setBusy(true);
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) return;

    await _storageService.setName(name.text);
    await _storageService.setUPI(upi.text);

    User? user = await _aPIServices.createUser();

    if (user != null) {
      _storageService.setUID(user.sId!);
      _navigatorService.clearStackAndShow(Root.routeName);
    }
    setBusy(false);
  }

  // _________________________________________________________________________
}
