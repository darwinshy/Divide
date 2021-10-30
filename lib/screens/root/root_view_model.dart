import 'dart:developer';

import 'package:divide/screens/nameScreen/name_screenview.dart';
import 'package:divide/screens/signUpScreens/phoneNumberScreen/phone_screenview.dart';
import 'package:divide/screens/welcomeScreen/welcome_screenview.dart';
import 'package:divide/services/services/data_from_api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/services/local_storage.dart';
import '../../../app/locator.dart';
import '../../../services/services/auth_service.dart';

class RootViewModel extends BaseViewModel {
  // __________________________________________________________________________
  // Locating the Dependencies
  final NavigationService _navigatorService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final StorageService _storageService = locator<StorageService>();
  final DataFromApi _dataFromApiService = locator<DataFromApi>();
  final SnackbarService _snackBarService = locator<SnackbarService>();

  // __________________________________________________________________________
  // Reroutes the user

  Future handleStartupLogic() async {
    try {
      // ---------------------------------------------------------------------
      // Check whether user has logged in or not
      var hasLoggedIn = await _authenticationService.isUserLoggedIn();
      // ---------------------------------------------------------------------

      await _storageService.initLocalStorages();

      log("*----------------------------------------------------------------*");
      log("Name         : " + _storageService.getName.toString());
      log("Phone        : " + _storageService.getPhoneNumber.toString());
      log("Email        : " + _storageService.getEmailAddress.toString());
      log("HasLoggedIn  : " + hasLoggedIn.toString());
      log("*----------------------------------------------------------------*");
      // ---------------------------------------------------------------------
      if (hasLoggedIn) {
        if (_storageService.getName == null) {
          // ___________________________________________________________________
          _navigatorService.clearStackAndShow(NameScreenView.routeName);
          // ___________________________________________________________________
        } else {
          // ___________________________________________________________________
          await _dataFromApiService.setBillGroupList();
          await _dataFromApiService.setPeerList();
          // ___________________________________________________________________
          _navigatorService.pushNamedAndRemoveUntil(WelcomeScreenView.routeName,
              predicate: (_) => false);
        }
      } else {
        _navigatorService.pushNamedAndRemoveUntil(PhoneScreenView.routeName,
            predicate: (_) => false);
      }
    } catch (e) {
      log("At Handle Startup Logic : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
    }
  }
}
