import 'dart:developer';

import 'package:flutter/material.dart';

void logRestfulRequest({
  required endpoint,
  required headers,
  body,
}) {
  log('ENDPOINT: $endpoint');
  log('REQUEST HEADERS: $headers');
  log('REQUEST BODY: $body');
  
}

void logRestfulResponse({
  required statusCode,
  required headers,
  required body,
}) {
  log('STATUS CODE: $statusCode');
  log('RESPONSE HEADERS: $headers');
  log('RESPONSE BODY: $body');
}

void logError(dynamic e, dynamic s) {
  if (e != null) debugPrint(e.toString());
  if (s != null) debugPrint(s.toString());
}
