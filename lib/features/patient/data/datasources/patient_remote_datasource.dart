import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/api/api_provider.dart';
import 'package:noviindus_machine_test/core/api/endpoints.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';

class PatientRemoteDataSource {
  final ApiProvider apiProvider;

  PatientRemoteDataSource(this.apiProvider);

  // Get patient list
  Future<Either<Failure, List<Patient>>> getPatientList() async {
    try {
      final response = await apiProvider.get(Endpoints.patientList);
      return Right(response.data);
    } catch (e) {
      return Left(ServerFailure("Server error occurred"));
    }
  }

  // Register patient
  Future<Either<Failure, bool>> registerPatient(Patient patient) async {
    try {
      final response = await apiProvider.post(Endpoints.registerPatient,
          data: patient.toJson());
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(ServerFailure("Server error occurred"));
      }
    } catch (e) {
      return Left(ServerFailure("Server error occurred"));
    }
  }
}
