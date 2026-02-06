import 'package:commons/services/services.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BaseClient {
  late final Dio _dio;

  BaseClient({String? baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? Constants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<void> setToken() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null) {
      throw const NetworkError('Autenticación requerida');
    }
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Result<Response>> get(String path,
      {Map<String, dynamic>? queryParameters, bool authRequired = true}) async {
    try {
      if (authRequired) {
        await setToken();
      }
      final response = await _dio.get(path, queryParameters: queryParameters);
      return Success(response);
    } on DioException catch (e) {
      return Failure(_mapDioError(e));
    } catch (e) {
      return Failure(UnknownError(e.toString()));
    }
  }

  Future<Result<Response>> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool authRequired = true}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(_mapDioError(e));
    } catch (e) {
      return Failure(UnknownError(e.toString()));
    }
  }

  AppException _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkError('Error de conexión');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        return ServerError(
          'Error del servidor (${statusCode ?? 'desconocido'})',
        );

      case DioExceptionType.cancel:
        return const NetworkError('Petición cancelada');

      default:
        return UnknownError(e.message ?? 'Error desconocido');
    }
  }
}
