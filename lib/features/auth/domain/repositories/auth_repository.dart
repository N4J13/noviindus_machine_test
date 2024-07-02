import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  });
}
