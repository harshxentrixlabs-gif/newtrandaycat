import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../utils/app_print.dart';
import '../utils/app_storage.dart';

class ApiResponse<T> {
  final bool success;
  final T? data;
  final String message;
  final int? statusCode;
  final dynamic error;

  ApiResponse({
    required this.success,
    this.data,
    required this.message,
    this.statusCode,
    this.error,
  });

  factory ApiResponse.success(T data, {String message = 'Success', int? statusCode}) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode, dynamic error}) {
    return ApiResponse<T>(
      success: false,
      message: message,
      statusCode: statusCode,
      error: error,
    );
  }
}

class AppApi {
  static AppApi? _instance;
  late Dio _dio;

  // Singleton pattern
  static AppApi getInstance() {
    _instance ??= AppApi._internal();
    return _instance!;
  }

  AppApi._internal() {
    _dio = Dio();
    _setupInterceptors();
    final token = AppStorage().read<String>("token");
    AppLogs.log("$token", tag: 'API_LOG_ACCESS_TOKEN');
    if (token != null && token.isNotEmpty) {
      setAuthToken(token);
    }
  }

  // Setup interceptors for enhanced logging
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final method = options.method.toUpperCase();
          final url = options.uri.toString();

          AppLogs.log(
            '\n${"=" * 25}$method API${"=" * 25}\nURL: $url',
            tag: 'API_LOG_REQUEST',
            color: Colors.blue,
          );

          if (options.data != null) {
            final formattedData = _formatJson(options.data);
            AppLogs.log(
              'Request Body:\n$formattedData',
              tag: 'API_LOG_REQUEST_BODY',
              color: Colors.cyan,
            );
          }

          if (options.queryParameters.isNotEmpty) {
            AppLogs.log(
              'Query Parameters:\n${_formatJson(options.queryParameters)}',
              tag: 'API_LOG_QUERY_PARAMS',
              color: Colors.cyan,
            );
          }

