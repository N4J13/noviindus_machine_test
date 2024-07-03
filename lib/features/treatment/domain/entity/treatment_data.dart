import 'package:noviindus_machine_test/features/treatment/domain/entity/treatment.dart';

class TreatmentData {
  final Treatment treatment;
  final int noOfMalePatients;
  final int noOfFemalePatients;

  TreatmentData({
    required this.treatment,
    required this.noOfMalePatients,
    required this.noOfFemalePatients,
  });

  TreatmentData copyWith({
    Treatment? treatment,
    int? noOfMalePatients,
    int? noOfFemalePatients,
  }) {
    return TreatmentData(
      treatment: treatment ?? this.treatment,
      noOfMalePatients: noOfMalePatients ?? this.noOfMalePatients,
      noOfFemalePatients: noOfFemalePatients ?? this.noOfFemalePatients,
    );
  }
}
