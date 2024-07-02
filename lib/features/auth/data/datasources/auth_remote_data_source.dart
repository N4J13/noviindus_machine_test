import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/api/api_provider.dart';
import 'package:noviindus_machine_test/core/error/failure.dart';
import 'package:noviindus_machine_test/core/services/storage_service.dart';

class AuthRemoteDataSource {
  final ApiProvider apiProvider;
  final StorageService storageService;

  AuthRemoteDataSource(
    this.apiProvider,
    this.storageService,
  );

  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiProvider.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(ServerFailure("Server error occurred"));
      }
    } catch (e) {
      return Left(ServerFailure("Server error occurred"));
    }
  }
}
