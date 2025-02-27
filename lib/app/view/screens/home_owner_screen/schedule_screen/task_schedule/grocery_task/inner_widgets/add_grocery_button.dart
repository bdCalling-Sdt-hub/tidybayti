import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class AddGroceryButton extends StatelessWidget {
  const AddGroceryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.addGroceryTask),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(20),
        color: AppColors.blue50,
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomImage(imageSrc: AppIcons.add),
            CustomText(
              left: 10,
              text: AppStrings.addGrocery.tr,
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: AppColors.dark400,
            ),
          ],
        ),
      ),
    );
  }
}
