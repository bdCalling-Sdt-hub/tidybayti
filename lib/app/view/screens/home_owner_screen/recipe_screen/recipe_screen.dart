import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_menu_item/custom_menu_item.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

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

          Positioned(
            child:SizedBox(
              height: MediaQuery.of(context).size.height,

              child: SafeArea(
                child: Column(
                  children: [
                    /// Menu Title
                    const CustomText(
                      text: 'Recipe',
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: AppColors.dark500,
                    ),

                    const SizedBox(height: 100), // Space between title and menu items

                    /// Menu Items
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16.0),
                        children: [
                          /// Add Recipe
                          CustomMenuItem(
                            image: AppIcons.add,
                            text: AppStrings.addRecipe,
                            onTap: () {
                              Get.toNamed(AppRoutes.addRecipeScreen);
                            },
                          ),
                          /// My Recipe
                          CustomMenuItem(
                            image: AppIcons.myRecipe,
                            text: AppStrings.myRecipe,
                            onTap: () {
                              Get.toNamed(AppRoutes.myRecipeScreen);
                            },
                          ),
                          /// Search Recipe
                          CustomMenuItem(
                            image: AppIcons.search,
                            text: AppStrings.searchRecipe,
                            onTap: () {
                              Get.toNamed(AppRoutes.searchRecipeScreen);
                            },
                          ),
                          /// Favorite Recipes
                          CustomMenuItem(
                            image: AppIcons.favorite,
                            text: AppStrings.favoriteRecipes,
                            onTap: () {
                              Get.toNamed(AppRoutes.favoritesRecipeScreen);
                            },
                          ),
                          /// Tags
                          CustomMenuItem(
                            image: AppIcons.tags,
                            text: AppStrings.tags,
                            onTap: () {
                              Get.toNamed(AppRoutes.tagsScreen);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ) ,
          )

        ],
      ),
    );
  }
}
