import 'dart:developer';

import 'package:divide/screens/nameScreen/name_screenview.dart';
import 'package:divide/screens/root/root_view.dart';
import 'package:divide/screens/signUpScreens/phoneNumberScreen/phone_screenview.dart';
import 'package:divide/screens/welcomeScreen/welcome_screenview.dart';
import 'package:divide/services/services/api_service.dart';
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
  final APIServices _aPIServices = locator<APIServices>();
  // __________________________________________________________________________
  // Reroutes the user

  Future handleStartupLogic() async {
    try {
      setBusy(false);
      // ---------------------------------------------------------------------
      // Check whether user has logged in or not
      var hasLoggedIn = await _authenticationService.isUserLoggedIn();
      var isServerUp = await _aPIServices.pingServer();

      if (!isServerUp) {
        setBusy(true);
        return;
      }
      // ---------------------------------------------------------------------

      await _storageService.initLocalStorages();

      log("*----------------------------------------------------------------*");
      log("ID           : " + _storageService.getUID.toString());
      log("Name         : " + _storageService.getName.toString());
      log("Phone        : " + _storageService.getPhoneNumber.toString());
      log("UpiID        : " + _storageService.getUpiId.toString());
      log("HasLoggedIn  : " + hasLoggedIn.toString());
      log("*----------------------------------------------------------------*");
      // ---------------------------------------------------------------------
      if (hasLoggedIn) {
        if (_storageService.getName == null &&
            _storageService.getUpiId == null) {
          // ___________________________________________________________________
          _navigatorService.clearStackAndShow(NameScreenView.routeName);
          // ___________________________________________________________________
        } else {
          // ___________________________________________________________________
          await _dataFromApiService.setUser();
          // ___________________________________________________________________
          _navigatorService.clearStackAndShow(WelcomeScreenView.routeName);
        }
      } else {
        _navigatorService.clearStackAndShow(PhoneScreenView.routeName);
      }
    } catch (e) {
      log("At Handle Startup Logic : " + e.toString());
      // _snackBarService.showSnackbar(message: e.toString());
      setBusy(true);
    }
  }

  void refresh() {
    _navigatorService.clearStackAndShow(Root.routeName);
  }
}
