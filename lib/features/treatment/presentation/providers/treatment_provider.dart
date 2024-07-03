import 'package:flutter/cupertino.dart';
import 'package:noviindus_machine_test/features/treatment/domain/entity/treatment.dart';
import 'package:noviindus_machine_test/features/treatment/domain/entity/treatment_data.dart';
import 'package:noviindus_machine_test/features/treatment/domain/usecases/get_treatment_list.dart';

class TreatmentProvider extends ChangeNotifier {
  final GetTreatmentList getTreatmentList;

  TreatmentProvider(this.getTreatmentList);

  List<Treatment> _treatments = [];
  List<TreatmentData> _treatmentData = [];

  TreatmentState _state = TreatmentState.initial;
  Treatment? _selectedTreatment;

  int _noOfMalePatients = 0;
  int _noOfFemalePatients = 0;

  Future<void> getTreatments() async {
    _state = TreatmentState.loading;
    notifyListeners();
    final result = await getTreatmentList.call();
    result.fold(
      (failure) {
        _state = TreatmentState.error;
        notifyListeners();
      },
      (treatments) {
        _treatments = treatments;
        _state = TreatmentState.loaded;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  void selectTreatment(Treatment treatment) {
    _selectedTreatment = treatment;
    notifyListeners();
  }

  void addTreatmentData(TreatmentData treatmentData) {
    final treatmentAlreadyExists = _treatmentData
        .any((element) => element.treatment.id == treatmentData.treatment.id);
    if (treatmentAlreadyExists) {
      _treatmentData.removeWhere(
        (element) => element.treatment.id == treatmentData.treatment.id,
      );
    }

    if (treatmentData.noOfMalePatients == 0 &&
            treatmentData.noOfFemalePatients == 0 ||
        selectedTreatment == null) return;

    _treatmentData.add(treatmentData);
    notifyListeners();

    // clear all the values
    _selectedTreatment = null;
    _noOfMalePatients = 0;
    _noOfFemalePatients = 0;

    notifyListeners();
  }

  void updateTreatmentData(TreatmentData treatmentData, int noOfMalePatients,
      int noOfFemalePatients, int index) {
    final index = _treatmentData.indexWhere(
      (element) => element.treatment.id == treatmentData.treatment.id,
    );
    _treatmentData[index] = treatmentData.copyWith(
      noOfMalePatients: noOfMalePatients,
      noOfFemalePatients: noOfFemalePatients,
    );
    notifyListeners();
  }

  void removeTreatmentData(int index) {
    _treatmentData.removeAt(index);
    notifyListeners();
  }

  void updatePatientCount({
    required String gender,
    required Type type,
    TreatmentData? treatmentData,
  }) {
    if (type == Type.increment) {
      if (gender == 'male') {
        if (treatmentData != null) {
          treatmentData.copyWith(
            noOfMalePatients: treatmentData.noOfMalePatients + 1,
          );
          notifyListeners();
          return;
        }
        _noOfMalePatients++;
        notifyListeners();
      } else if (gender == 'female') {
        if (treatmentData != null) {
          treatmentData.copyWith(
            noOfFemalePatients: treatmentData.noOfFemalePatients + 1,
          );
          notifyListeners();
          return;
        }

        _noOfFemalePatients++;
      }
    } else if (type == Type.decrement) {
      if (gender == 'male' && _noOfMalePatients > 0) {
        if (treatmentData != null && treatmentData.noOfMalePatients > 0) {
          treatmentData.copyWith(
            noOfMalePatients: treatmentData.noOfMalePatients - 1,
          );
          notifyListeners();
          return;
        }
        _noOfMalePatients--;
      } else if (gender == 'female' && _noOfFemalePatients > 0) {
        if (treatmentData != null && treatmentData.noOfFemalePatients > 0) {
          treatmentData.copyWith(
            noOfFemalePatients: treatmentData.noOfFemalePatients - 1,
          );
          notifyListeners();
          return;
        }
        _noOfFemalePatients--;
      }
    }
    notifyListeners();
  }

  void clearTreatment() {
    _treatmentData = [];
    _selectedTreatment = null;
    _noOfMalePatients = 0;
    _noOfFemalePatients = 0;
    notifyListeners();
  }

  List<Treatment> get treatments => _treatments;
  TreatmentState get state => _state;
  List<TreatmentData> get treatmentData => _treatmentData;
  Treatment? get selectedTreatment => _selectedTreatment;
  int? get noOfMalePatients => _noOfMalePatients;
  int? get noOfFemalePatients => _noOfFemalePatients;
}

enum TreatmentState { initial, loading, loaded, error }

enum Type { increment, decrement }
