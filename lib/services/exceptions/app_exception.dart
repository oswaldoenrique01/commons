sealed class AppException {
  final String message;
  const AppException(this.message);
}

class NetworkError extends AppException {
  const NetworkError(super.message);
}

class ServerError extends AppException {
  const ServerError(super.message);
}

class UnknownError extends AppException {
  const UnknownError(super.message);
}