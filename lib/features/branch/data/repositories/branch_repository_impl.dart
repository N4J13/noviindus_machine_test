import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/branch/data/datasources/branch_remote_datasource.dart';
import 'package:noviindus_machine_test/features/branch/data/models/branch_model.dart';
import 'package:noviindus_machine_test/features/branch/domain/repositories/branch_repository.dart';

class BranchRepositoryImpl extends BranchRepository {
  final BranchRemoteDataSource remoteDataSource;

  BranchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<BranchModel>>> getBranchList() async {
    return await remoteDataSource.getBranchList();
  }
}
