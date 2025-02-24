import 'dart:convert';

class MyRecipeModel {
  int? statusCode;
  bool? success;
  String? message;
  MyRecipeData? data;

  MyRecipeModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory MyRecipeModel.fromRawJson(String str) => MyRecipeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyRecipeModel.fromJson(Map<String, dynamic> json) => MyRecipeModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : MyRecipeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class MyRecipeData {
  Meta? meta;
  List<RecipeWithFavorite>? recipeWithFavorite;

  MyRecipeData({
    this.meta,
    this.recipeWithFavorite,
  });

  factory MyRecipeData.fromRawJson(String str) => MyRecipeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyRecipeData.fromJson(Map<String, dynamic> json) => MyRecipeData(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    recipeWithFavorite: json["recipeWithFavorite"] == null ? [] : List<RecipeWithFavorite>.from(json["recipeWithFavorite"]!.map((x) => RecipeWithFavorite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "recipeWithFavorite": recipeWithFavorite == null ? [] : List<dynamic>.from(recipeWithFavorite!.map((x) => x.toJson())),
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}

class RecipeWithFavorite {
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
  bool? isFavorite;

  RecipeWithFavorite({
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
    this.isFavorite,
  });

  factory RecipeWithFavorite.fromRawJson(String str) => RecipeWithFavorite.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeWithFavorite.fromJson(Map<String, dynamic> json) => RecipeWithFavorite(
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
    isFavorite: json["isFavorite"],
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
    "isFavorite": isFavorite,
  };
}
