import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Example of per-request dynamic headers (e.g. token)
        // final token = AuthStorage.token;
        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (e, handler) {
        // handle global errors here if needed
        return handler.next(e);
      },
    ),
  );

  dio.interceptors.add(
    RetryOnConnectionChangeInterceptor(dio: dio),
  );

  return dio;
}

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor({
    required this.dio,
    this.retries = 3,
    this.retryableStatuses = const [408, 500, 502, 503, 504],
  });

  final Dio dio;
  final int retries;
  final List<int> retryableStatuses;

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (!_shouldRetry(err)) {
      return handler.next(err);
    }

    final requestOptions = err.requestOptions;
    int attempt = (requestOptions.extra['retry_attempt'] ?? 0) as int;

    if (attempt >= retries) {
      return handler.next(err);
    }

    attempt++;
    requestOptions.extra['retry_attempt'] = attempt;

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final response = await dio.fetch(requestOptions);
      return handler.resolve(response);
    } catch (e) {
      return handler.next(e as DioException);
    }
  }

  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return true;
    }

    final statusCode = err.response?.statusCode;
    if (statusCode != null && retryableStatuses.contains(statusCode)) {
      return true;
    }

    return false;
  }
}