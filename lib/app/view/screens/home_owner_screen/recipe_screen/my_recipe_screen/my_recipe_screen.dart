import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipe_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Menu Title
                    CustomMenuAppbar(
                      title: AppStrings.myRecipe.tr,
                      onBack: () {
                        Get.back();
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          ///=============================== Search ========================

                          CustomTextField(
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
                          SizedBox(
                            height: 16.h,
                          ),
                          const Divider(
                            color: AppColors.blue500,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          ///=============================== My recipe List ========================

                          Obx(() {
                            switch (recipeController.rxRequestStatus.value) {
                              case Status.loading:
                                return const CustomLoader();

                              case Status.internetError:
                                return NoInternetScreen(onTap: () {
                                  recipeController.getMyRecipe();
                                });

                              case Status.error:
                                return GeneralErrorScreen(
                                  onTap: () {
                                    recipeController.getMyRecipe();
                                  },
                                );

                              case Status.completed:
                                final recipes = recipeController.myRecipeData
                                        .value.recipeWithFavorite ??
                                    [];

                                if (recipes.isEmpty) {
                                  // ✅ Show "No Recipe Found" when the list is empty
                                  return const Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 80),
                                      child: Text(
                                        "No Recipe Found",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return Column(
                                  children:
                                      List.generate(recipes.length, (index) {
                                    final data = recipes[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.myRecipeDetails);
                                      },
                                      child: CustomRecipeCard(
                                        onDelete: () {
                                          GlobalAlert.showDeleteDialog(context,
                                              () {

                                              }, "Remove My Recipe");
                                        },
                                        isFavorite: true,
                                        title: data.recipeName ??
                                            "Untitled Recipe",
                                        // ✅ Fixed missing title
                                        cuisine: 'Asian / Indian',
                                        cookTime: data.cookingTime ?? "N/A",
                                        imageUrl:
                                            "${ApiUrl.networkUrl}${data.recipeImage ?? ""}",
                                      ),
                                    );
                                  }),
                                );
                            }
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
