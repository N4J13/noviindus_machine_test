import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/patient/domain/entity/patient_entity.dart';
import 'package:noviindus_machine_test/features/patient/domain/repositories/patient_repository.dart';

class GetPatientListUseCase {
  final PatientRepository _repository;

  GetPatientListUseCase(this._repository);

  Future<Either<Failure, List<Patient>>> call() async {
    return await _repository.getPatientList();
  }
}
