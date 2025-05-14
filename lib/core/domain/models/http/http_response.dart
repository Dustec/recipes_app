class HttpResponse {
  const HttpResponse({required this.data});
  final dynamic data;

  bool get isSuccess => data != null;
}
