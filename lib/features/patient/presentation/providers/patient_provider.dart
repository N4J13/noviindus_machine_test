import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_machine_test/core/services/pdf_service.dart';
import 'package:noviindus_machine_test/features/branch/domain/entity/branch.dart';
import 'package:noviindus_machine_test/features/patient/data/models/patient_request_model.dart';
import 'package:noviindus_machine_test/features/patient/domain/entity/patient_entity.dart';
import 'package:noviindus_machine_test/features/patient/domain/entity/patient_invoice.dart';
import 'package:noviindus_machine_test/features/patient/domain/usecases/get_patient_list.dart';
import 'package:noviindus_machine_test/features/patient/domain/usecases/register_patient.dart';
import 'package:noviindus_machine_test/features/treatment/domain/entity/treatment_data.dart';

class PatientProvider extends ChangeNotifier {
  final GetPatientListUseCase _getPatientListUseCase;
  final RegisterPatient _registerPatient;
  final PdfService _pdfService = PdfService();

  PatientProvider(this._getPatientListUseCase, this._registerPatient);

  List<Patient> _patientList = [];
  final List<String> _locations = [
    'Kochi',
    'Aluva',
    'Manjeri',
    'Kozhikode',
  ];
  PatientState _state = PatientState.initial;
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
    required Branch? branch,
    required List<TreatmentData> treatmentData,
  }) async {
    if (selectedHour == null ||
        selectedMinute == null ||
        _selectedDate == null ||
        branch == null ||
        treatmentData.isEmpty) {
      _state = PatientState.error;
      _errorMessage = 'Please complete the form';
      notifyListeners();
      return;
    }

    _state = PatientState.loading;
    notifyListeners();

    String paymentOption = _selectedPaymentOption ?? 'Cash';
    String date = formattedDate ?? '';
    String time = formatTime(selectedHour, selectedMinute);
    List<int> treatmentIds = treatmentData.map((e) => e.treatment.id).toList();
    List<int> noOfMalePatients = treatmentData
        .where((e) => e.noOfMalePatients > 0)
        .map((e) => e.treatment.id)
        .toList();
    List<int> noOfFemalePatients = treatmentData
        .where((e) => e.noOfFemalePatients > 0)
        .map((e) => e.treatment.id)
        .toList();

    PatientRequestModel request = PatientRequestModel(
      name: name,
      id: '',
      phone: whatsappNumber,
      executive: 'Excecutive',
      address: address,
      payment: paymentOption,
      totalAmount: double.parse(totalAmount),
      discountAmount: double.parse(discountAmount),
      advanceAmount: double.parse(advanceAmount),
      balanceAmount: double.parse(balanceAmount),
      dateAndTime: '$date-$time',
      branch: branch.id,
      male: noOfMalePatients,
      female: noOfFemalePatients,
      treatments: treatmentIds,
    );

    final result = await _registerPatient.call(request);

    result.fold(
      (failure) {
        _state = PatientState.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (patient) async {
        _state = PatientState.registered;
      },
    );

    if (_state == PatientState.registered) {
      await _pdfService.generateAndPrintPDF(PatientInvoiceRequest(
        name: name,
        id: "",
        phone: whatsappNumber,
        address: address,
        executive: "executive",
        branch: branch,
        date: date,
        time: time,
        createdDate: _formatCurrentDate(),
        createdTime: _formatCurrentTime(),
        treatmentData: treatmentData,
        totalAmount: totalAmount,
        discountAmount: discountAmount,
        advanceAmount: advanceAmount,
        balanceAmount: balanceAmount,
        payment: paymentOption,
      ));
    }

    notifyListeners();
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

  String _formatCurrentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('hh:mm a');
    return formatter.format(now);
  }

  String _formatCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
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
  }

  void setSelectedMinute(String minute) {
    selectedMinute = minute;
    notifyListeners();
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
    _selectedPaymentOption = 'Cash';
    _selectedLocation = null;

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

enum PatientState { initial, loading, loaded, registered, error }
