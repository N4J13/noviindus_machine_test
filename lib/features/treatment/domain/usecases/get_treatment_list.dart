import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/treatment/domain/entity/treatment.dart';
import 'package:noviindus_machine_test/features/treatment/domain/repositories/treatment_repository.dart';

class GetTreatmentList {
  final TreatmentRepository repository;

  GetTreatmentList(this.repository);

  Future<Either<Failure, List<Treatment>>> call() async {
    try {
      return await repository.getTreatments();
    } catch (e) {
      return Left(ServerFailure("missing implementation"));
    }
  }
}
