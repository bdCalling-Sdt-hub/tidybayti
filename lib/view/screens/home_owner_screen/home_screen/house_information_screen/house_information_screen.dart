import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';

class HouseInformationScreen extends StatelessWidget {
  const HouseInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xCCF5F5F5), // First color (with opacity)
              Color(0xFFB5D8EE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=============================== Menu Title ========================
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Menu Title
                  /// Menu Title
                  CustomMenuAppbar(
                    title: AppStrings.houseInformation,
                    onBack: () {
                      Get.back();
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const CustomTextField(
                          hintText: AppStrings.houseName,
                        ),
                        SizedBox(
                          height: 42.h,
                        ),
                        const Row(
                          children: [
                            CustomImage(imageSrc: AppIcons.addRoom),
                            CustomText(
                              left: 10,
                              text: AppStrings.addNewRoom,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: AppColors.dark500,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomButton(
        width: MediaQuery.of(context).size.width / 1.1,
        onTap: () {
          Get.toNamed(AppRoutes.homeScreen);
        },
        fillColor: Colors.white,
        title: AppStrings.save,
      ),
    );
  }
}
