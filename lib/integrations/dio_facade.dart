import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:recipes_app/core/domain/facades/http_facade.dart';
import 'package:recipes_app/core/domain/models/http/http_failure.dart';
import 'package:recipes_app/core/domain/models/http/http_response.dart';

class HttpDioFacade implements HttpFacade {
  HttpDioFacade() {
    _dio = Dio(
      BaseOptions(
        contentType: 'application/json; charset=UTF-8',
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    if (!kReleaseMode) {
      _dio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: true),
      );
    }
  }
  late Dio _dio;

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return resolve(() => _dio.get(url, queryParameters: queryParameters));
  }

  @override
  Future<HttpResponse> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return resolve(
      () => _dio.post(url, data: body, queryParameters: queryParameters),
    );
  }

  @override
  Future<HttpResponse> put(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return resolve(
      () => _dio.put(url, data: body, queryParameters: queryParameters),
    );
  }

  @override
  Future<HttpResponse> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return resolve(() => _dio.delete(url, queryParameters: queryParameters));
  }

  Future<HttpResponse> resolve(Future<Response> Function() request) async {
    try {
      final Response response = await request();
      return HttpResponse(data: response.data);
    } catch (e) {
      throw HttpFailure();
    }
  }
}
