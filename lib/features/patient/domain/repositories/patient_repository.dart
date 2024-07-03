import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/patient/domain/entity/patient_entity.dart';

abstract class PatientRepository {
  Future<Either<Failure, List<Patient>>> getPatientList();
  // Future<Either<Failure, bool>> registerPatient(Patient patient);
}
