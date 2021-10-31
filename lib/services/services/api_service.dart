import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:divide/model/bill.dart';
import 'package:divide/services/services/data_from_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';

import 'local_storage.dart';
import '../../app/locator.dart';

import 'package:divide/model/user.dart';

class APIServices {
  // ___________________________________________________________________________
  // Variables for API
  String url = "http://7ed9-2401-4900-3b17-cb6b-fcf1-52d6-cf1d-ab7a.ngrok.io/";
  // String url = "http://studentazure.eastus.cloudapp.azure.com:3000/";
  // -------------------------------------------------------------
  // User
  String urlUserCreate = "users/newUser";
  String urlUserAddFriend = "users/addFriend/";
  String urlUserDetails = "users/details/";
  // -------------------------------------------------------------
  // Bill
  String urlGetAllBillsByUserID = "bills/";
  String urlBillCreate = "bills/addBill";
  String urlBillAddUser = "bills/addUser";

  // ---------------------------------------------------------------------------
  // Create a new user
  Future<User?> createUser() async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      var uri = Uri.parse('$url$urlUserCreate');
      log('AT CREATE USER HITTING : ' + uri.toString());
      var request = http.Request("POST", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      request.body = jsonEncode({
        'name': _storageService.getName,
        'phone': _storageService.getPhoneNumber,
        'upi_id': _storageService.getUpiId,
      });

      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);
      // _______________________________________________________________________
      log("User created with user id : " + responseJson["_id"].toString());
      // _______________________________________________________________________
      User user = User.fromJson(responseJson);

      log(user.toJson().toString());

