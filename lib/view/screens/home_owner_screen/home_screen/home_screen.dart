import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_images/app_images.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HouseTypeScreenState();
}

class _HouseTypeScreenState extends State<HomeScreen> {
  final List<String> categoryType = [
    '',
    'Bungalow',
    'Villa',
    'In. Home',
    'Apartment',
    'Mansion'
  ];

  final List<Color> houseTextColor = [
    AppColors.dark500,
    AppColors.dark500,
    AppColors.dark500,
    AppColors.red,
    AppColors.freeServiceColor,
    AppColors.dark300,
  ];

  final List<String> houseImages = [
    AppImages.icon,
    AppImages.mansion,
    AppImages.bungalow,
    AppImages.villa,
    AppImages.house,
    AppImages.apartMent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 0),
      backgroundColor: AppColors.freeServiceColor,
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xCCE8F3FA), // First color (with opacity)
                  Color(0xFFB5D8EE),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Foreground content
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 64.h, horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 50.h),

                // Grid of house categories
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 18,
                    mainAxisExtent: 120, // Increased height for better visuals
                  ),
                  itemCount: categoryType.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
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
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 12.w),
                        // Adjusted padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Center content vertically
                          children: [
                            CustomImage(
                              imageSrc: houseImages[index],
                              imageType: ImageType.png,
                              // Fixed height for images
                            ),
                            SizedBox(height: 8.h),
                            // Space between image and text
                            CustomText(
                              text: categoryType[index],
                              color: houseTextColor[index],
                              // Use corresponding color
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              textAlign: TextAlign
                                  .center, // Centered text for better alignment
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    CustomText(
                      text: AppStrings.employees,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue900,
                    ),

                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.allEmployeeShow);
                      },
                      child: CustomText(
                        text: AppStrings.seeAll,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blue900,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
