import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/patient/data/models/patient_request_model.dart';
import 'package:noviindus_machine_test/features/patient/domain/repositories/patient_repository.dart';

class RegisterPatient {
  final PatientRepository _repository;

  RegisterPatient(this._repository);

  Future<Either<Failure, bool>> call(PatientRequestModel patient) async {
    return await _repository.registerPatient(patient);
  }
}
