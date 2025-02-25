import 'dart:convert';

class RecipeSingle {
  int? statusCode;
  bool? success;
  String? message;
  RecipeSingleData? data;

  RecipeSingle({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory RecipeSingle.fromRawJson(String str) => RecipeSingle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeSingle.fromJson(Map<String, dynamic> json) => RecipeSingle(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : RecipeSingleData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class RecipeSingleData {
  String? id;
  String? user;
  String? recipeName;
  String? recipeImage;
  String? cookingTime;
  String? description;
  List<String>? ingredients;
  List<String>? steps;
  List<String>? tags;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  RecipeSingleData({
    this.id,
    this.user,
    this.recipeName,
    this.recipeImage,
    this.cookingTime,
    this.description,
    this.ingredients,
    this.steps,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RecipeSingleData.fromRawJson(String str) => RecipeSingleData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeSingleData.fromJson(Map<String, dynamic> json) => RecipeSingleData(
    id: json["_id"],
    user: json["user"],
    recipeName: json["recipeName"],
    recipeImage: json["recipeImage"],
    cookingTime: json["cookingTime"],
    description: json["description"],
    ingredients: json["ingredients"] == null ? [] : List<String>.from(json["ingredients"]!.map((x) => x)),
    steps: json["steps"] == null ? [] : List<String>.from(json["steps"]!.map((x) => x)),
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "recipeName": recipeName,
    "recipeImage": recipeImage,
    "cookingTime": cookingTime,
    "description": description,
    "ingredients": ingredients == null ? [] : List<dynamic>.from(ingredients!.map((x) => x)),
    "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x)),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
