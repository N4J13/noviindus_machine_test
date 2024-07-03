// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientRequestModel _$PatientRequestModelFromJson(Map<String, dynamic> json) =>
    PatientRequestModel(
      name: json['name'] as String,
      executive: json['excecutive'] as String,
      payment: json['payment'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      totalAmount: (json['total_amount'] as num).toDouble(),
      discountAmount: (json['discount_amount'] as num).toDouble(),
      advanceAmount: (json['advance_amount'] as num).toDouble(),
      balanceAmount: (json['balance_amount'] as num).toDouble(),
      dateAndTime: json['date_nd_time'] as String,
      id: json['id'] as String,
      male: (json['male'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      female: (json['female'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      branch: (json['branch'] as num).toInt(),
      treatments: (json['treatments'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$PatientRequestModelToJson(
        PatientRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'excecutive': instance.executive,
      'payment': instance.payment,
      'phone': instance.phone,
      'address': instance.address,
      'total_amount': instance.totalAmount,
      'discount_amount': instance.discountAmount,
      'advance_amount': instance.advanceAmount,
      'balance_amount': instance.balanceAmount,
      'date_nd_time': instance.dateAndTime,
      'id': instance.id,
      'male': instance.male,
      'female': instance.female,
      'branch': instance.branch,
      'treatments': instance.treatments,
    };
