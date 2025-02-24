import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipe_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_recipe_card/custom_recipe_card.dart';

import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ///=============================== Search ========================
                        const CustomTextField(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search',
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
                        Column(
                          children: List.generate(4, (index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.myRecipeDetails);
                              },
                              child: CustomRecipeCard(
                                  isFavorite: true,
                                  title: 'Idlis Steamed Rice ..',
                                  cuisine: 'Asian / Indian',
                                  cookTime: '30 min',
                                  imageUrl: AppConstants.fruits),
                            );
                          }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
