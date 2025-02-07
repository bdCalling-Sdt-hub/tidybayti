import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
class ChoseOnboardScreen extends StatelessWidget {
  const ChoseOnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                AppImages.onBoardBackground,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 350.h,
                  ),

                  ///============================Owner Button=============
                  Center(
                    child: Column(
                      children: [
                        CustomButton(
                          width: MediaQuery.of(context).size.width / 1.7,
                          onTap: () {
                            Get.toNamed(AppRoutes.homeOwnerChoseAuth);
                          },
                          fillColor: AppColors.employeeCardColor,
                          title: AppStrings.owner,
                        ),

                        ///============================Employee Button=============
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomButton(
                          width: MediaQuery.of(context).size.width / 1.7,
                          onTap: () {
                            Get.toNamed(AppRoutes.employeeSignInScreen);
                          },
                          fillColor: AppColors.employeeCardColor,
                          title: AppStrings.employee,
                        ),
                        // SizedBox(
                        //   height: 255.h,
                        // ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const CircleAvatar(
                        //       radius: 5,
                        //       backgroundColor: AppColors.customRedColor,
                        //     ),
                        //     SizedBox(
                        //       width: 10.w,
                        //     ),
                        //     const CircleAvatar(
                        //       radius: 6,
                        //       backgroundColor: AppColors.red,
                        //     ),
                        //     SizedBox(
                        //       width: 10.w,
                        //     ),
                        //     const CircleAvatar(
                        //       radius: 5,
                        //       backgroundColor: AppColors.customRedColor,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
