import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_images/app_images.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

import '../../../../components/recipe_button/recipe_button.dart';

class MyRecipeScreen extends StatelessWidget {
  const MyRecipeScreen({super.key});

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
                    title: AppStrings.myRecipe,
                    onBack: () {
                      Get.back();
                    },
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
