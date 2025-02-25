import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/recipe/my_recipe.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class RecipeController extends GetxController{
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
  final  describeStepsController = TextEditingController();
  final  recipeNameController = TextEditingController();
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



  @override
  void onInit() {
    getMyRecipe();
    super.onInit();
  }



}