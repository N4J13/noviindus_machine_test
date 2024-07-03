import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_machine_test/features/patient/domain/entity/patient_entity.dart';
import 'package:noviindus_machine_test/features/patient/domain/usecases/get_patient_list.dart';

class PatientProvider extends ChangeNotifier {
  final GetPatientListUseCase _getPatientListUseCase;

  PatientProvider(this._getPatientListUseCase);

  List<Patient> _patientList = [];
  final List<String> _locations = [
    'Kochi',
    'Aluva',
    'Manjeri',
    'Kozhikode',
  ];
  PatientState _state = PatientState.loading;
  String? _errorMessage;

  Future<void> getPatientList() async {
    _state = PatientState.loading;
    notifyListeners();
    final result = await _getPatientListUseCase.call();
    result.fold(
      (failure) {
        _state = PatientState.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (patients) {
        _state = PatientState.loaded;
        _patientList = patients;
        notifyListeners();
      },
    );
  }

  Future<void> registerPatient({
    required String name,
    required String whatsappNumber,
    required String address,
    required String totalAmount,
    required String discountAmount,
    required String advanceAmount,
    required String balanceAmount,
  }) async {
    if (selectedHour == null ||
        selectedMinute == null ||
        _selectedDate == null) {
      _state = PatientState.error;
      _errorMessage = 'Please select time or date';
      notifyListeners();
      return;
    }

    _state = PatientState.loading;
    notifyListeners();

    String paymentOption = _selectedPaymentOption ?? 'Cash';
    String date = formattedDate ?? '';
    String time = formatTime(selectedHour, selectedMinute);

    print(
        '$name, $whatsappNumber, $address, $totalAmount, $discountAmount, $advanceAmount, $balanceAmount, $paymentOption, $date, $time');

    // _state = PatientState.registered;
    // notifyListeners();
  }

  // Payment options
  final List<String> _paymentOptions = [
    'Cash',
    'Card',
    'UPI',
  ];

  String? _selectedPaymentOption = 'Cash';

  void selectPaymentOption(String? option) {
    _selectedPaymentOption = option;
    notifyListeners();
  }

  String formatTime(String? hour, String? minute) {
    final hourwithoutAMPM = hour?.split(' ')[0];
    final ampm = hour?.split(' ')[1];
    return '$hourwithoutAMPM:$minute $ampm';
  }

  // Locations
  String? _selectedLocation;

  void selectLocation(String? location) {
    _selectedLocation = location;
    notifyListeners();
  }

  // Select Date
  DateTime? _selectedDate;

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      notifyListeners();
    }
  }

  String? selectedHour;
  String? selectedMinute;

  void setSelectedHour(String hour) {
    selectedHour = hour;
    notifyListeners();
    print(selectedHour);
  }

  void setSelectedMinute(String minute) {
    selectedMinute = minute;
    notifyListeners();
    print(selectedMinute);
  }

  // Getters
  String? get formattedDate {
    final formatter = DateFormat('dd/MM/yyyy');
    if (_selectedDate == null) {
      return null;
    }
    return formatter.format(_selectedDate!);
  }

  void clearDate() {
    _selectedDate = null;
    selectedHour = null;
    selectedMinute = null;
    notifyListeners();
  }

  List<Patient> get patientList => _patientList;
  PatientState get state => _state;
  String? get errorMessage => _errorMessage;
  List<String> get paymentOptions => _paymentOptions;
  String? get selectedPaymentOption => _selectedPaymentOption;
  List<String> get locations => _locations;
  String? get selectedLocation => _selectedLocation;
}

enum PatientState { loading, loaded, registered, error }
