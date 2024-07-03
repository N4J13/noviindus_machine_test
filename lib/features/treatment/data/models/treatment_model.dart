import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class TreatmentModel extends Treatment {
  TreatmentModel({
    required super.id,
    required super.name,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) =>
      _$TreatmentModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentModelToJson(this);
}
