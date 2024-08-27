import 'package:trivia_game/shared/foundation/models/restful_response/category_response.dart';
import 'package:trivia_game/shared/foundation/models/restful_response/question_response.dart';
import 'package:trivia_game/shared/foundation/models/restful_response/session_token_response.dart';
import 'package:trivia_game/shared/supplements/constants/restful_endpoints.dart';

import '../../shared/foundation/helpers/functions/locator.dart';
import '../../shared/foundation/services/rest_client_service.dart';

class TriviaRepository {
  RestClientService get _restClient => locator<RestClientService>();

  Future<SessionTokenResponse> getSessionToken() async {
    final endpoint = restfulEndpoints.getSessionToken();
    final result = await _restClient.get(
      endpoint,
    
      hasToken: false,
    
    );

    return SessionTokenResponse.fromJson(result.body!);
  }

  Future<CategoryResponse> getCategoryList() async {
    final endpoint = restfulEndpoints.getCategories();
    final result = await _restClient.get(endpoint, hasToken: false);
    return CategoryResponse.fromJson(result.body!);
  }

  Future<QuestionResponse> getQuestions(
      {int amount = 10, String? level, String? token, int? categoryId}) async {
    final endpoint = restfulEndpoints.getQuestions(
      amount: amount,
      token: token,
      category: categoryId,
      level: level,
    );
    final result = await _restClient.get(endpoint, hasToken: false);

    return QuestionResponse.fromJson(result.body!);
  }
}
