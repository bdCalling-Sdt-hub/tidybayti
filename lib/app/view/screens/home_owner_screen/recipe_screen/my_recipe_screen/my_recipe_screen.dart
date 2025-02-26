import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipe_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/global_alart/global_alart.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_recipe_card/custom_recipe_card.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class MyRecipeScreen extends StatelessWidget {
  MyRecipeScreen({super.key});

  final RecipeController recipeController = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    title: AppStrings.myRecipe.tr,
                    onBack: () {
                      Get.back();
                    },
                  ),
                  ///=============================== Search ========================

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextField(
                      onFieldSubmitted: (value) {
                        recipeController.searchRecipe(recipeName: value);
                      },
                      // textEditingController: homeController.searchController,
                      hintText: AppStrings.search.tr,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      fillColor: Colors.white,
                      fieldBorderColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const Divider(
                    color: AppColors.blue500,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),


                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:
                      Obx(() {
                        switch (recipeController.rxRequestStatus.value) {
                          case Status.loading:
                            return const Center(child: CustomLoader());

                          case Status.internetError:
                            return Center(
                              child: NoInternetScreen(
                                onTap: () {
                                  recipeController.getMyRecipe();
                                },
                              ),
                            );

                          case Status.error:
                            return const Center(
                              child: Text("Error loading recipes"),
                            );

                          case Status.completed:
                            final recipes = recipeController.myRecipeData.value.recipeWithFavorite ?? [];

                            if (recipes.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No Recipe Found",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              );
                            }

                            // Load favorite status when recipes are loaded
                            recipeController.loadFavoriteStatus(recipes);

                            return ListView.builder(
                              itemCount: recipes.length,
                              itemBuilder: (context, index) {
                                final data = recipes[index];
                                final isFavorite = data.isFavorite ?? false; // Fetch from API

                                return GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoutes.myRecipeDetails,arguments: data.id);
                                  },
                                  child: CustomRecipeCard(
                                    recipeId: data.id ?? "",
                                    title: data.recipeName ?? "Untitled Recipe",
                                    cuisine: data.description??"",
                                    cookTime: data.cookingTime ?? "N/A",
                                    imageUrl: "${ApiUrl.networkUrl}${data.recipeImage ?? ""}",
                                    isFavorite: recipeController.getFavoriteStatus(data.id ?? "", isFavorite), // ✅ Corrected
                                    onFavorite: () => recipeController.toggleFavorite(data.id ?? ""),
                                    isDelete: true,
                                    onDelete: () {
                                      GlobalAlert.showDeleteDialog(context, () {
                                        recipeController.removeRecipe(recipeId: data.id ?? "");
                                      }, "Remove My Recipe");
                                    },
                                  ),
                                );
                              },
                            );
                        }
                      })

                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
