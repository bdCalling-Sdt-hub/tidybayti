import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';

import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';

import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';

import 'home_screen_inner_widgets/employee_show.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HouseTypeScreenState();
}

class _HouseTypeScreenState extends State<HomeScreen> {
  final List<String> categoryType = [
    'Add',
    'Bungalow',
    'Villa',
    'In. Home',
    'Apartment',
    'Mansion'
  ];

  final List<String> houseImages = [
    AppImages.icon,
    AppImages.mansion,
    AppImages.bungalow,
    AppImages.villa,
    AppImages.house,
    AppImages.apartMent,
  ];

  void checkSavedToken() async {
    String? savedToken = await SharePrefsHelper.getString(AppConstants.token);

    if (savedToken.isNotEmpty) {
      debugPrint("✅ Saved Token:=================== $savedToken");
    } else {
      debugPrint("❌ No Token Found!");
    }
  }

  final AddEmployeeController employeeController =
      Get.find<AddEmployeeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      employeeController.getEmployee();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkSavedToken();
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
                  AppColors.light50, // First color (with opacity)
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ///==============================Add House===================
                Row(
                  children: [
                    const CustomText(
                      text: 'Add house',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.dark400,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        )),
                    const Spacer(),

                    ///===============================Notification===============
                    IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.employeeNotificationScreen);
                        },
                        icon: const Icon(
                          Icons.notification_add,
                          color: Colors.black12,
                        )),
                  ],
                ),
                SizedBox(height: 50.h),

                ///================================Grid====================
                SizedBox(
                  height: MediaQuery.of(context).size.height /
                      3,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    // Horizontal scrolling
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Single row with multiple columns
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 14,
                      mainAxisExtent: 120, // Adjust item width if needed
                    ),
                    itemCount: categoryType.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Get.toNamed(AppRoutes
                                .houseInformationScreen); // Add your own route here
                          } else {
                            Get.toNamed(AppRoutes.roomDetailsScreen);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.employeeCardColor,
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
                                color: AppColors.dark400,
                                // Use corresponding color
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                textAlign: TextAlign.center,
                                // Centered text for better alignment
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                ///=======================See all===========
                Row(
                  children: [
                    const CustomText(
                      text: AppStrings.employees,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue900,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.allEmployeeShow);
                      },
                      child: const CustomText(
                        text: AppStrings.seeAll,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark300,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),

                ///===========================Employee Show====================
                EmployeeShow(employeeController: employeeController)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

