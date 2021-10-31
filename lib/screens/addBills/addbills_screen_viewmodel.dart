import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/locator.dart';

class AddBillViewModel extends BaseViewModel {
  // _________________________________________________________________________
  // Locating the Dependencies
  final NavigationService _navigatorService = locator<NavigationService>();
  // _________________________________________________________________________
  // Controllers
  final formKey = GlobalKey<FormState>();

  TextEditingController bName = TextEditingController();
  TextEditingController bAmount = TextEditingController();
  TextEditingController bCategory = TextEditingController();
  TextEditingController bDueDate = TextEditingController();
  // ignore: prefer_final_fields
  String _bPartition = 'Equal';

  DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime.now();
  DateTime? _selectedDueDate;

  DateTime get getFirstDate => _firstDate;
  DateTime get getLastDate => _lastDate;
  DateTime get getselectedDate => _selectedDueDate!;
  String get getPartitionValue => _bPartition;
  setPartitionValue(String value) => _bPartition = value;
  // _________________________________________________________________________
  //Validating entered Name

  String? validateName(String value) {
    return value.isEmpty
        ? "Cannot be empty"
        : value.length > 2
            ? null
            : "Should be atleast 3 characters long";
  }

  // _________________________________________________________________________
  // Validate Date
  String? validateDate() {
    // ignore: unnecessary_null_comparison
    return _selectedDueDate != null ? null : "Choose a date";
  }

  void selectAssignedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDueDate ?? DateTime.now(),
        firstDate: DateTime(2000, 1),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDueDate) {
      _selectedDueDate = picked;
      bDueDate.text = formatter.format(_selectedDueDate!);
    }

    FocusScope.of(context).requestFocus(FocusNode());
    notifyListeners();
  }

  // _________________________________________________________________________
  // Saving Bill
  void saveBill() async {
    setBusy(true);
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      setBusy(false);
      return;
    }
    setBusy(false);
    _navigatorService.popRepeated(1);
  }

  // _________________________________________________________________________
}