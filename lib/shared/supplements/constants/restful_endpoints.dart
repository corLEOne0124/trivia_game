import 'package:trivia_game/shared/supplements/constants/app_constants.dart';

const restfulEndpoints = RestfulEndpoints();

class RestfulEndpoints {
  const RestfulEndpoints();

  String get _baseAuthority => appConstants.baseAuthority;
  String get _basePath => appConstants.basePath;

  Uri getSessionToken() {
    return Uri.https(
        _baseAuthority, '$_basePath/api_token.php', {"command": "request"});
  }

  Uri getCategories() {
    return Uri.https(
      _baseAuthority,
      '$_basePath/api_category.php',
    );
  }

  Uri getQuestions({
    int amount = 10,
    int? category,
    String? level,
    String? token,
  }) {
    return Uri.https(_baseAuthority, '$_basePath/api.php', {
      "category": category.toString(),
      "difficulty": level,
      "token": token,
      "amount": amount.toString(),
    });
  }
}
