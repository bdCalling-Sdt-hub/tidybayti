import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';

import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class HouseTypeScreen extends StatefulWidget {
  const HouseTypeScreen({super.key});

  @override
  State<HouseTypeScreen> createState() => _HouseTypeScreenState();
}

class _HouseTypeScreenState extends State<HouseTypeScreen> {
  List categoryType = [
    'Custom',
    'Bungalow',
    'Villa',
    'In. Home',
    'Apartment',
    'Mansion'
  ];
  List houseTextColor = [
    AppColors.dark500,
    AppColors.dark500,
    AppColors.dark500,
    AppColors.red,
    AppColors.freeServiceColor,
    AppColors.dark300,
  ];

  List houseImages = [
    AppImages.custom,
    AppImages.mansion,
    AppImages.bungalow,
    AppImages.villa,
    AppImages.house,
    AppImages.apartMent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.freeServiceColor,
      body: Stack(
        children: [
          // Background image
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              AppImages.onBoardBackground,
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 64.h, horizontal: 20.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: 'Choose your House Type',
                    color: AppColors.employeeCardColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.h,
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                const CustomImage(
                  imageSrc: AppImages.houseImages,
                  imageType: ImageType.png,
                ),
                SizedBox(
                  height: 50.h,
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 18,
                            mainAxisExtent: 100),
                    itemCount: categoryType.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Get.toNamed(AppRoutes.houseInformationScreen,
                          //     arguments: index == 0
                          //         ? ""
                          //         : categoryType[index]);
                          Get.toNamed(AppRoutes.houseInformationScreen);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 4,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 14.h, horizontal: 12.w),
                          child: Column(
                            children: [
                              CustomImage(
                                imageSrc: houseImages[index],
                                imageType: ImageType.png,
                              ),
                              CustomText(
                                text: categoryType[index],
                                color: AppColors.dark500,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
