import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/api/api_provider.dart';
import 'package:noviindus_machine_test/core/api/endpoints.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/branch/data/models/branch_model.dart';

class BranchRemoteDataSource {
  final ApiProvider apiProvider;

  BranchRemoteDataSource(this.apiProvider);

  // Get branch list
  Future<Either<Failure, List<BranchModel>>> getBranchList() async {
    try {
      final response = await apiProvider.get(Endpoints.branchList);
      if (response.statusCode == 200) {
        final result = response.data["branches"] as List;
        final List<BranchModel> branchList =
            result.map((e) => BranchModel.fromJson(e)).toList();
        return Right(branchList);
      } else {
        return Left(ServerFailure("Server error occurred"));
      }
    } catch (e) {
      return Left(ServerFailure("Server error occurred"));
    }
  }
}
