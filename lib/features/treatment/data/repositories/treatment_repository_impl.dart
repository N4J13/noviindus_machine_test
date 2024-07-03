import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/treatment/data/datasources/treatment_remote_data_source.dart';
import 'package:noviindus_machine_test/features/treatment/data/models/treatment_model.dart';
import 'package:noviindus_machine_test/features/treatment/domain/repositories/treatment_repository.dart';

class TreatmentRepositoryImpl extends TreatmentRepository {
  final TreatmentRemoteDataSource treatmentDataSource;

  TreatmentRepositoryImpl(this.treatmentDataSource);

  @override
  Future<Either<Failure, List<TreatmentModel>>> getTreatments() async {
    try {
      return await treatmentDataSource.getTreatmentList();
    } catch (e) {
      return Left(ServerFailure("missing implementation"));
    }
  }
}
