import 'package:divide/app/locator.dart';
import 'package:divide/app/router.router.dart';
import 'package:divide/screens/root/root_view.dart';
import 'package:divide/widgets/dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'theme/theme.dart';
import 'services/services/local_storage.dart';
import 'app/router.router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await StorageService().initLocalStorages();

  setupLocator();
  setupDialogUi();
  runApp(const MyApp());
}

String mainLogo = "asset/images/logo.png";
String subLogo = "asset/images/sublogo.png";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: Root.routeName,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: router.StackedRouter().onGenerateRoute,
    );
  }
}