          handler.next(options);
        },
        onResponse: (response, handler) {
          final method = response.requestOptions.method.toUpperCase();
          final url = response.requestOptions.uri.toString();
          final statusCode = response.statusCode;
          AppLogs.log(
            'Status Code: $statusCode',
            tag: 'API_LOG_STATUS_CODE',
            color: Colors.green,
          );

          final formattedResponse = _formatJson(response.data);
          AppLogs.log(
            'Response:\n$formattedResponse',
            tag: 'API_LOG_RESPONSE',
            color: Colors.green,
          );

          AppLogs.log(
            '${"=" * 25}END $method${"=" * 25}\n',
            tag: 'API_LOG_END',
            color: Colors.green,
          );

          handler.next(response);
        },
        onError: (error, handler) {
          final method = error.requestOptions.method.toUpperCase();
          final url = error.requestOptions.uri.toString();
          final statusCode = error.response?.statusCode;

          AppLogs.log(
            'Status Code: ${statusCode ?? "N/A"}',
            tag: 'API_LOG_ERROR_STATUS',
            color: Colors.red,
          );

          AppLogs.log(
            'Error: ${error.message}\n${error.response?.data != null ? _formatJson(error.response!.data) : ""}',
            tag: 'API_LOG_ERROR',
            color: Colors.red,
          );

          AppLogs.log(
            '${"=" * 25}END $method ERROR${"=" * 25}\n',
            tag: 'API_LOG_END',
            color: Colors.red,
          );
          handler.next(error);
        },
      ),
    );
  }

  // Format JSON for better readability
  String _formatJson(dynamic data) {
    try {
      if (data is String) {
        // Try to parse if it's a JSON string
        try {
          final decoded = json.decode(data);
          return const JsonEncoder.withIndent('  ').convert(decoded);
        } catch (_) {
          return data;
        }
      }
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (e) {
      return data.toString();
    }
  }

  // Set base URL
  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    AppLogs.log('$baseUrl', tag: 'API_LOG_BASE_URL', color: Colors.yellow);
  }

  // Set headers
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
    AppLogs.log('${_formatJson(headers)}', tag: 'API_LOG_HEADERS', color: Colors.yellow);
  }

  // Set Authorization token
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    AppLogs.log('Bearer ${token.substring(0, token.length > 20 ? 20 : token.length)}...',
        tag: 'API_LOG_AUTH_TOKEN', color: Colors.yellow);
  }

  // Set timeout
  void setTimeout({int connectTimeout = 30000, int receiveTimeout = 30000}) {
    _dio.options.connectTimeout = Duration(milliseconds: connectTimeout);
    _dio.options.receiveTimeout = Duration(milliseconds: receiveTimeout);
    AppLogs.log('Connect: ${connectTimeout}ms, Receive: ${receiveTimeout}ms',
        tag: 'API_LOG_TIMEOUT', color: Colors.yellow);
  }

  // Handle DioException and convert to ApiResponse
  ApiResponse<T> _handleError<T>(DioException error) {
    String errorMessage;
    int? statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout';
        break;
      case DioExceptionType.badResponse:
        errorMessage = error.response?.data['message'] ??
            error.response?.statusMessage ??
            'Server error occurred';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection';
        break;
      default:
        errorMessage = 'Unknown error occurred';
    }

    return ApiResponse<T>.error(errorMessage, statusCode: statusCode, error: error);
  }

  // GET Request
  Future<ApiResponse<T>> get<T>(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.success(
        response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      AppLogs.log('$e', tag: 'API_LOG_UNEXPECTED_ERROR', color: Colors.red);
      return ApiResponse<T>.error('Unexpected error occurred');
    }
  }

  // POST Request
  Future<ApiResponse<T>> post<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.success(
        response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      AppLogs.log('$e', tag: 'API_LOG_UNEXPECTED_ERROR', color: Colors.red);
      return ApiResponse<T>.error('Unexpected error occurred');
    }
  }

  // PUT Request
  Future<ApiResponse<T>> put<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.success(
        response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      AppLogs.log('$e', tag: 'API_LOG_UNEXPECTED_ERROR', color: Colors.red);
      return ApiResponse<T>.error('Unexpected error occurred');
    }
  }

  // DELETE Request
  Future<ApiResponse<T>> delete<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.success(
        response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      AppLogs.log('$e', tag: 'API_LOG_UNEXPECTED_ERROR', color: Colors.red);
      return ApiResponse<T>.error('Unexpected error occurred');
    }
  }

  // PATCH Request
  Future<ApiResponse<T>> patch<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.success(
        response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      AppLogs.log('$e', tag: 'API_LOG_UNEXPECTED_ERROR', color: Colors.red);
      return ApiResponse<T>.error('Unexpected error occurred');
    }
  }

  // File Upload
  Future<ApiResponse<T>> uploadFile<T>(
      String endpoint,
      String filePath, {
        String fieldName = 'file',
        Map<String, dynamic>? additionalData,
        ProgressCallback? onSendProgress,
      }) async {
    try {
      FormData formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
        if (additionalData != null) ...additionalData,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onSendProgress,
      );

      return ApiResponse<T>.success(
        response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      AppLogs.log('$e', tag: 'API_LOG_UPLOAD_ERROR', color: Colors.red);
      return ApiResponse<T>.error('File upload failed');
    }
  }

  // Download File
  Future<ApiResponse<String>> downloadFile(
      String endpoint,
      String savePath, {
        ProgressCallback? onReceiveProgress,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      await _dio.download(
        endpoint,
        savePath,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );

      return ApiResponse<String>.success(savePath, message: 'File downloaded successfully');
    } on DioException catch (e) {
      return _handleError<String>(e);
    } catch (e) {
      AppLogs.log('$e', tag: 'API_LOG_DOWNLOAD_ERROR', color: Colors.red);
      return ApiResponse<String>.error('File download failed');
    }
  }

  // Cancel all requests
  void cancelAllRequests() {
    _dio.close(force: true);
    AppLogs.log('All requests cancelled', tag: 'API_LOG_CANCEL', color: Colors.yellow);
  }
}