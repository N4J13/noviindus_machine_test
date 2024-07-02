import 'package:dio/dio.dart';
import 'package:noviindus_machine_test/core/services/storage_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  final _storageService = StorageService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final userToken = await getUserToken();

    options.headers['Authorization'] = 'Bearer $userToken';

    return handler.next(options);
  }

  Future<String> getUserToken() async {
    final token = await _storageService.readToken();

    if (token == null) {
      throw Exception('User is not logged in');
    }

    return token;
  }
}
