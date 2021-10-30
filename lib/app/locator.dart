import 'package:divide/services/services/api_service.dart';
import 'package:divide/services/services/auth_service.dart';
import 'package:divide/services/services/data_from_api_service.dart';
import 'package:divide/services/services/helper_data_service.dart';
import 'package:divide/services/services/local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

@injectable
void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  // Services
  locator.registerLazySingleton(() => NavigationService());

  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => APIServices());
  locator.registerLazySingleton(() => BottomSheetService());
  // Data
  locator.registerLazySingleton(() => DataFromApi());
  // Helper Data Service (Data inside these classes changes with respect to UI)
  locator.registerLazySingleton(() => HelperBucket());
}
