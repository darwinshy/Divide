import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
import 'dart:async';
import '../../../services/services/auth_service.dart';
import '../../../app/locator.dart';

class OTPScreenViewModel extends BaseViewModel {
  // __________________________________________________________________________
  // Locating the Dependencies
  // final NavigationService _navigatorService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  // __________________________________________________________________________
  // Variables Initialisation
  dynamic onTapRecognizer;
  bool _hasError = false;
  String _currentText = "";
  int _otpCounter = 30;
  String? _enteredPhoneNumber;

  // __________________________________________________________________________
  // Controllers
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController otpTextController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey otpFormKey = GlobalKey<FormState>();
  // __________________________________________________________________________
  // Getters
  bool get getErrorStatus => _hasError;
  int get getOtpCount => _otpCounter;
  String? get getEnteredPhoneNumber => _enteredPhoneNumber;
  // __________________________________________________________________________
  void onComplete() async {
    _hasError = _currentText.length < 6 ? false : true;
    startVerifingOTP();
    notifyListeners();
  }

  void setCurrentText(String value) {
    _hasError = _currentText.length < 6 ? false : true;
    _currentText = value;
    notifyListeners();
  }

  void startVerifingOTP() async {
    setBusy(true);
    await _authenticationService
        .signInPhoneNumberWithOTP(otpTextController.text);
    setBusy(false);
  }

  void resendOTP() async {
    await _authenticationService.resendOTP();
  }

  // __________________________________________________________________________
  // Init State Function
  void initialise(BuildContext context) async {
    _enteredPhoneNumber = _authenticationService.getEnteredPhoneNumber;
    // __________________________________________________________
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    // Counter for 30 seconds
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpCounter != 0) {
        _otpCounter--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });

    // __________________________________________________________
  }

  // __________________________________________________________________________
  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }
}
