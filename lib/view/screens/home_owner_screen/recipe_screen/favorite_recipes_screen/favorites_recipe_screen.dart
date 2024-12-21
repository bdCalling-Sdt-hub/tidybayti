import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/utils/app_images/app_images.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_recipe_card/custom_recipe_card.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';


class FavoritesRecipeScreen extends StatelessWidget {
  const FavoritesRecipeScreen({super.key});

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
                    title: AppStrings.favoriteRecipes,
                    onBack: () {
                      Get.back();
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [

                        SizedBox(
                          height: 32.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.myRecipeDetails);
                          },
                          child: CustomRecipeCard(
                            isFavorite: false,
                              title: 'Idlis Steamed Rice ..',
                              cuisine: 'Asian / Indian',
                              cookTime: '30 min',
                              imageUrl: AppConstants.fruits),
                        ),

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
