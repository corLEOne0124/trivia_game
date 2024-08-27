// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

CategoryResponse categoryResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  final List<TriviaCategory> triviaCategories;

  CategoryResponse({
    required this.triviaCategories,
  });

  CategoryResponse copyWith({
    List<TriviaCategory>? triviaCategories,
  }) =>
      CategoryResponse(
        triviaCategories: triviaCategories ?? this.triviaCategories,
      );

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        triviaCategories: List<TriviaCategory>.from(
            json["trivia_categories"].map((x) => TriviaCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trivia_categories":
            List<dynamic>.from(triviaCategories.map((x) => x.toJson())),
      };
}

class TriviaCategory {
  final int id;
  final String name;
  final String? icon;
  final LinearGradient? color;

  TriviaCategory({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  TriviaCategory copyWith({
    int? id,
    String? name,
    String? icon,
    LinearGradient? color,
  }) =>
      TriviaCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        color: color ?? this.color,
      );

  factory TriviaCategory.fromJson(Map<String, dynamic> json) => TriviaCategory(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
