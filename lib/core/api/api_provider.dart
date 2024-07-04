import 'package:dio/dio.dart';
import 'package:noviindus_machine_test/core/api/auth_interceptor.dart';
import 'package:noviindus_machine_test/core/api/endpoints.dart';

class ApiProvider {
  final _dio = Dio();

  ApiProvider() {
    _dio.options.baseUrl = Endpoints.baseUrl;

    // Set logger
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );

    // Set auth interceptor
    _dio.interceptors.add(AuthInterceptor(_dio));
  }

  Future<Response> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(
    url, {
    required Map<String, dynamic> data,
  }) async {
    try {
      final formData = FormData.fromMap(data);
      final response = await _dio.post(url, data: formData);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(error) {
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        return "Unauthorized";
      }
      return "Can't connect to server";
    } else {
      return 'Unexpected error occurred';
    }
  }
}
