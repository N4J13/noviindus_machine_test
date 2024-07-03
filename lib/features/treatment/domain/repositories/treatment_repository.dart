import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/treatment/domain/entity/treatment.dart';

abstract class TreatmentRepository {
  Future<Either<Failure, List<Treatment>>> getTreatments();
}
