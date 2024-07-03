import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/api/api_provider.dart';
import 'package:noviindus_machine_test/core/api/endpoints.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/patient/data/models/patient_model.dart';
import 'package:noviindus_machine_test/features/patient/data/models/patient_request_model.dart';

class PatientRemoteDataSource {
  final ApiProvider apiProvider;

  PatientRemoteDataSource(this.apiProvider);

  // Get patient list
  Future<Either<Failure, List<PatientModel>>> getPatientList() async {
    try {
      final response = await apiProvider.get(Endpoints.patientList);
      if (response.statusCode == 200) {
        final patient = response.data["patient"] as List;
        final List<PatientModel> patientList = patient
            .map((e) => PatientModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(patientList);
      }
      return Left(ServerFailure("Server error occurred"));
    } catch (e) {
      print(e);
      return Left(ServerFailure("Server error occurred"));
    }
  }

  Future<Either<Failure, bool>> registerPatient(
      PatientRequestModel patient) async {
    try {
      final response = await apiProvider.post(Endpoints.registerPatient, data: {
        "name": patient.name,
        "address": patient.address,
        "phone": patient.phone,
        "id": "",
        "excecutive": "Excecutive",
        "treatments": patient.treatments.join(","),
        "total_amount": 100,
        "advance_amount": 100,
        "discount_amount": 100,
        "balance_amount": 100,
        "date_nd_time": patient.dateAndTime,
        "payment": patient.payment,
        "branch": 166,
        "male": patient.male.join(","),
        "female": patient.female.join(","),
      });
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(ServerFailure("Server error occurred"));
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure("Server error occurred"));
    }
  }
}
