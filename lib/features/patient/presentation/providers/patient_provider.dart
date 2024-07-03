import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/features/patient/domain/entity/patient_entity.dart';
import 'package:noviindus_machine_test/features/patient/domain/usecases/get_patient_list.dart';

class PatientProvider extends ChangeNotifier {
  final GetPatientListUseCase _getPatientListUseCase;

  PatientProvider(this._getPatientListUseCase);

  List<Patient> _patientList = [];

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

  List<Patient> get patientList => _patientList;
  PatientState get state => _state;
  String? get errorMessage => _errorMessage;
}

enum PatientState { loading, loaded, registered, error }
