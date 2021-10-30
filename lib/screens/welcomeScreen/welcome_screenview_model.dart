import 'package:divide/services/services/data_from_api_service.dart';
import 'package:divide/services/services/local_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';

class WelcomeScreenViewModel extends FutureViewModel<Map<String, String>> {
  // __________________________________________________________________________
  // Locating the Dependencies
  final NavigationService _navigatorService = locator<NavigationService>();
  final SnackbarService _snackBarService = locator<SnackbarService>();
  final StorageService _storageService = locator<StorageService>();
  final DataFromApi _dataFromApiService = locator<DataFromApi>();

  // __________________________________________________________________________
  // Streams/Futures
  @override
  Future<Map<String, String>> futureToRun() async {
    try {
      return {
        "name": _storageService.getName!,
      };
    } catch (e) {
      _snackBarService.showSnackbar(message: e.toString());
    }
    throw UnimplementedError("Error occured on the welcome screen");
  }
  // __________________________________________________________________________

  void navigateToHomePageView() {}
  // __________________________________________________________________________
}
