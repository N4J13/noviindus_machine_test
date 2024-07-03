import 'package:fpdart/fpdart.dart';
import 'package:noviindus_machine_test/core/api/api_provider.dart';
import 'package:noviindus_machine_test/core/api/endpoints.dart';
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
        Endpoints.login,
        data: {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        await storageService.writeToken(token);
        return const Right(true);
      } else {
        return Left(ServerFailure(response.data['message']));
      }
    } catch (e) {
      return Left(ServerFailure("Server error occurred"));
    }
  }
}
