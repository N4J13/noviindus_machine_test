import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/branch/domain/entity/branch.dart';

abstract class BranchRepository {
  Future<Either<Failure, List<Branch>>> getBranchList();
}
