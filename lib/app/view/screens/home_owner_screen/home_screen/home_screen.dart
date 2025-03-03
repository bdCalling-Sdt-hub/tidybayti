import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/home_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/house_add.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
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
                  AppColors.light50,
                  Color(0xFFB5D8EE),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            children: [
              /// ✅ Fixed House Selection Section
              Obx(
                () => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.normal.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 60.h, horizontal: 20.w),
                  child: Column(
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
                        SizedBox(
                          height: 150,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.houseTypeScreen);
                                      // Get.toNamed(
                                      //     AppRoutes.houseInformationScreen);
                                    },
                                    child:  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.add, color: Colors.blue),
                                        const SizedBox(width: 8),
                                        CustomText(
                                          textAlign: TextAlign.start,
                                          text: AppStrings.addHouse.tr,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                /// ✅ Show House List (if available)
                                if (homeController.myHouseData.value.houses !=
                                        null &&
                                    homeController.myHouseData.value.houses!
                                        .isNotEmpty) ...[
                                  ...homeController.myHouseData.value.houses!
                                      .map((house) {
                                    return ListTile(
                                      title: GestureDetector(
                                        onTap: () {
                                          /// ✅ Set Selected House ID & Name
                                          homeController.selectedHouseId.value =
                                              house.id ?? '';
                                          homeController.selectedHouseName
                                              .value = house.name ?? 'No Name';

                                          /// ✅ Fetch Rooms for Selected House
                                          homeController.getHouseRoom(
                                            houseId: homeController
                                                .selectedHouseId.value,
                                          );

                                          homeController.isExpanded.value =
                                              false;
                                        },
                                        child: CustomText(
                                          decoration: TextDecoration.underline,
                                          textAlign: TextAlign.start,
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          text: house.name ?? "No Name",
                                        ),
                                      ),
                                    );
                                  }),
                                ] else
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        var data = homeController
                                            .myHouseData.value.houses?[1];
                                        print(data?.name);
                                      },
                                      child: const CustomText(
                                        text: "No Houses Found",
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              /// ✅ Scrollable Section (Everything Below Fixed Part)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await employeeController.getEmployee();
                    await homeController.myAllHouse();

                    if (homeController.selectedHouseId.value.isNotEmpty) {
                      await homeController.getHouseRoom(
                        houseId: homeController.selectedHouseId.value,
                      );
                    }
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 50.h),

                        /// ✅ All Room Section
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Obx(() {
                            switch (homeController.rxRequestStatus.value) {
                              case Status.loading:
                                return const CustomLoader();
                              case Status.internetError:
                              case Status.error:
                                return GestureDetector(
                                  onTap: () {
                                    homeController.getHouseRoom(
                                      houseId:
                                          homeController.selectedHouseId.value,
                                    );
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
                                final List<dynamic> rooms =
                                    homeController.houseRoomData.value.rooms ??
                                        [];
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == 0) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (homeController
                                              .selectedHouseId.value.isEmpty) {
                                            Get.snackbar(
                                              "No House Selected",
                                              "Please select a house before adding a room.",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                            return;
                                          }
                                          showDialoge(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.employeeCardColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const CustomImage(
                                                imageSrc: AppIcons.add,
                                                imageType: ImageType.svg,
                                              ),
                                              SizedBox(height: 8.h),
                                               CustomText(
                                                text: AppStrings.addRoom.tr,
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
                                    final data = rooms[index - 1];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.roomDetailsScreen,
                                            arguments: [
                                              data.id ?? "",
                                              data.name ?? ""
                                            ]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                            child: Text(data.name ?? "")),
                                      ),
                                    );
                                  },
                                );
                            }
                          }),
                        ),
                        SizedBox(height: 20.h),

                        /// ✅ See All Section
                        const SeeAll(),
                        SizedBox(height: 30.h),

                        /// ✅ Employee Section
                        EmployeeShow(employeeController: employeeController),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
          title:  Text(AppStrings.addRoom.tr),
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
                          File roomImageFile =
                              await HouseAdd.getFileFromAsset(selectedIconPath);
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
