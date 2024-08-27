// To parse this JSON data, do
//
//     final questionResponse = questionResponseFromJson(jsonString);

import 'dart:convert';

QuestionResponse questionResponseFromJson(String str) => QuestionResponse.fromJson(json.decode(str));

String questionResponseToJson(QuestionResponse data) => json.encode(data.toJson());

class QuestionResponse {
    final int responseCode;
    final List<Result> results;

    QuestionResponse({
        required this.responseCode,
        required this.results,
    });

    factory QuestionResponse.fromJson(Map<String, dynamic> json) => QuestionResponse(
        responseCode: json["response_code"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    final Type type;
    final Difficulty difficulty;
    final String category;
    final String question;
    final String correctAnswer;
    final List<String> incorrectAnswers;

    Result({
        required this.type,
        required this.difficulty,
        required this.category,
        required this.question,
        required this.correctAnswer,
        required this.incorrectAnswers,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        type: typeValues.map[json["type"]]!,
        difficulty: difficultyValues.map[json["difficulty"]]!,
        category: json["category"],
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers: List<String>.from(json["incorrect_answers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "difficulty": difficultyValues.reverse[difficulty],
        "category": category,
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
    };
}

enum Difficulty {
    easy,
    medium,
    hard,
}

final difficultyValues = EnumValues({
    "easy": Difficulty.easy,
    "medium": Difficulty.medium,
    "hard": Difficulty.hard,
});

enum Type {
    boolean,
    multiple
}

final typeValues = EnumValues({
    "boolean": Type.boolean,
    "multiple": Type.multiple
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
