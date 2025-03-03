import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         CustomText(
          text: AppStrings.employees.tr,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: AppColors.blue900,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.allEmployeeShow);
          },
          child:  CustomText(
            text: AppStrings.seeAll.tr,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.dark300,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}