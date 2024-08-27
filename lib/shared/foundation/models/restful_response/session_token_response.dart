// To parse this JSON data, do
//
//     final sessionTokenResponse = sessionTokenResponseFromJson(jsonString);

import 'dart:convert';

SessionTokenResponse sessionTokenResponseFromJson(String str) => SessionTokenResponse.fromJson(json.decode(str));

String sessionTokenResponseToJson(SessionTokenResponse data) => json.encode(data.toJson());

class SessionTokenResponse {
    final int responseCode;
    final String responseMessage;
    final String token;

    SessionTokenResponse({
        required this.responseCode,
        required this.responseMessage,
        required this.token,
    });

    factory SessionTokenResponse.fromJson(Map<String, dynamic> json) => SessionTokenResponse(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_message": responseMessage,
        "token": token,
    };
}
