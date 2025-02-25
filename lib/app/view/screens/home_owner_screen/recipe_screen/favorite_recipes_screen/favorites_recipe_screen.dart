import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipe_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_recipe_card/custom_recipe_card.dart';

import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class FavoritesRecipeScreen extends StatelessWidget {
   FavoritesRecipeScreen({super.key});


  final RecipeController recipeController = Get.find<RecipeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 3),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              AppImages.recipeBacground,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Column(
                children: [
                  /// Menu Title
                  CustomMenuAppbar(
                    title: AppStrings.favoriteRecipes.tr,
                    onBack: () {
                      Get.back();
                    },
                  ),

                  Obx(() {
                    switch (recipeController.rxRequestStatus.value) {
                      case Status.loading:
                        return const CustomLoader();

                      case Status.internetError:
                        return NoInternetScreen(onTap: recipeController.getMyRecipe);

                      case Status.error:
                        return GeneralErrorScreen(onTap: recipeController.getMyRecipe);

                      case Status.completed:
                      // ✅ Filter only favorite recipes
                        final favoriteRecipes = recipeController.myRecipeData.value.recipeWithFavorite
                            ?.where((recipe) => recipe.isFavorite == true)
                            .toList() ?? [];

                        if (favoriteRecipes.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "No Favorite Recipes Found",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        }

                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            itemCount: favoriteRecipes.length,
                            itemBuilder: (context, index) {
                              final data = favoriteRecipes[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.myRecipeDetails);
                                },
                                child: CustomRecipeCard(

                                  title: data.recipeName ?? "Untitled Recipe", // ✅ Fixed title
                                  cuisine: '',
                                  cookTime: data.cookingTime ?? "N/A",
                                  imageUrl: "${ApiUrl.networkUrl}${data.recipeImage ?? ""}", recipeId: '', isFavorite: true.obs,
                                ),
                              );
                            },
                          ),
                        );
                    }
                  })

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
