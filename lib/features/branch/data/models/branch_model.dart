import 'package:json_annotation/json_annotation.dart';
import 'package:noviindus_machine_test/features/branch/domain/entity/branch.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel extends Branch {
  BranchModel({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}
