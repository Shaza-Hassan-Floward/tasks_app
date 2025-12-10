import 'package:dio/dio.dart';
import '../../domain/error/failures.dart';

Failure mapDioErrorToFailure(DioException e) {
  // Connection / timeout
  if (e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout) {
    return const NetworkFailure('Network error. Please check your connection.');
  }

  final statusCode = e.response?.statusCode;

  if (statusCode == 404) {
    return const NotFoundFailure('Resource not found.');
  }

  if (statusCode != null && statusCode >= 500) {
    return const ServerFailure('Server error. Please try again later.');
  }

  // Fallback
  return UnexpectedFailure(e.message ?? 'Unexpected error');
}