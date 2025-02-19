import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/home_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';

import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';

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

  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      employeeController.getEmployee();
      homeController.getHouseRoom(houseId: "67b572f10c446fecf1f0499a");
      homeController.myAllHouse();
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
                  height: MediaQuery.of(context).size.height / 3,
                  child: Obx(() {
                    switch (homeController.rxRequestStatus.value) {
                      case Status.loading:
                        return const CustomLoader(); // Show loading indicator

                      case Status.internetError:
                      case Status.error:
                        return GestureDetector(
                          onTap: () {
                            homeController.getHouseRoom(houseId: "67b572f10c446fecf1f0499a");
                          },
                          child: const CustomText(
                            textAlign: TextAlign.center,
                            top: 25,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            text: 'No Internet',
                            color: Colors.black,
                          ),
                        );

                      case Status.completed:
                      /// ✅ First, Get Room Data
                        final List<dynamic> rooms =
                            homeController.houseRoomData.value.rooms ?? [];

                        /// ✅ Add a Custom "Add" Button at index 0
                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 14,
                            mainAxisExtent: 120,
                          ),
                          itemCount: rooms.length + 1, // ✅ +1 to account for "Add" button
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.houseInformationScreen);
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
                                  padding:
                                  EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// ✅ Custom "Add" Icon (Always at Index 0)
                                      const CustomImage(
                                        imageSrc: AppIcons.add,
                                        imageType: ImageType.svg,
                                      ),
                                      SizedBox(height: 8.h),
                                      const CustomText(
                                        text: "Add Room",
                                        color: AppColors.dark400,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            /// ✅ Display API Data for Other Items
                            final data = rooms[index - 1];

                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.roomDetailsScreen);
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
                                padding:
                                EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: "${ApiUrl.networkUrl}${data.roomImage ?? ""}",
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(height: 8.h),
                                    CustomText(
                                      text: data.name ?? "",
                                      color: AppColors.dark400,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                    }
                  }),
                ),

                SizedBox(
                  height: 20.h,
                ),

                ///=======================See all===========
                const SeeAll(),
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

class SeeAll extends StatelessWidget {
  const SeeAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
