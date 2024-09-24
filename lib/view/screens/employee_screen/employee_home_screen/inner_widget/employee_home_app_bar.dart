import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class EmployeeHomeAppBar extends StatelessWidget {
  const EmployeeHomeAppBar({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color(0xffE8F3FA),
      margin: EdgeInsets.only(
        top: 32.h,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///====================================Top Section================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ///==================== Profile image =====================
                  CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl:AppConstants.userNtr,
                      height: 60,
                      width: 60),

                  SizedBox(
                    width: 16.w,
                  ),

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Sadhu',
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark400,
                        fontSize: 16,
                      ),  CustomText(
                        text: 'Assistant',
                        fontWeight: FontWeight.w500,
                        color: AppColors.dark300,
                        fontSize: 16,
                      ),

                      ///=====================user name =======================

                    ],
                  )
                ],
              ),
              SizedBox(
                width: 50.w,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.employeeNotificationScreen);
                },
                child: const CustomImage(
                  imageSrc: AppIcons.notification,
                  imageType: ImageType.svg,
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
