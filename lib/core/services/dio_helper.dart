import 'package:dio/dio.dart';
import '/core/constants/api_constants.dart';
import '/core/error/api_error.dart';

String? token;

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null && token!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    ]);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(url, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiError(ApiError.handleDioError(e));
    }
  }

  static Future<Response> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.post(url, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiError(ApiError.handleDioError(e));
    }
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiError(ApiError.handleDioError(e));
    }
  }
}
