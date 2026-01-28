import 'package:commons/services/exceptions/app_exception.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data; const Success(this.data);
}

class Failure<T> extends Result<T> {
  final AppException error;
  const Failure(this.error);
}