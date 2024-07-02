abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class ApplicationFailure extends Failure {
  ApplicationFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}
