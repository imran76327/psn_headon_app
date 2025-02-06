import 'package:dio/dio.dart';

import '../data/global.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/token_interceptor.dart';

class ServiceHelper {
  // Singleton Pattern
  ServiceHelper._internal();
  static final _singleton = ServiceHelper._internal();
  factory ServiceHelper() => _singleton;

  final Dio dio = setupDio();

  static Dio setupDio() {
    final options = BaseOptions(
      baseUrl: Global.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    );
    final dio = Dio(options);
    dio.interceptors.addAll([
      TokenInterceptor(),
      ErrorInterceptor(),
    ]);
    return dio;
  }
}
