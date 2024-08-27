class RestClientResponse {
  final int? statusCode;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;
  final List<dynamic>? bodyList;

  const RestClientResponse({
    required this.statusCode,
    required this.headers,
    required this.body,
    required this.bodyList,
  });
}
