import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../data/global.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/logging/logger.dart';
import '../../utils/typedefs.dart';
import 'error_interceptor.dart';

class TokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio dio = setupDio();

  List<String> whiteListedUrl = [
    '/Applogin',
    '/register',
  ];

  bool isTokenExpired(String token) {
    try {
      Json jwt = JwtDecoder.decode(token);
      int exp = jwt['exp'];
      int now = (DateTime.now().add(const Duration(minutes: 2)))
              .millisecondsSinceEpoch ~/
          1000;
      return now > exp;
    } catch (e) {
      TLogger.error("Error in checking token expiration", e);
      return true;
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const storage = FlutterSecureStorage();

    //skip adding token if request is for white listed URL (eg: /login)
    if (whiteListedUrl.any((path) => options.path.contains(path))) {
      return handler.next(options);
    }

    String accessToken =
        await storage.read(key: StringConstants.ACCESS_TOKEN_KEY)?? '';

    bool isAccessTokenExpired = isTokenExpired(accessToken);

    //check if token in storage is expired
    if (!isAccessTokenExpired) {
      options.headers[StringConstants.AUTH_HEADER] = "Bearer $accessToken";
    } else {
      try {
        String? refreshToken =
            await storage.read(key: StringConstants.REFRESH_TOKEN_KEY);
        if (refreshToken != null) {
          // bool isRefresgTokenExpired = isTokenExpired(refreshToken);
          // if (isRefresgTokenExpired) {
          // } else {
          var response = await dio.get("/refresh-token",
              queryParameters: {"refresh": refreshToken});

          if (response.statusCode == 200) {
            accessToken = response.data['access-token'];

            await storage.write(
                key: StringConstants.ACCESS_TOKEN_KEY, value: accessToken);
            await storage.write(
                key: StringConstants.REFRESH_TOKEN_KEY,
                value: response.data['refresh-token']);

            options.headers[StringConstants.AUTH_HEADER] = accessToken;
          } else if (response.statusCode == 403) {
            handler.reject(UnauthorizedException(options));
          } else {
            handler.reject(InternalServerErrorException(options));
          }
          // }
        } else {
          handler.reject(TokenExpiredException(options));
        }
      } on DioException catch (e) {
        if (e is NoInternetConnectionException) {
          handler.reject(NoInternetConnectionException(options));
        } else {
          handler.reject(InternalServerErrorException(options));
        }
      } catch (e) {
        handler.reject(InternalServerErrorException(options));
      }
    }
  
    try {
      return handler.next(options);
    } catch (e) {
      // PASS
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  static setupDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Global.baseUrl,
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    ));
    dio.interceptors.addAll({ErrorInterceptor()});
    return dio;
  }
}
