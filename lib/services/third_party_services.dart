import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'services/data_from_api_service.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/local_storage.dart';
// import '../model/clinicEmployee.dart';
// import '../model/clinic.dart';

abstract class ThirdPartyServicesModule {
  @lazySingleton
  // __________________________________________________________________________
  // ---------------------------------------------------
  // Data Services
  // ---------------------------------------------------
  // Data coming and saved from the API in the local
  DataFromApi get dataFromApi;
  // ---------------------------------------------------
  // Data stored in cache/local storage
  StorageService get localStorageService;
  // ---------------------------------------------------
  // Navigation Services
  NavigationService get navigationService;
  // ---------------------------------------------------
  // Authentication Services
  // ---------------------------------------------------
  AuthenticationService get authenticationService;
  // ---------------------------------------------------
  // Utility Services
  // ---------------------------------------------------
  APIServices get aPIServices;
  DialogService get dialogService;
  SnackbarService get snackbarService;
  BottomSheetService get bottomSheetService;
  // ---------------------------------------------------
  // __________________________________________________________________________
}
