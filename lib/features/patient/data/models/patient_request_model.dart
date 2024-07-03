import 'package:json_annotation/json_annotation.dart';

part 'patient_request_model.g.dart';

@JsonSerializable()
class PatientRequestModel {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'excecutive')
  final String executive;

  @JsonKey(name: 'payment')
  final String payment;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  @JsonKey(name: 'discount_amount')
  final double discountAmount;

  @JsonKey(name: 'advance_amount')
  final double advanceAmount;

  @JsonKey(name: 'balance_amount')
  final double balanceAmount;

  @JsonKey(name: 'date_nd_time')
  final String dateAndTime;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'male')
  final List<int> male;

  @JsonKey(name: 'female')
  final List<int> female;

  @JsonKey(name: 'branch')
  final int branch;

  @JsonKey(name: 'treatments')
  final List<int> treatments;

  PatientRequestModel({
    required this.name,
    required this.executive,
    required this.payment,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateAndTime,
    required this.id,
    required this.male,
    required this.female,
    required this.branch,
    required this.treatments,
  });

  factory PatientRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PatientRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRequestModelToJson(this);
}
