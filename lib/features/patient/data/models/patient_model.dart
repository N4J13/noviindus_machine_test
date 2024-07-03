import 'package:json_annotation/json_annotation.dart';
import 'package:noviindus_machine_test/features/patient/domain/entity/patient_entity.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel extends Patient {
  const PatientModel({
    required super.id,
    required super.name,
    required super.treatmentName,
    required super.dateAndTime,
    required super.user,
  });

  @override
  @JsonKey(name: 'id')
  int get id => super.id;

  @override
  @JsonKey(name: 'name')
  String get name => super.name;

  @override
  @JsonKey(name: 'treatment_name')
  String get treatmentName => super.treatmentName;

  @override
  @JsonKey(name: 'date_nd_time')
  DateTime get dateAndTime => super.dateAndTime;

  @override
  @JsonKey(name: 'user')
  String get user => super.user;

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    final patientDetailsSet = json['patientdetails_set'] as List;
    final treatmentName = patientDetailsSet.isNotEmpty
        ? patientDetailsSet[0]['treatment_name'] as String
        : '';

    return _$PatientModelFromJson({
      ...json,
      'treatment_name': treatmentName,
      'date_nd_time': json['date_nd_time'],
    });
  }

  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}
