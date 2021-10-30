import 'package:divide/services/services/data_from_api_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../services/services/auth_service.dart';
import '../../../app/locator.dart';
import '../../../services/services/local_storage.dart';

class PhoneViewModel extends BaseViewModel {
  // __________________________________________________________________________
  // Locating the Dependencies
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final StorageService _storageService = locator<StorageService>();
  final DataFromApi _dataFromApiService = locator<DataFromApi>();
  // __________________________________________________________________________
  // Controller and Variables
  TextEditingController phoneNumber = TextEditingController();
  final phoneNumberFormKey = GlobalKey<FormState>();
  // __________________________________________________________________________
  // Validators

  String? validatePhoneNumber(String phone) {
    return phone.isEmpty
        ? "Phone number cannot be empty"
        : phone.length == 10
            ? null
            : "Phone number should be 10 digits";
  }

  // __________________________________________________________________________
  // Helper Functions
  void startVerifyPhoneAuthentication() async {
    phoneNumberFormKey.currentState!.save();
    if (!phoneNumberFormKey.currentState!.validate()) return;
    setBusy(true);
    await _storageService.setPhoneNumber(int.parse(phoneNumber.text));
    await verifyPhoneAuthentication("+91" + phoneNumber.text);
    setBusy(false);
  }

  Future verifyPhoneAuthentication(String phone) async =>
      await _authenticationService.verifyPhoneNumber(phone);

  // __________________________________________________________________________
}
