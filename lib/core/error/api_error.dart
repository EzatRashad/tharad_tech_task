import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '/core/constants/app_strings.dart';

class ApiError {
  final String message;

  ApiError(this.message);

  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppStrings.connectionTimeout.tr();
      case DioExceptionType.sendTimeout:
        return AppStrings.sendTimeout.tr();
      case DioExceptionType.receiveTimeout:
        return AppStrings.receiveTimeout.tr();
      case DioExceptionType.badResponse:
        final data = error.response?.data;
        if (data is Map<String, dynamic>) {
          return data['message']?.toString().isNotEmpty == true
              ? data['message']
              : AppStrings.serverError.tr();
        } else if (data is String) {
          try {
            final decoded = Map<String, dynamic>.from(jsonDecode(data));
            return decoded['message']?.toString().isNotEmpty == true
                ? decoded['message']
                : AppStrings.serverError.tr();
          } catch (_) {
            return data.isNotEmpty ? data : AppStrings.serverError.tr();
          }
        } else {
          return AppStrings.serverError.tr();
        }
      case DioExceptionType.cancel:
        return AppStrings.requestCancelled.tr();
      case DioExceptionType.unknown:
        return AppStrings.noInternet.tr();
      default:
        return AppStrings.unexpectedError.tr();
    }
  }
}
