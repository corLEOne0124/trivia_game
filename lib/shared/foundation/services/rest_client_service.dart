import 'dart:developer';

import 'package:trivia_game/shared/foundation/helpers/functions/debugging_helpers.dart';
import 'package:trivia_game/shared/foundation/helpers/functions/locator.dart';
import 'package:trivia_game/shared/foundation/services/secure_storage_service.dart';

import '../models/data_containers/rest_client_response.dart';
import 'package:dio/dio.dart' as dio;

class RestClientService {
  final _dio = dio.Dio()
    ..options.validateStatus = (int? statusCode) {
      return true;
    };
  SecureStorageService get _secureStorageService =>
      locator<SecureStorageService>();

  Future<RestClientResponse> get(
    Uri endpoint, {
    Map<int, Exception>? exceptions,
    bool hasToken = true,
  }) async {
    final String? token = await _secureStorageService.token;

    final Map<String, dynamic> headers = {
      if (token != null && hasToken) "Authorization": "Bearer $token",
    };

    final result = await _dio.get(
      endpoint.toString(),
      options: dio.Options(
        headers: headers,
      ),
    );
    log('---');
    logRestfulRequest(endpoint: endpoint, headers: headers);
    logRestfulResponse(
      statusCode: result.statusCode,
      headers: result.headers,
      body: result.data,
    );

    if (exceptions != null) {
      if (exceptions.containsKey(result.statusCode)) {
        final exception = exceptions[result.statusCode];

        throw exception!;
      }
    }

    final validStatusCodes = [200, 201];
    if (validStatusCodes.contains(result.statusCode)) {
      final restClientResponse = RestClientResponse(
        body: result.data is Map<String, dynamic>
            ? result.data as Map<String, dynamic>
            : null,
        bodyList:
            result.data is List<dynamic> ? result.data as List<dynamic> : null,
        statusCode: result.statusCode,
        headers: result.headers.map,
      );

      return restClientResponse;
    } else if (result.statusCode == 401) {
      throw 'Token expired: => ${result.statusCode}';
    } else {
      throw 'Invalid request status: $endpoint -> ${result.statusCode}';
    }
  }
}
