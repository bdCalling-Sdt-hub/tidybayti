import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/home_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/house_add.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
import 'home_screen_inner_widgets/employee_show.dart';
import 'home_screen_inner_widgets/seel_all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HouseTypeScreenState();
}

class _HouseTypeScreenState extends State<HomeScreen> {
  final AddEmployeeController employeeController =
      Get.find<AddEmployeeController>();

  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      employeeController.getEmployee();
      homeController.myAllHouse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                ///==================================✅✅House Add✅✅=======================
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            homeController.isExpanded.value =
                                !homeController.isExpanded.value;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// ✅ Display Selected House Name
                              CustomText(
                                text: homeController.selectedHouseName.value,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: AppColors.dark400,
                              ),
                              Icon(
                                homeController.isExpanded.value
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                      AppRoutes.employeeNotificationScreen);
                                },
                                child: const Icon(
                                  Icons.notification_add,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (homeController.isExpanded.value) ...[
                          homeController.myHouseData.value.houses != null &&
                                  homeController
                                      .myHouseData.value.houses!.isNotEmpty
                              ? SizedBox(
                                  height: 100,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: homeController
                                          .myHouseData.value.houses!
                                          .map((house) {
                                        return ListTile(
                                          title: GestureDetector(
                                            onTap: () {
                                              /// ✅ Set Selected House ID & Name
                                              homeController.selectedHouseId
                                                  .value = house.id ?? '';
                                              homeController
                                                      .selectedHouseName.value =
                                                  house.name ?? 'No Name';

                                              /// ✅ Fetch Rooms for Selected House
                                              homeController.getHouseRoom(
                                                  houseId: homeController
                                                      .selectedHouseId.value);

                                              homeController.isExpanded.value =
                                                  false; // ✅ Close Dropdown
                                            },
                                            child: CustomText(
                                              decoration:
                                                  TextDecoration.underline,
                                              textAlign: TextAlign.start,
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              text: house.name ?? "No Name",
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: CustomText(
                                      text: "No Houses Found",
                                      color: Colors.red),
                                ),
                        ],
                      ],
                    )),

                SizedBox(height: 50.h),

                ///==================================✅✅All Room✅✅=======================
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
                            homeController.getHouseRoom(
                                houseId: homeController.selectedHouseId.value);
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

                        /// ✅ Get Room Data
                        final List<dynamic> rooms =
                            homeController.houseRoomData.value.rooms ?? [];

                        /// ✅ Add a Custom "Add" Button at index 0
                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 14,
                            mainAxisExtent: 120,
                          ),
                          itemCount: rooms.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: () {
                                  showDialoge(context);
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.h, horizontal: 12.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl:
                                          "${ApiUrl.networkUrl}${data.roomImage ?? ""}",
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

                ///==================================✅✅See All✅✅=======================
                const SeeAll(),
                SizedBox(
                  height: 30.h,
                ),

                ///==================================✅✅Employee Show✅✅=======================
                EmployeeShow(employeeController: employeeController)
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Show Dialog to Add Room
  void showDialoge(BuildContext context) {
    String selectedIconPath =
        AppImages.apartMent; // ✅ Default static image path

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Room'),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ✅ Room Name Input
                  CustomTextField(
                    textEditingController: homeController.roomNameController,
                    hintText: AppStrings.roomName.tr,
                    fillColor: AppColors.blue100,
                  ),
                  SizedBox(height: 10.h),

                  /// ✅ Select Icon
                  GestureDetector(
                    onTap: () {
                      showIconSelection(context, (iconPath) {
                        setStateDialog(() {
                          selectedIconPath = iconPath;
                        });
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.blue100,
                      child: Row(
                        children: [
                          Image.asset(selectedIconPath, width: 40, height: 40),
                          const SizedBox(width: 10),
                          const Text('Select Icon',
                              style: TextStyle(color: AppColors.dark500)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),

                  /// ✅ Save Button (Only One Room Allowed)
                  GestureDetector(
                    onTap: () async {
                      if (homeController.roomNameController.text.isNotEmpty) {
                        if (homeController.rooms.isEmpty) {
                          File roomImageFile = await HouseAdd.getFileFromAsset(
                              selectedIconPath); // ✅ Convert asset to file
                          HouseAdd.roomAdd(
                            context: context,
                            houseId: homeController.selectedHouseId.toString(),
                            roomName: homeController.roomNameController.text,
                            roomImage: roomImageFile, // ✅ Sending as File
                          );
                          Get.back();
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.blue300,
                      child: CustomText(
                        text: AppStrings.save.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark500,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  /// ✅ Select Icon Dialog
  void showIconSelection(
      BuildContext context, Function(String) onIconSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Icon'),
          content: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: homeController.images.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(homeController.images[index],
                      width: 40, height: 40),
                  // ✅ Show asset image
                  title: Text('Icon ${index + 1}'),
                  onTap: () {
                    onIconSelected(homeController
                        .images[index]); // ✅ Return selected asset path
                    Get.back();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
