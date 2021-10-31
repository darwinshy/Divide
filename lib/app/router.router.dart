// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../screens/addBills/addbills_screenview.dart';
import '../screens/nameScreen/name_screenview.dart';
import '../screens/root/root_view.dart';
import '../screens/signUpScreens/otpScreen/otp_screenview.dart';
import '../screens/signUpScreens/phoneNumberScreen/phone_screenview.dart';
import '../screens/welcomeScreen/welcome_screenview.dart';

class Routes {
  static const String root = '/root';
  static const String phoneScreenView = '/phoneScreenView';
  static const String oTPScreenView = '/otpScreenView';
  static const String nameScreenView = '/nameScreenView';
  static const String welcomeScreenView = '/welcomeScreenView';
  static const String addBillView = '/addBillView';
  static const all = <String>{
    root,
    phoneScreenView,
    oTPScreenView,
    nameScreenView,
    welcomeScreenView,
    addBillView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.root, page: Root),
    RouteDef(Routes.phoneScreenView, page: PhoneScreenView),
    RouteDef(Routes.oTPScreenView, page: OTPScreenView),
    RouteDef(Routes.nameScreenView, page: NameScreenView),
    RouteDef(Routes.welcomeScreenView, page: WelcomeScreenView),
    RouteDef(Routes.addBillView, page: AddBillView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    Root: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const Root(),
        settings: data,
      );
    },
    PhoneScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PhoneScreenView(),
        settings: data,
      );
    },
    OTPScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const OTPScreenView(),
        settings: data,
      );
    },
    NameScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NameScreenView(),
        settings: data,
      );
    },
    WelcomeScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const WelcomeScreenView(),
        settings: data,
      );
    },
    AddBillView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddBillView(),
        settings: data,
      );
    },
  };
}