      _storageService.setUID(user.sId!);
      // _______________________________________________________________________
      return user;
    } catch (e) {
      log("AT CREATE USER : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Add a new friend
  Future<User?> addFriend(String phone) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    final DataFromApi _dataFromApi = locator<DataFromApi>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      String? uid = _storageService.getUID;
      var uri = Uri.parse('$url$urlUserAddFriend$uid');
      log('AT ADD FRIEND HITTING : ' + uri.toString());
      var request = http.Request("POST", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      request.body = jsonEncode({'phone': phone});

      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);
      // _______________________________________________________________________
      log("User Friend added with user id : " + responseJson.toString());
      // _______________________________________________________________________
      User user = User.fromJson(responseJson);
      _dataFromApi.setUserExplicit(user);
      // _______________________________________________________________________
      return user;
    } catch (e) {
      log("AT ADD FRIEND : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Add a new friend
  Future<Bill?> addBill(
      {required String billName,
      required int billAmount,
      required DateTime billDate,
      required String billCategory,
      required bool billShare}) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final StorageService _storageService = locator<StorageService>();
    final SnackbarService _snackBarService = locator<SnackbarService>();
    final DataFromApi _dataFromApi = locator<DataFromApi>();
    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      String? uid = _storageService.getUID;
      var uri = Uri.parse('$url$urlBillCreate');
      log('AT ADD BILL HITTING : ' + uri.toString());
      var request = http.Request("POST", uri);
      // _______________________________________________________________________
      // Preparing the data to be sent
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8',
      });

      request.body = jsonEncode({
        'user_id': uid,
        'bill_name': billName,
        'amount': billAmount,
        'due_date': billDate.toString(),
        'category': billCategory,
        'equalSharing': billShare
      });

      // _______________________________________________________________________
      // Sending the post request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);
      // _______________________________________________________________________
      log("AT ADD BILL : " + responseJson.toString());
      await _dataFromApi.setUser();
      // _______________________________________________________________________
      return Bill.fromJson(responseJson);
    } catch (e) {
      log("AT ADD BILL : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Fetches data from the api by using user Id
  Future<User?> getUser(String? uid) async {
    // _________________________________________________________________________
    // Locating Dependencies
    final SnackbarService _snackBarService = locator<SnackbarService>();

    // _________________________________________________________________________
    try {
      // _______________________________________________________________________
      // URL to be called
      var getUri = Uri.parse('$url$urlUserDetails$uid');
      log('AT GET USER BY ID HITTING : ' + getUri.toString());
      // _______________________________________________________________________
      // Creating get requests
      var getRequest = http.Request("GET", getUri);
      // _______________________________________________________________________
      // Receiving the JSON response
      var getResponse = await getRequest.send();
      var getClinicResponseString = await getResponse.stream.bytesToString();
      var getResponseJson = json.decode(getClinicResponseString);
      log(getResponseJson.toString());
      return User.fromJson(getResponseJson);
    } catch (e) {
      log("AT GET USER BY ID : " + e.toString());
      _snackBarService.showSnackbar(message: e.toString());
      return null;
    }
  }

//   // ---------------------------------------------------------------------------
//   // Fetches clinic data from the api and saves globally
//   Future getClinicFromApiAndSetGlobally() async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final DataFromApi _dataFromApi = locator<DataFromApi>();
//     // _________________________________________________________________________
//     try {
//       _dataFromApi.setClinic(await getClinic());
//     } catch (e) {
//       print("At saving clinic globally: " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Adds a clinic customer by first fetching the complete clinic object
//   // and then checking whether the customer is already added or not. If added
//   // updates the appointment date field else creates a new customer object.
//   // Finally, prepares a modified version of the recieved clinic object and
//   // updaates via API.
//   Future<Clinic> addOrUpdateDiagnosticCustomerToClinic(bool isComplete) async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final StorageService _storageService = locator<StorageService>();
//     final PatientDetails _patientDetailservice = locator<PatientDetails>();
//     final APIServices _apiServices = locator<APIServices>();
//     final DataFromApi _dataFromApiServices = locator<DataFromApi>();
//     // _________________________________________________________________________
//     // Retreiving clinic id
//     String clinicId = _storageService.getClinicId;
//     // _________________________________________________________________________
//     try {
//       // _______________________________________________________________________
//       // URL to be called
//       var uri = Uri.parse('$url$urlClinicUpdate$clinicId');
//       // print(uri);
//       // _______________________________________________________________________
//       // Creating get requests
//       var request = new http.Request("PUT", uri);
//       // _______________________________________________________________________
//       // Clinic object from get clinic by id (API)
//       Clinic latestDoctorObjectFromApi = await _apiServices.getClinic();
//       // List of customer of the respective clinic (API)
//       List<CustomerElement> latestCustomersListFromApi =
//           latestDoctorObjectFromApi.customers;

//       String diagnosticID = _patientDetailservice.getDoctorsPatientDiagnosticID;
//       // _______________________________________________________________________
//       // Preparing the data to be sent
//       CustomerElement
//           customerDetailsWithAppointmentDateObjectToBeSentIfDoesntExist =
//           _patientDetailservice
//               .customerDetailsWithAppointmentDateObjectToBeSentIfDoesntExist(
//                   _patientDetailservice.customerDetailsToBeSentIfDoesntExist(),
//                   isComplete);
//       // _______________________________________________________________________
//       // Finding customer in the customers object of the clinic and
//       // returns the iterator
//       Iterable<CustomerElement> foundCustomer = latestCustomersListFromApi
//           .where((customer) => customer.customer.id == diagnosticID);
//       // _______________________________________________________________________
//       // Logic for updating customer object of doctor
//       if (foundCustomer.isEmpty) {
//         // If not found add the "customerObjectToBeSentIfDoesntExist" to latest
//         // customer list and covert all the customer to jsonobject
//         latestCustomersListFromApi
//             .add(customerDetailsWithAppointmentDateObjectToBeSentIfDoesntExist);
//         // ________________________________________________________
//         var object = [];
//         latestCustomersListFromApi
//             .forEach((customer) => object.add(customer.toJson()));
//         request.body = jsonEncode({'customers': object});
//         // ________________________________________________________
//       } else {
//         // If found update the appointment date where Customer ID is same as
//         // diagnostic id and covert all the customer to jsonobject
//         latestCustomersListFromApi
//             .where((customer) => customer.customer.id == diagnosticID)
//             .forEach((customer) {
//           customer.appointmentDate.add(AppointmentDate(
//               id: _patientDetailservice.getAppointmentID,
//               date: _patientDetailservice.getDoctorsPatientSelectedDate,
//               isCompleted: 0));
//         });
//         // ________________________________________________________
//         var object = [];
//         latestCustomersListFromApi
//             .forEach((customer) => object.add(customer.toJson()));
//         request.body = jsonEncode({'customers': object});
//       }

//       // _______________________________________________________________________
//       // Preparing the headers
//       request.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });
//       // print(request.body);
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // print(responseJson);
//       _dataFromApiServices.setClinic(Clinic.fromJson(responseJson));

//       // _______________________________________________________________________
//       print("Clinic Customer added to " + responseJson["_id"].toString());
//       // _______________________________________________________________________
//       return Clinic.fromJson(responseJson);
//     } catch (e) {
//       print("At add clinic customer : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // This function add a clinic object to clinics feild of doctors object
//   // Note : There is no doctors feild in clinic model
//   Future addOrUpdateClinicToDoctorById(String id) async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final StorageService _storageService = locator<StorageService>();
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final DataFromApi _dataFromApiService = locator<DataFromApi>();
//     // _________________________________________________________________________
//     try {
//       String clinicId = _storageService.getClinicId;
//       // URL to be called
//       var uri = Uri.parse('$url$updateDoctor/$id');
//       // Creating a get request

//       Doctor latestDoctorFromApi = await getDoctorById(id);
//       List<ClinicElement> latestClinicListFromDoctors =
//           latestDoctorFromApi.clinics;

//       ClinicElement clinicIfDoesntExist = ClinicElement(
//           clinic: ClinicClinic(
//               id: _storageService.getClinicId,
//               name: _storageService.getClinicName,
//               phoneNumber: _storageService.getPhoneNumber.toString()));

//       Iterable<ClinicElement> foundClinic = latestClinicListFromDoctors
//           .where((clinic) => clinic.clinic.id == clinicId);

//       if (foundClinic.isEmpty)
//         latestClinicListFromDoctors.add(clinicIfDoesntExist);

//       var object = [];

//       if (latestClinicListFromDoctors.length != 1) {
//         latestClinicListFromDoctors.forEach((clinic) {
//           if (clinic.clinic.id == clinicId)
//             object.add(clinic.toJsonForPut());
//           else
//             object.add(clinic.toJson());
//         });
//       } else
//         object.add(latestClinicListFromDoctors.first.toJsonForPut());

//       var request = new http.Request("PUT", uri);

//       request.body = jsonEncode({'clinics': object});

//       request.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // _______________________________________________________________________
//       // Refetch the updated doctors list from the API
//       await _dataFromApiService.setDoctorsList();
//       await _dataFromApiService.setDoctorsListForClinic();
//       // _______________________________________________________________________
//       return doctorFromJson(json.encode(responseJson));
//     } catch (e) {
//       print("At add doctors to clinic by Id " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ***************************************************************************
//   // ***************************************************************************
//   // Fetches all doctors from the API and stores in data services class
//   Future<List<Doctor>> getAllDoctors() async {
//     // _______________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final DataFromApi _dataFromApiService = locator<DataFromApi>();
//     // _______________________________________________________________________
//     try {
//       // URL to be called
//       var uri = Uri.parse('$url$urlGetDoctors');
//       // Creating a get request
//       var request = new http.Request("GET", uri);
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);

//       // _______________________________________________________________________
//       // Serializing Json to Doctor Class
//       List<Doctor> dlist = [];
//       Map<String, Doctor> dmap = {};

//       responseJson.forEach((doctor) {
//         Doctor x = doctorFromJson(json.encode(doctor));
//         dlist.add(x);
//         dmap[x.id] = x;
//       });

//       await _dataFromApiService.setDoctorsListMapped(dmap);

//       // _______________________________________________________________________
//       return dlist;
//     } catch (e) {
//       print("At get all doctors : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return [];
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Fetches a doctor from the api using id
//   Future<Doctor> getDoctorById(String id) async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     // _________________________________________________________________________
//     try {
//       // URL to be called
//       var uri = Uri.parse('$url$urlGetDoctorByID/$id');
//       // Creating a get request
//       var request = new http.Request("GET", uri);
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // _______________________________________________________________________
//       return Doctor.fromJson(responseJson);
//     } catch (e) {
//       print("At get doctors by Id " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------

//   Future<Doctor> addOrUpdateDiagnosticCustomersToDoctor(
//       String id, bool isComplete) async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     // final StorageService _storageService = locator<StorageService>();
//     final PatientDetails _patientDetailservice = locator<PatientDetails>();
//     final APIServices _apiServices = locator<APIServices>();
//     // final DataFromApi _dataFromApiServices = locator<DataFromApi>();
//     // _________________________________________________________________________
//     try {
//       // _______________________________________________________________________
//       // URL to be called
//       var uri = Uri.parse('$url$updateDoctor/$id');
//       // print(uri);
//       // _______________________________________________________________________
//       // Creating get requests
//       var request = new http.Request("PUT", uri);
//       // _______________________________________________________________________
//       // Diagnostic Customer ID
//       String diagnosticID = _patientDetailservice.getDoctorsPatientDiagnosticID;
//       // Clinic object from get clinic by id (API)
//       Doctor latestDoctorObjectFromApi = await _apiServices.getDoctorById(id);
//       // List of customer of the respective clinic (API)
//       List<CustomerElement> latestCustomersListFromApi =
//           latestDoctorObjectFromApi.customers;
//       // _______________________________________________________________________
//       // Preparing the data to be sent

//       CustomerElement
//           customerDetailsWithAppointmentDateObjectToBeSentIfDoesntExist =
//           _patientDetailservice
//               .customerDetailsWithAppointmentDateObjectToBeSentIfDoesntExist(
//                   _patientDetailservice.customerDetailsToBeSentIfDoesntExist(),
//                   isComplete);
//       // _______________________________________________________________________
//       // Finding customer in the customers object of the clinic and
//       // returns the iterator
//       Iterable<CustomerElement> foundCustomer = latestCustomersListFromApi
//           .where((customer) => customer.customer.id == diagnosticID);
//       // _______________________________________________________________________
//       // Logic for updating customer object of doctor
//       if (foundCustomer.isEmpty) {
//         // If not found add the "customerObjectToBeSentIfDoesntExist" to latest
//         // customer list and covert all the customer to jsonobject
//         latestCustomersListFromApi
//             .add(customerDetailsWithAppointmentDateObjectToBeSentIfDoesntExist);
//         // ________________________________________________________
//         var object = [];
//         latestCustomersListFromApi
//             .forEach((customer) => object.add(customer.toJson()));
//         request.body = jsonEncode({'customers': object});
//         // ________________________________________________________
//       } else {
//         // If found update the appointment date where Customer ID is same as
//         // diagnostic id and covert all the customer to jsonobject
//         latestCustomersListFromApi
//             .where((customer) => customer.customer.id == diagnosticID)
//             .forEach((customer) {
//           customer.appointmentDate.add(AppointmentDate(
//               id: _patientDetailservice.getAppointmentID,
//               date: _patientDetailservice.getDoctorsPatientSelectedDate,
//               isCompleted: 0));
//         });
//         // ________________________________________________________
//         var object = [];
//         latestCustomersListFromApi
//             .forEach((customer) => object.add(customer.toJson()));
//         request.body = jsonEncode({'customers': object});
//       }

//       // _______________________________________________________________________

//       request.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });
//       // print(request.body);
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // print(responseJson);
//       // _______________________________________________________________________
//       print("Doctor Customer added to : " + responseJson["_id"].toString());
//       // _______________________________________________________________________
//       return Doctor.fromJson(responseJson);
//     } catch (e) {
//       print("At add doctor customer : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ***************************************************************************
//   // ***************************************************************************

//   // ---------------------------------------------------------------------------
//   // Fetches diagnostic customer data from the api by using customer phone
//   Future<DiagnosticCustomer> getDiagnosticCustomerByPhone(String phone) async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     // final StorageService _storageService = locator<StorageService>();
//     // _________________________________________________________________________
//     try {
//       // _______________________________________________________________________
//       // URL to be called
//       var getDiagnosticCustomerUri =
//           Uri.parse('$url$urlGetDiagnosticCustomerByPhone$phone');
//       // print(getDiagnosticCustomerUri);
//       // _______________________________________________________________________
//       // Creating get requests
//       var getDiagnosticCustomerRequest =
//           new http.Request("GET", getDiagnosticCustomerUri);
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var getDiagnosticCustomerResponse =
//           await getDiagnosticCustomerRequest.send();
//       var getDiagnosticCustomerResponseString =
//           await getDiagnosticCustomerResponse.stream.bytesToString();
//       var getDiagnosticCustomerResponseJson =
//           json.decode(getDiagnosticCustomerResponseString);
//       if (getDiagnosticCustomerResponseString.length == 2) return null;

//       return DiagnosticCustomer.fromJson(getDiagnosticCustomerResponseJson[0]);
//     } catch (e) {
//       print("At get diagnostic customer by phone : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   Future addDiagnosticCustomer() async {
//     // _______________________________________________________________________
//     // Locating Dependencies

//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final PatientDetails _patientDetailservice = locator<PatientDetails>();
//     // _______________________________________________________________________
//     try {
//       // URL to be called
//       var uri = Uri.parse('$url$urlDiagnosticCustomerCreate');

//       // Creating a get request
//       // var request = new http.MultipartRequest("PUT", uri);
//       var request = new http.Request("POST", uri);
//       request.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });
//       // _______________________________________________________________________
//       // Preparing the data to be sent
//       request.body = jsonEncode({
//         'name': _patientDetailservice.getDoctorsPatientName(),
//         'phoneNumber': _patientDetailservice.getDoctorsPatientPhoneNumber(),
//         // 'customers.customer.email':,
//         'gender': _patientDetailservice.getDoctorsPatientGender(),
//         'dob': _patientDetailservice.getDoctorsPatientDob().toString(),
//         'address.state': _patientDetailservice.getDoctorsPatientStateName(),
//         'address.city': _patientDetailservice.getDoctorsPatientCityName(),
//         'address.pincode': _patientDetailservice.getDoctorsPatientPinCode(),
//         'address.homeAddress':
//             _patientDetailservice.getDoctorsPatientHomeAddress(),
//         'bloodGroup': _patientDetailservice.getDoctorsPatientBloodGroup(),
//       });
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // _______________________________________________________________________
//       // Refetch the updated doctors list from the API
//       print("Added new Diagnostic Customer: " +
//           responseJson["diagnosticCustomer"]["_id"]);

//       _patientDetailservice.setDoctorsPatientDiagnosticID(
//           responseJson["diagnosticCustomer"]["_id"]);

//       // _______________________________________________________________________
//     } catch (e) {
//       print("At Add Diagnostic Customer " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Fetches all diagnostic customers from the API
//   Future getAllDiagnosticCustomers() async {
//     // _______________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final DataFromApi _dataFromApi = locator<DataFromApi>();
//     // _______________________________________________________________________
//     try {
//       // URL to be called
//       var uri = Uri.parse('$url$urlGetAllDiagnosticCustomers');
//       // Creating a get request
//       var request = new http.Request("GET", uri);
//       // _______________________________________________________________________

//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);

//       // _______________________________________________________________________
//       // Serializing Json to DiagnosticCustomer Class
//       List<DiagnosticCustomer> dgncstlist = [];
//       Map<String, DiagnosticCustomer> customerAndDetailsMapping = {};

//       responseJson.forEach((dgncst) {
//         DiagnosticCustomer x = diagnosticCustomerFromJson(json.encode(dgncst));
//         dgncstlist.add(x);
//         customerAndDetailsMapping[x.id] = x;
//       });

//       await _dataFromApi
//           .setDiagnosticCustomersMappedList(customerAndDetailsMapping);

//       // _______________________________________________________________________
//       return dgncstlist;
//     } catch (e) {
//       print("At get all diagnostic customer : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return [];
//     }
//   }

//   // ---------------------------------------------------------------------------

//   Future updateAppointmentInDiagnosticCustomer() async {
//     // _________________________________________________________________________
//     // Locating Dependencies

//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final PatientDetails _patientDetailservice = locator<PatientDetails>();
//     final APIServices _apiServices = locator<APIServices>();
//     final StorageService _storageService = locator<StorageService>();

//     // _________________________________________________________________________
//     //
//     try {
//       // _______________________________________________________________________
//       // Variables to be used
//       String diagnostisId = _patientDetailservice.getDoctorsPatientDiagnosticID;
//       String clinicId = _storageService.getClinicId;
//       String selectedDoctorId =
//           _patientDetailservice.getDoctorsPatientSelectedDoctor.id;
//       // _______________________________________________________________________
//       // URL to be called
//       var uri = Uri.parse('$url$urlUpdateDiagnosticCustomer/$diagnostisId');
//       // _______________________________________________________________________
//       // Creating a get request
//       var request = new http.Request("PUT", uri);
//       // _______________________________________________________________________
//       // Latest details of Diagnostic Customers fetched by ID (API)
//       DiagnosticCustomer latestDiagnosticCustomerObjectFromApi =
//           await _apiServices.getDiagnoticCustomerById(diagnostisId);
//       // _______________________________________________________________________
//       // List of Appointments from the doctors object of Diagnostic Customers(API)
//       List<DoctorObject> latestDoctorsAppointmentListFromApi =
//           latestDiagnosticCustomerObjectFromApi.doctors;
//       // _______________________________________________________________________
//       DoctorObject appointmentObjectIfDoesntExist = DoctorObject(
//           visitingDate: [
//             AppointmentDate(
//                 id: _patientDetailservice.getAppointmentID,
//                 date: _patientDetailservice.getDoctorsPatientSelectedDate,
//                 isCompleted: 0)
//           ],
//           clinic: ObjectWithID(id: clinicId),
//           doctor: ObjectWithID(
//               id: _patientDetailservice.getDoctorsPatientSelectedDoctor.id));
//       // _______________________________________________________________________
//       // Check whether a an appointment this doctor is already exists or not
//       Iterable<DoctorObject> foundAppointment =
//           latestDoctorsAppointmentListFromApi.where((appointmentObject) =>
//               (appointmentObject.clinic.id == clinicId &&
//                   appointmentObject.doctor.id == selectedDoctorId));
//       // _______________________________________________________________________
//       // Logical for searching
//       if (foundAppointment.isEmpty)
//         latestDoctorsAppointmentListFromApi.add(appointmentObjectIfDoesntExist);
//       else
//         latestDoctorsAppointmentListFromApi
//             .where((appointmentObject) =>
//                 (appointmentObject.clinic.id == clinicId &&
//                     appointmentObject.doctor.id == selectedDoctorId))
//             .first
//             .visitingDate
//             .add(AppointmentDate(
//                 id: _patientDetailservice.getAppointmentID,
//                 date: _patientDetailservice.getDoctorsPatientSelectedDate,
//                 isCompleted: 0));
//       // _______________________________________________________________________
//       // Preparing the data to be sent
//       var object = [];
//       latestDoctorsAppointmentListFromApi
//           .forEach((apt) => object.add(apt.toJson()));

//       request.body = jsonEncode({'doctors': object});
//       // print(request.body);

//       request.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });

//       // _______________________________________________________________________
//       // Receiving the JSON response

//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // _______________________________________________________________________
//       print("Update Appointment to diagnotic customer: " +
//           responseJson['_id'].toString());

//       // _______________________________________________________________________
//     } catch (e) {
//       print("At Update appointment to diagnostic customer :" + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }
//   // ---------------------------------------------------------------------------

//   Future<DiagnosticCustomer> getDiagnoticCustomerById(String id) async {
//     // _______________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     // _______________________________________________________________________
//     try {
//       // URL to be called
//       var uri = Uri.parse('$url$urlUpdateDiagnosticCustomer/$id');
//       // Creating a get request
//       var request = new http.Request("GET", uri);
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // print(responseJson);
//       // _______________________________________________________________________
//       return DiagnosticCustomer.fromJson(responseJson);
//     } catch (e) {
//       print("At get diagnotic customer by Id " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

// // ---------------------------------------------------------------------------
//   Future updateAppoinment() async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final DataFromApi _dataFromApiServices = locator<DataFromApi>();
//     final PatientDetails _patientDetailservice = locator<PatientDetails>();
//     final DoctorAppointments _doctorAppointmentservice =
//         locator<DoctorAppointments>();
//     // final StorageService _storageService = locator<StorageService>();
//     // _________________________________________________________________________
//     try {
//       Clinic clinic = _dataFromApiServices.getClinic;
//       Doctor doctor = _doctorAppointmentservice.getSelectedDoctor;
//       DiagnosticCustomer diagnosticCustomer =
//           _doctorAppointmentservice.getSelectedDiagnosticCustomer;
//       AppointmentDate appointmentDateObject = _doctorAppointmentservice
//               .getAppointmentCorrespondingToSelectedCustomers[
//           diagnosticCustomer.id];

//       // _______________________________________________________________________
//       // Uri

//       var uriUpdateClinic = Uri.parse('$url$urlClinicUpdate${clinic.id}');
//       var uriUpdateDoctor = Uri.parse('$url$updateDoctor/${doctor.id}');
//       var uriUpdateDiagnosticCustomer = Uri.parse(
//           '$url$urlUpdateDiagnosticCustomer/${diagnosticCustomer.id}');

//       // print(uriUpdateClinic);
//       // print(uriUpdateDoctor);
//       // print(uriUpdateDiagnosticCustomer);
//       // _______________________________________________________________________
//       // Requests
//       var requestUriUpdateClinic = new http.Request("PUT", uriUpdateClinic);
//       var requestUriUpdateDoctor = new http.Request("PUT", uriUpdateDoctor);
//       var requestUriUpdateDiagnosticCustomer =
//           new http.Request("PUT", uriUpdateDiagnosticCustomer);
//       // _______________________________________________________________________
//       //  Fetching doctor, clinic, diagnostic customer
//       Clinic latestClinicFromApi = await getClinic();
//       Doctor latestDoctorFromApi = await getDoctorById(doctor.id);
//       DiagnosticCustomer latestDiagnosticCustomerObjectFromApi =
//           await getDiagnoticCustomerById(diagnosticCustomer.id);
//       // _______________________________________________________________________
//       // Extracting object to be updated
//       List<CustomerElement> latestCustomersListFromApiClinic =
//           latestClinicFromApi.customers;
//       List<CustomerElement> latestCustomersListFromApiDoctor =
//           latestDoctorFromApi.customers;
//       List<DoctorObject> latestDoctorsAppointmentListFromApiCustomer =
//           latestDiagnosticCustomerObjectFromApi.doctors;
//       // _______________________________________________________________________
//       // Finding the required object
//       var clinicObject = [];
//       Iterable<CustomerElement> foundCustomerClinic =
//           latestCustomersListFromApiClinic.where(
//               (customer) => customer.customer.id == diagnosticCustomer.id);

//       for (int i = 0; i < foundCustomerClinic.length; i++) {
//         for (int j = 0;
//             j < foundCustomerClinic.elementAt(i).appointmentDate.length;
//             j++) {
//           var aptDate =
//               foundCustomerClinic.elementAt(i).appointmentDate.elementAt(j);

//           if (aptDate.id == appointmentDateObject.id) {
//             foundCustomerClinic.elementAt(i).appointmentDate[j] =
//                 AppointmentDate(
//                     id: aptDate.id,
//                     isCompleted: aptDate.isCompleted,
//                     date: _patientDetailservice.getDoctorsPatientSelectedDate);
//           }
//         }
//         clinicObject.add(foundCustomerClinic.elementAt(i).toJson());
//       }

//       var doctorObject = [];
//       Iterable<CustomerElement> foundCustomerDoctor =
//           latestCustomersListFromApiDoctor.where(
//               (customer) => customer.customer.id == diagnosticCustomer.id);
//       for (int i = 0; i < foundCustomerDoctor.length; i++) {
//         for (int j = 0;
//             j < foundCustomerDoctor.elementAt(i).appointmentDate.length;
//             j++) {
//           var aptDate =
//               foundCustomerDoctor.elementAt(i).appointmentDate.elementAt(j);
//           if (aptDate.id == appointmentDateObject.id) {
//             foundCustomerDoctor.elementAt(i).appointmentDate[j] =
//                 AppointmentDate(
//                     id: aptDate.id,
//                     isCompleted: aptDate.isCompleted,
//                     date: _patientDetailservice.getDoctorsPatientSelectedDate);
//           }
//         }
//         doctorObject.add(foundCustomerDoctor.elementAt(i).toJson());
//       }

//       var diagnosticCustomerObject = [];
//       Iterable<DoctorObject> foundDoctorDiagnosticCustomer =
//           latestDoctorsAppointmentListFromApiCustomer.where(
//               (appointmentObject) =>
//                   (appointmentObject.clinic.id == clinic.id &&
//                       appointmentObject.doctor.id == doctor.id));

//       for (int i = 0; i < foundDoctorDiagnosticCustomer.length; i++) {
//         for (int j = 0;
//             j < foundDoctorDiagnosticCustomer.elementAt(i).visitingDate.length;
//             j++) {
//           var aptDate = foundDoctorDiagnosticCustomer
//               .elementAt(i)
//               .visitingDate
//               .elementAt(j);
//           if (aptDate.id == appointmentDateObject.id) {
//             foundDoctorDiagnosticCustomer.elementAt(i).visitingDate[j] =
//                 AppointmentDate(
//                     id: aptDate.id,
//                     isCompleted: aptDate.isCompleted,
//                     date: _patientDetailservice.getDoctorsPatientSelectedDate);
//           }
//         }
//         diagnosticCustomerObject
//             .add(foundDoctorDiagnosticCustomer.elementAt(i).toJson());
//       }

//       // _______________________________________________________________________
//       requestUriUpdateClinic.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });
//       requestUriUpdateDoctor.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });
//       requestUriUpdateDiagnosticCustomer.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });
//       // _______________________________________________________________________
//       //  Setting Object to send in JSON format

//       requestUriUpdateClinic.body = jsonEncode({'customers': clinicObject});

//       requestUriUpdateDoctor.body = jsonEncode({'customers': doctorObject});

//       requestUriUpdateDiagnosticCustomer.body =
//           jsonEncode({'doctors': diagnosticCustomerObject});

//       // _______________________________________________________________________
//       // Sending the request
//       var responseClinic = await requestUriUpdateClinic.send();
//       var responseStringClinic = await responseClinic.stream.bytesToString();
//       var responseJsonClinic = json.decode(responseStringClinic);

//       var responseDoctor = await requestUriUpdateDoctor.send();
//       var responseStringDoctor = await responseDoctor.stream.bytesToString();
//       var responseJsonDoctor = json.decode(responseStringDoctor);

//       var responseDiogCust = await requestUriUpdateDiagnosticCustomer.send();
//       var responseStringDiogCust =
//           await responseDiogCust.stream.bytesToString();
//       var responseJsonDiogCust = json.decode(responseStringDiogCust);

//       // _______________________________________________________________________
//       print(responseJsonClinic);
//       print(responseJsonDoctor);
//       print(responseJsonDiogCust);
//     } catch (e) {
//       print("At add or Update Appoinment : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }
}
