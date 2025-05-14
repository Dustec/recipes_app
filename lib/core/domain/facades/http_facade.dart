import 'package:recipes_app/core/domain/extensions/app_extensions.dart';
import 'package:recipes_app/core/domain/models/http/http_failure.dart';
import 'package:recipes_app/core/domain/models/http/http_response.dart';

abstract class HttpFacade {
  Future<HttpResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> put(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}

typedef HttpMapper<T> = T Function(dynamic);

extension HttpFacadeEx on Future<HttpResponse> {
  Stream<T> handle<T>({required HttpMapper<T> mapper}) async* {
    try {
      final HttpResponse response = await this;
      if (response.isSuccess) {
        final T parsedObject = mapper(
          safeCast<Map<String, dynamic>>(response.data) ??
              safeCast<List<dynamic>>(response.data) ??
              <String, dynamic>{},
        );
        yield parsedObject;
      } else {
        throw HttpFailure();
      }
    } catch (e) {
      // This will be handled by the caller
      // Also we can handle cross app failures here if business logic requires it
      rethrow;
    }
  }
}
