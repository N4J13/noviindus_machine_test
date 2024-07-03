import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/api/api_provider.dart';
import 'package:noviindus_machine_test/core/api/endpoints.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/treatment/data/models/treatment_model.dart';

class TreatmentRemoteDataSource {
  final ApiProvider apiProvider;

  TreatmentRemoteDataSource(this.apiProvider);

  // Get treatment list
  Future<Either<Failure, List<TreatmentModel>>> getTreatmentList() async {
    try {
      final response = await apiProvider.get(Endpoints.treatmentList);
      if (response.statusCode == 200) {
        final result = response.data["treatments"] as List;
        final treatments = result
            .map((treatment) => TreatmentModel.fromJson(treatment))
            .toList();
        return Right(treatments);
      } else {
        return Left(ServerFailure("Server error occurred"));
      }
    } catch (e) {
      print(e);
      return Left(NetworkFailure("Server error occurred"));
    }
  }
}
