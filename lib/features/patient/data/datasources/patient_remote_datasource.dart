import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/api/api_provider.dart';
import 'package:noviindus_machine_test/core/api/endpoints.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/patient/data/models/patient_model.dart';

class PatientRemoteDataSource {
  final ApiProvider apiProvider;

  PatientRemoteDataSource(this.apiProvider);

  // Get patient list
  Future<Either<Failure, List<PatientModel>>> getPatientList() async {
    try {
      final response = await apiProvider.get(Endpoints.patientList);
      if (response.statusCode == 200) {
        final patient = response.data["pati"] as List;
        final List<PatientModel> patientList = patient
            .map((e) => PatientModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(patientList);
      }
      return Left(ServerFailure("Server error occurred"));
    } catch (e) {
      return Left(ServerFailure("Server error occurred"));
    }
  }

  // Register patient
  // Future<Either<Failure, bool>> registerPatient(Patient patient) async {
  //   try {
  //     final response = await apiProvider.post(Endpoints.registerPatient,
  //         data: patient.toJson());
  //     if (response.statusCode == 200) {
  //       return const Right(true);
  //     } else {
  //       return Left(ServerFailure("Server error occurred"));
  //     }
  //   } catch (e) {
  //     return Left(ServerFailure("Server error occurred"));
  //   }
  // }
}
