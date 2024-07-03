import 'package:json_annotation/json_annotation.dart';
import 'package:noviindus_machine_test/features/treatment/domain/entity/treatment.dart';

part 'treatment_model.g.dart';

@JsonSerializable()
class TreatmentModel extends Treatment {
  TreatmentModel({
    required super.id,
    required super.price,
    required super.name,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) =>
      _$TreatmentModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentModelToJson(this);
}
