import 'package:flutter/foundation.dart';
import 'package:noviindus_machine_test/features/auth/auth.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  AuthProvider(this.loginUseCase);

  AuthStatus _status = AuthStatus.initial;
  String? _errorMessage;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      _status = AuthStatus.loading;
      notifyListeners();
      final result = await loginUseCase.call(email: email, password: password);
      result.fold(
        (error) {
          _status = AuthStatus.error;
          _errorMessage = error.message;
          notifyListeners();
        },
        (user) {
          _status = AuthStatus.authenticated;
          notifyListeners();
        },
      );
    } catch (e) {
      _status = AuthStatus.error;
      notifyListeners();
    }
  }

  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
}

enum AuthStatus {
  initial,
  loading,
  authenticated,
  error,
}
