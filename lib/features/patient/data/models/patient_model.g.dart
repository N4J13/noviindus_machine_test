// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      treatmentName: json['treatment_name'] as String,
      dateAndTime: DateTime.parse(json['date_nd_time'] as String),
      user: json['user'] as String,
    );

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'treatment_name': instance.treatmentName,
      'date_nd_time': instance.dateAndTime.toIso8601String(),
      'user': instance.user,
    };
