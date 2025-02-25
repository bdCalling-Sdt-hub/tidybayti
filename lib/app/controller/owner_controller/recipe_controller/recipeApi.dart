import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipe_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class RecipeApi {
  ///==================================✅✅addRecipe✅✅=======================

  static Future<void> addRecipe({
    required BuildContext context, // Add this line
    required String recipeName,
    required File recipeImage,
    required String cookingTime,
    required String description,
    required List ingredients,
    required List steps,
    required List tags,
  }) async {
    RecipeController recipeController = Get.find();
    recipeController.setLoading(true);

    var url = Uri.parse(ApiUrl.addRecipe);

    var request = http.MultipartRequest("POST", url);

    request.fields["recipeName"] = recipeName;
    request.fields["cookingTime"] = cookingTime;
    request.fields["description"] = description;
    request.fields["ingredients"] = jsonEncode(ingredients);
    request.fields["steps"] = jsonEncode(steps);
    request.fields["tags"] = jsonEncode(tags);



    request.files.add(await http.MultipartFile.fromPath(
      "recipeImage",
      recipeImage.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    String? savedToken = await SharePrefsHelper.getString(AppConstants.token);
    var token = savedToken;

    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
    });

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      recipeController
          .setLoading(false); // Set loading to false after request

      if (response.statusCode == 201) {
        recipeController.getMyRecipe();
            Get.toNamed(AppRoutes.myRecipeScreen);
           recipeController.clearRecipeField();
        toastMessage(message: "✅Recipe added successfully");
        print("✅ Recipe added successfully");
        print(responseData);
      } else {
        print("❌ Failed: ${response.statusCode}");
        print("❌ Error Response: $responseData");

        String errorMessage = "Something went wrong!";
        try {
          var decodedData = json.decode(responseData);
          if (decodedData["message"] != null) {
            errorMessage = decodedData["message"];
          }
        } catch (e) {
          print("❌ JSON Parsing Error: $e");
        }

        toastMessage(message: "❌ $errorMessage");
      }
    } catch (e) {
      recipeController.setLoading(false);
      toastMessage(
          message: "❌ An error occurred. Please check your connection.");
      print("❌ Error: $e");
    }
  }


 ///==================================✅✅Edit recipe✅✅=======================

  static Future<void> editRecipe({
    required BuildContext context, // Add this line
    required String recipeName,
    required File recipeImage,
    required String cookingTime,
    required String description,
    required String recipeId,
    required List ingredients,
    required List steps,
    required List tags,
  }) async {
    RecipeController recipeController = Get.find();
    recipeController.setEditLoading(true);

    var url = Uri.parse(ApiUrl.updateRecipe);

    var request = http.MultipartRequest("PATCH", url);

    request.fields["recipeName"] = recipeName;
    request.fields["cookingTime"] = cookingTime;
    request.fields["description"] = description;
    request.fields["recipeId"] = recipeId;
    request.fields["ingredients"] = jsonEncode(ingredients);
    request.fields["steps"] = jsonEncode(steps);
    request.fields["tags"] = jsonEncode(tags);



    request.files.add(await http.MultipartFile.fromPath(
      "recipeImage",
      recipeImage.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    String? savedToken = await SharePrefsHelper.getString(AppConstants.token);
    var token = savedToken;

    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
    });

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      recipeController
          .setEditLoading(false); // Set loading to false after request

      if (response.statusCode == 200) {
                recipeController.getRecipeSingle(recipeId: recipeId);
            Get.back();


        toastMessage(message: "✅Recipe Update successfully");
        print("✅ Recipe Update successfully");
        print(responseData);
      } else {
        print("❌ Failed: ${response.statusCode}");
        print("❌ Error Response: $responseData");

        String errorMessage = "Something went wrong!";
        try {
          var decodedData = json.decode(responseData);
          if (decodedData["message"] != null) {
            errorMessage = decodedData["message"];
          }
        } catch (e) {
          print("❌ JSON Parsing Error: $e");
        }

        toastMessage(message: "❌ $errorMessage");
      }
    } catch (e) {
      recipeController.setLoading(false);
      toastMessage(
          message: "❌ An error occurred. Please check your connection.");
      print("❌ Error: $e");
    }
  }


}
