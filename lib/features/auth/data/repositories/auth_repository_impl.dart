import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:noviindus_machine_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.login(
      email: email,
      password: password,
    );
  }
}
