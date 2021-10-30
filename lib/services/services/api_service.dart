// import 'dart:convert';
// import 'dart:async';
// import 'dart:typed_data';
// import 'package:http/http.dart' as http;
// import 'package:stacked_services/stacked_services.dart';
// import 'package:http_parser/http_parser.dart';
// import 'data_from_api_service.dart';
// import 'local_storage.dart';
// import '../../app/locator.dart';

class APIServices {
//   // ___________________________________________________________________________
//   // Variables for Clinic API
//   String url = "https://biolegenew.herokuapp.com/api/";
//   // -------------------------------------------------------------
//   // Clinic Employee
//   String urlClinicEmployeeCreate = "clinicemployee/create";
//   String urlGetClinicEmployee = "clinicemployee";
//   String urlGetAllClinicEmployee = "clinicemployees";
//   String urlGetClinicEmployeeByPhone = "clinicemployee/phone/";
//   // -------------------------------------------------------------
//   // Clinic
//   String urlClinicCreate = "clinic/create";
//   String urlClinicUpdate = "clinic/phone/";
//   String urlClinicGet = "clinic/";
//   String urlGetAllClinic = "clinics";
//   String updateClinicImages = "clinic/image/";
//   // -------------------------------------------------------------
//   // Doctors
//   String urlGetDoctors = "doctors";
//   String urlGetDoctorByID = "doctor";
//   String updateDoctor = "doctor";
//   String urlGetAllDoctorCustomers = "doctorcustomer/customers";
//   // -------------------------------------------------------------
//   // Diagnostic Customers
//   String urlDiagnosticCustomerCreate = "diagnostic/customer/create";
//   String urlUpdateDiagnosticCustomer = "diagnostic/customer";
//   String urlDiagnosticCustomerGet = "diagnostic/customer";
//   String urlGetAllDiagnosticCustomers = "diagnostic/customers";
//   String urlGetDiagnosticCustomerByPhone = "diagnostic/customer/phone/";
//   // ---------------------------------------------------------------------------
//   // Create a new Clinic Employee and stores the response in the local storage
//   Future<ClinicEmployee> createClinicEmployee() async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final StorageService _storageService = locator<StorageService>();
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final DataFromApi _dataFromApiService = locator<DataFromApi>();
//     // _________________________________________________________________________
//     try {
//       // URL to be called
//       var uri = Uri.parse('$url$urlClinicEmployeeCreate');
//       // Creating a Multipart request for sending formdata
//       var request = http.Request("POST", uri);
//       // _______________________________________________________________________
//       // Prepare the data to be sent
//       request.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });

//       request.body = jsonEncode({
//         'name': _storageService.getName,
//         'phoneNumber': _storageService.getPhoneNumber.toString(),
//         'gender': _storageService.getGender,
//         'dob': _storageService.getDateOfBirth,
//         'role': _storageService.getRoleType.toString(),
//         'address.state': _storageService.getState,
//         'address.pincode': _storageService.getPinCode.toString(),
//         'address.homeAddress': _storageService.getAddress,
//         'address.city': _storageService.getCityName
//       });
//       // _______________________________________________________________________
//       // Sending the post request
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // _______________________________________________________________________
//       // Saving id for the created user
//       print("Clinic employee created with used id : " +
//           responseJson["clinicEmployee"]["_id"]);
//       _storageService.setUID(responseJson["clinicEmployee"]["_id"]);

//       ClinicEmployee x =
//           ClinicEmployee.fromJson(responseJson["clinicEmployee"]);
//       _dataFromApiService.setClinicEmployee(x);
//       // _______________________________________________________________________
//       return x;
//     } catch (e) {
//       print("At create clinic employee :" + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Fetches clinic employee data from the api by using employee Id stored in
//   // local
//   Future<ClinicEmployee> getClinicEmployeeById() async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final StorageService _storageService = locator<StorageService>();
//     // _________________________________________________________________________
//     // Retreiving clinic id
//     String clinicEmployeeId = _storageService.getUID;
//     // _________________________________________________________________________
//     try {
//       // _______________________________________________________________________
//       // URL to be called
//       var getClinicEmployeeUri =
//           Uri.parse('$url$urlGetClinicEmployee/$clinicEmployeeId');

//       // _______________________________________________________________________
//       // Creating get requests
//       var getClinicEmployeeRequest =
//           new http.Request("GET", getClinicEmployeeUri);
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var getClinicEmployeeResponse = await getClinicEmployeeRequest.send();
//       var getClinicEmployeeResponseString =
//           await getClinicEmployeeResponse.stream.bytesToString();
//       var getClinicEmployeeResponseJson =
//           json.decode(getClinicEmployeeResponseString);

//       // Clinic Employee object generated from the incoming json
//       return ClinicEmployee.fromJson(getClinicEmployeeResponseJson);
//     } catch (e) {
//       print("At get clinic employee by ID : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Fetches clinic employee data from the api by using employee phone
//   Future<ClinicEmployee> getClinicEmployeeByPhone(String phone) async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     // final StorageService _storageService = locator<StorageService>();
//     // _________________________________________________________________________
//     try {
//       // _______________________________________________________________________
//       // URL to be called
//       var getClinicEmployeeUri =
//           Uri.parse('$url$urlGetClinicEmployeeByPhone$phone');
//       print(getClinicEmployeeUri);
//       // _______________________________________________________________________
//       // Creating get requests
//       var getClinicEmployeeRequest =
//           new http.Request("GET", getClinicEmployeeUri);
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var getClinicEmployeeResponse = await getClinicEmployeeRequest.send();
//       var getClinicEmployeeResponseString =
//           await getClinicEmployeeResponse.stream.bytesToString();
//       var getClinicEmployeeResponseJson =
//           json.decode(getClinicEmployeeResponseString);
//       if (getClinicEmployeeResponseString.length == 2) return null;
//       return ClinicEmployee.fromJson(getClinicEmployeeResponseJson[0]);
//     } catch (e) {
//       print("At get clinic employee by phone : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Fetches clinic data from the api and saves globally
//   Future getClinicEmployeeByIdFromApiAndSetGlobally() async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final DataFromApi _dataFromApi = locator<DataFromApi>();
//     // _________________________________________________________________________
//     try {
//       _dataFromApi.setClinicEmployee(await getClinicEmployeeById());
//     } catch (e) {
//       print("At saving clinic employee globally: " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//     }
//   }

//   // ___________________________________________________________________________

//   //  Adds a clinic employee in the clinic object by first fetching the clinic
//   // and then adding the employee object if it doesn't exits else no change
//   Future<Clinic> addOrUpdateClinicEmployeeToClinic(String clinicId) async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final DataFromApi _dataFromApiServices = locator<DataFromApi>();
//     // final StorageService _storageService = locator<StorageService>();
//     // _________________________________________________________________________
//     try {
//       // _______________________________________________________________________
//       // URL to be called
//       var uri = Uri.parse('$url$urlClinicUpdate$clinicId');
//       print(uri);
//       // _______________________________________________________________________
//       // Creating get requests
//       var request = new http.Request("PUT", uri);
//       // _______________________________________________________________________
//       // Clinic object from get clinic by id (API)

//       Clinic latestClinicFromApi = await getClinic();
//       // List of employee of the respective clinic (API)
//       List<ClinicEmployeeObject> latestClinicEmployeeListFromApi =
//           latestClinicFromApi.clinicEmployee;

//       String clinicEmployeeID = _dataFromApiServices.getClinicEmployee.id;
//       // _______________________________________________________________________
//       // Preparing the data to be sent
//       ClinicEmployeeObject clinicEmplyeeObjectToBeSentIfDoesntExist =
//           ClinicEmployeeObject(id: clinicEmployeeID);
//       // _______________________________________________________________________
//       // Finding customer in the customers object of the clinic and
//       // returns the iterator
//       Iterable<ClinicEmployeeObject> foundEmployee =
//           latestClinicEmployeeListFromApi
//               .where((employee) => employee.id == clinicEmployeeID);
//       // _______________________________________________________________________
//       // Logic for updating employee object of doctor
//       if (foundEmployee.isEmpty) {
//         // If not found add the "clinicEmplyeeObjectToBeSentIfDoesntExist" to
//         // latest employee list and covert all the employee to jsonobject
//         latestClinicEmployeeListFromApi
//             .add(clinicEmplyeeObjectToBeSentIfDoesntExist);
//         // ________________________________________________________
//         var object = [];
//         latestClinicEmployeeListFromApi
//             .forEach((employee) => object.add(employee.toJson()));
//         request.body = jsonEncode({'clinicEmployee': object});
//         // ________________________________________________________
//       } else {
//         var object = [];
//         latestClinicEmployeeListFromApi
//             .forEach((employee) => object.add(employee.toJson()));
//         request.body = jsonEncode({'clinicEmployee': object});
//       }

//       // _______________________________________________________________________
//       // Preparing the headers
//       request.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });

//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);

//       Clinic clinic = Clinic.fromJson(responseJson);
//       _dataFromApiServices.setClinic(clinic);

//       // _______________________________________________________________________
//       print("Clinic Employee added " + clinicId);
//       // _______________________________________________________________________
//       return clinic;
//     } catch (e) {
//       print("At add clinic customer : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }
//   // ___________________________________________________________________________

//   // Fetches all clinics from the API and stores in data services class
//   Future<List<ClinicEmployee>> getAllClinicEmployee() async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     // final DataFromApi _dataFromApiService = locator<DataFromApi>();
//     // _________________________________________________________________________
//     try {
//       // URL to be called
//       var uri = Uri.parse('$url$urlGetAllClinicEmployee');
//       // Creating a get request
//       var request = new http.Request("GET", uri);
//       // _______________________________________________________________________

//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // _______________________________________________________________________
//       // Serializing Json to Doctor Class
//       List<ClinicEmployee> clist = [];

//       responseJson.forEach(
//           (clcEmp) => clist.add(clinicEmployeeFromJson(json.encode(clcEmp))));
//       // _______________________________________________________________________
//       return clist;
//     } catch (e) {
//       print("At get all clinic's employee: " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return [];
//     }
//   }

//   // ***************************************************************************
//   // Fetches all clinics from the API and stores in data services class
//   Future<List<Clinic>> getAllClinics() async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final DataFromApi _dataFromApiService = locator<DataFromApi>();
//     // _________________________________________________________________________
//     try {
//       // URL to be called
//       var uri = Uri.parse('$url$urlGetAllClinic');
//       // Creating a get request
//       var request = new http.Request("GET", uri);
//       // _______________________________________________________________________

//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // _______________________________________________________________________
//       // Serializing Json to Doctor Class
//       List<Clinic> clist = [];

//       responseJson
//           .forEach((clinic) => clist.add(clinicFromJson(json.encode(clinic))));

//       _dataFromApiService.setclinicList(clist);
//       // _______________________________________________________________________
//       return clist;
//     } catch (e) {
//       print("At get all clinics : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return [];
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Create a new clinic
//   Future<Clinic> createClinic() async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final StorageService _storageService = locator<StorageService>();
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     // _________________________________________________________________________
//     try {
//       // _______________________________________________________________________
//       // URL to be called
//       var uri = Uri.parse('$url$urlClinicCreate');
//       // Creating a Multipart request for sending formdata
//       var request = new http.Request("POST", uri);
//       // _______________________________________________________________________
//       // Preparing the data to be sent
//       request.headers.addAll({
//         'Content-Type': 'application/json; charset=UTF-8',
//       });

//       request.body = jsonEncode({
//         'name': _storageService.getClinicName,
//         'pincode': _storageService.getClinicPinCode,
//         'phoneNumber': _storageService.getClinicPhoneNumber.toString(),
//         'location.latitude':
//             _storageService.getClinicLocationLatitude.toString(),
//         'location.longitude':
//             _storageService.getClinicLocationLongitude.toString(),
//         'ownerName': _storageService.getClinicOwnerName,
//         'ownerIdProofName': _storageService.getClinicOwnerIdProofType == 0
//             ? "PAN Card"
//             : _storageService.getClinicOwnerIdProofType == 1
//                 ? "Aadhar Card"
//                 : "Voter Card",
//         'ownerPhoneNumber': _storageService.getClinicOwnerPhone.toString(),
//         'address.state': _storageService.getClinicStateName,
//         'address.city': _storageService.getClinicCityName,
//         'address.pincode': _storageService.getClinicPinCode.toString(),
//         'address.clinicAddress': _storageService.getClinicAddress,
//         'services': _storageService.getClinicServices,
//         'clinicEmployee': [
//           {"_id": _storageService.getUID}
//         ]
//       });
//       // _______________________________________________________________________
//       // Sending the post request
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // _______________________________________________________________________
//       // Updating the images related to clinic
//       print("Clinic created with clinic id : " +
//           responseJson["clinic"]["_id"].toString());
//       // _______________________________________________________________________
//       // Updates images related to clinic using seperate routes
//       Clinic finalClinicWithImages =
//           await updateClinicImage(responseJson["clinic"]["_id"]);
//       // _______________________________________________________________________
//       // Saving id for the created clinic
//       _storageService.setClinicId(finalClinicWithImages.id);
//       // _______________________________________________________________________
//       return finalClinicWithImages;
//     } catch (e) {
//       print("At create clinic : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Updates all clinic related images like address proof, logo from the
//   // local storages
//   Future<Clinic> updateClinicImage(String clinicId) async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final StorageService _storageService = locator<StorageService>();
//     // _________________________________________________________________________
//     // Decoding the files to Uint8
//     Uint8List clinicLogo = await _storageService.getClinicLogoFromLocal();
//     String clinicLogoB64 = base64Encode(clinicLogo);
//     Uint8List clinicOwnerIdProof =
//         await _storageService.getClinicOwnerIdProofFromLocal();
//     String clinicOwnerIdProofB64 = base64Encode(clinicOwnerIdProof);
//     Uint8List clinicAddressProof =
//         await _storageService.getClinicAddressProofFromLocal();
//     String clinicAddressProofB64 = base64Encode(clinicAddressProof);

//     // _________________________________________________________________________
//     try {
//       // URL to be called
//       var uri = Uri.parse('$url$updateClinicImages$clinicId');
//       // Creating a get request
//       var request = new http.MultipartRequest("PUT", uri);
//       // _______________________________________________________________________

//       request
//         ..files.add(new http.MultipartFile.fromBytes(
//             'logo', clinicLogoB64.codeUnits,
//             contentType: new MediaType('image', 'jpeg')));

//       request
//         ..files.add(new http.MultipartFile.fromBytes(
//             'ownerIdProof', clinicOwnerIdProofB64.codeUnits,
//             contentType: new MediaType('image', 'jpeg')));

//       request
//         ..files.add(new http.MultipartFile.fromBytes(
//             'addressProof', clinicAddressProofB64.codeUnits,
//             contentType: new MediaType('image', 'jpeg')));
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var response = await request.send();
//       var responseString = await response.stream.bytesToString();
//       var responseJson = json.decode(responseString);
//       // _______________________________________________________________________
//       // Serializing Json to Doctor Class
//       print("Clinic images updated with clinic id : " +
//           Clinic.fromJson(responseJson).id);

//       // _______________________________________________________________________
//       return Clinic.fromJson(responseJson);
//     } catch (e) {
//       print("At update clinic images: " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Fetches clinic data from the api by using CLINIC Id stored in local
//   Future<Clinic> getClinic() async {
//     // _________________________________________________________________________
//     // Locating Dependencies
//     final SnackbarService _snackBarService = locator<SnackbarService>();
//     final StorageService _storageService = locator<StorageService>();
//     // _________________________________________________________________________
//     // Retreiving clinic id
//     String clinicId = _storageService.getClinicId;
//     // _________________________________________________________________________
//     try {
//       // _______________________________________________________________________
//       // URL to be called
//       var getClinicUri = Uri.parse('$url$urlClinicGet$clinicId');
//       // _______________________________________________________________________
//       // Creating get requests
//       var getClinicRequest = new http.Request("GET", getClinicUri);
//       // _______________________________________________________________________
//       // Receiving the JSON response
//       var getClinicResponse = await getClinicRequest.send();
//       var getClinicResponseString =
//           await getClinicResponse.stream.bytesToString();
//       var getClinicResponseJson = json.decode(getClinicResponseString);

//       // Clinic object generated from the incoming json
//       return Clinic.fromJson(getClinicResponseJson);
//     } catch (e) {
//       print("At get clinic by ID : " + e.toString());
//       _snackBarService.showSnackbar(message: e.toString());
//       return null;
//     }
//   }

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
