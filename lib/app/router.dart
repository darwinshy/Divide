// This files contains all the routes of the app
// Simply add a Material Route Constructor with Classname and Routename
// and run the below command
// flutter pub run build_runner build --delete-conflicting-outputs

import 'package:auto_route/auto_route.dart';

import 'package:divide/screens/nameScreen/name_screenview.dart';
import 'package:divide/screens/root/root_view.dart';
import 'package:divide/screens/signUpScreens/otpScreen/otp_screenview.dart';
import 'package:divide/screens/signUpScreens/phoneNumberScreen/phone_screenview.dart';
import 'package:divide/screens/welcomeScreen/welcome_screenview.dart';
import 'package:stacked/stacked_annotations.dart';

// _____________________________________________________________________________

@StackedApp(routes: [
  // ___________________________________________________________________________
  StackedRoute(path: Root.routeName, page: Root, initial: true),
  // ___________________________________________________________________________
  StackedRoute(path: PhoneScreenView.routeName, page: PhoneScreenView),
  // ___________________________________________________________________________
  StackedRoute(path: OTPScreenView.routeName, page: OTPScreenView),
  // ___________________________________________________________________________
  StackedRoute(path: NameScreenView.routeName, page: NameScreenView),
  // ___________________________________________________________________________
  StackedRoute(path: WelcomeScreenView.routeName, page: WelcomeScreenView),
  // ___________________________________________________________________________
])
class $Router {}
