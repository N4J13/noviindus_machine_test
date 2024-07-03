import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/patient/data/datasources/patient_remote_datasource.dart';
import 'package:noviindus_machine_test/features/patient/data/models/patient_model.dart';
import 'package:noviindus_machine_test/features/patient/domain/repositories/patient_repository.dart';

class PatientRepositoryImpl extends PatientRepository {
  final PatientRemoteDataSource remoteDataSource;

  PatientRepositoryImpl(this.remoteDataSource);

  // @override
  // Future<Either<Failure, bool>> registerPatient(Patient patient) {
  //   return remoteDataSource.registerPatient(patient);
  // }

  @override
  Future<Either<Failure, List<PatientModel>>> getPatientList() {
    return remoteDataSource.getPatientList();
  }
}
