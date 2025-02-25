import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
import '../../../../components/recipe_button/recipe_button.dart';

class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});

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
                      title: AppStrings.addRecipe.tr,
                      onBack: () {
                        Get.back();
                      },
                    ),
                    SizedBox(height: 200.h), // Space between title and menu items

                    RecipeButton(
                      text: 'New blank recipe',
                      onPressed: () {
                          Get.toNamed(AppRoutes.addNewRecipe);
                      },
                    ),
                    RecipeButton(
                      text: 'Import From Website',
                      onPressed: () {
                        importDialog(context);
                      },
                    ),
                    RecipeButton(
                      text: 'Upload File',
                      onPressed: () {
                        uploadFileDialog(context);
                      },
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

void importDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)), // Adjust the radius as needed
        ),
        title: Row(
          children: [
            const CustomText(
              text: AppStrings.importFromWebsite,
              color: AppColors.dark400,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              right: 10,
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const CustomImage(imageSrc: AppIcons.x))
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomTextField(
              fillColor: AppColors.blue300,
              hintText: AppStrings.recipeName,
            ),
            SizedBox(
              height: 15.h,
            ),
            const CustomTextField(
              fillColor: AppColors.blue300,
              hintText: AppStrings.addPhoto,
              suffixIcon: Icon(Icons.photo_camera_back),
            ),
            SizedBox(
              height: 15.h,
            ),
            const CustomTextField(
              fillColor: AppColors.blue300,
              hintText: AppStrings.urlHere,
            ),
            SizedBox(
              height: 25.h,
            ),
            CustomButton(
              onTap: () {
                Get.back();
              },
              fillColor: AppColors.blue300,
              title: AppStrings.save,
            )
          ],
        ),
      );
    },
  );
}

void uploadFileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)), // Adjust the radius as needed
        ),
        title: Row(
          children: [
           SizedBox(width: 35.w,),
            const CustomText(
              text: AppStrings.uploadFile,
              color: AppColors.dark400,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const CustomImage(imageSrc: AppIcons.x))
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomTextField(
              fillColor: AppColors.blue300,
              hintText: AppStrings.recipeName,
            ),
            SizedBox(
              height: 15.h,
            ),
            const CustomTextField(
              fillColor: AppColors.blue300,
              hintText: AppStrings.addPhoto,
              suffixIcon: Icon(Icons.photo_camera_back),
            ),
            SizedBox(
              height: 15.h,
            ),
            const CustomTextField(
              fillColor: AppColors.blue300,
              hintText: 'Upload file/pdf file',
            ),
            SizedBox(
              height: 25.h,
            ),
            CustomButton(
              onTap: () {
                Get.back();
              },
              fillColor: AppColors.blue300,
              title: AppStrings.save,
            )
          ],
        ),
      );
    },
  );
}
