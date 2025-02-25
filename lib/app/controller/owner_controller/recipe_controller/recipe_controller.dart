import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/recipe/my_recipe.dart';
import 'package:tidybayte/app/data/model/owner_model/recipe/recipe_single.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class RecipeController extends GetxController {
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;
  ApiClient apiClient = serviceLocator();

  ///==================================✅✅get House Room✅✅=======================

  Rx<MyRecipeData> myRecipeData = MyRecipeData().obs;

  getMyRecipe() async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response =
          await apiClient.get(url: ApiUrl.myRecipe, showResult: true);

      if (response.statusCode == 200) {
        myRecipeData.value = MyRecipeData.fromJson(response.body["data"]);

        print('otp==================${response.statusCode}');
        print(
            'myRecipeData Length==================${myRecipeData.value.recipeWithFavorite?.length}');
        setRxRequestStatus(Status.completed);
        refresh();
      } else {
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
    }
  }

  ///==================================✅✅Add New Recipe✅✅=======================

  final ingredientsController = TextEditingController();
  final describeStepsController = TextEditingController();
  final recipeNameController = TextEditingController();
  final cookingTimeController = TextEditingController();
  final descriptionController = TextEditingController();

  ////Tag
  final List<String> categories = [
    'Appetizers',
    'Asian',
    'Breakfast',
    'Dessert',
    'Dinner',
  ];

  List<bool> selectedCategories = [];
  List<String> selectedCategoryNames = [];

  //ingeredients and step
  final List<String> ingredientsList = [];
  final List<String> stepsList = [];
  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  Rx<File?> profileImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
      print("✅ Selected Image:===== ${profileImage.value!.path}");
    } else {
      print("❌ No Image Selected");
    }
  }


clearRecipeField(){
    recipeNameController.clear();
    cookingTimeController.clear();
    descriptionController.clear();
    stepsList.clear();
    ingredientsList.clear();
    selectedCategoryNames.clear();


}

  ///==================================✅✅Search✅✅=======================
  TextEditingController searchController = TextEditingController();

  searchRecipe({required String recipeName}) async {
    setRxRequestStatus(Status.loading);
    myRecipeData.refresh();
    var response = await apiClient.get(url: "${ApiUrl.searchRecipe}=$recipeName");
    myRecipeData.refresh();
    if (response.statusCode == 200) {
      myRecipeData.value = MyRecipeData.fromJson(response.body["data"]);

      setRxRequestStatus(Status.completed);
      myRecipeData.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }


  ///==================================✅✅Remove Recipe✅✅=======================
  RxBool isRemoveRecipe = false.obs;

  removeRecipe({required String recipeId}) async {
    isRemoveRecipe.value = true;
    var body = {"recipeId": recipeId};

    var response = await apiClient.delete(body: body, url: ApiUrl.deleteRecipe);
    if (response.statusCode == 200) {
      getMyRecipe();
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isRemoveRecipe.value = false;
    isRemoveRecipe.refresh();
  }

  ///==================================✅✅Recipe Details✅✅=======================

  Rx<RecipeSingleData> recipeSingleData = RecipeSingleData().obs;

  getRecipeSingle({required String recipeId}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response =
      await apiClient.get(url: ApiUrl.singleRecipe(recipeId), showResult: true);

      if (response.statusCode == 200) {
        recipeSingleData.value = RecipeSingleData.fromJson(response.body["data"]);

        print('otp==================${response.statusCode}');
        print(
            'ingredients Length==================${recipeSingleData.value.ingredients?.length}');
        setRxRequestStatus(Status.completed);
        refresh();
      } else {
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
    }
  }


//Tags
  final List<Map<String, String>> tags = [
    {
      'title': 'Appetizers',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },
    {
      'title': 'Asian',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },
    {
      'title': 'Breakfast',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },
    {
      'title': 'Dessert',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },{
      'title': 'Dessert',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },
  ];
  @override
  void onInit() {
    getMyRecipe();
    super.onInit();
  }
}
