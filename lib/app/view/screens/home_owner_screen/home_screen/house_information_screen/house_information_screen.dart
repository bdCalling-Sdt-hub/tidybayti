import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/house_add.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/home_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class HouseInformationScreen extends StatelessWidget {
  HouseInformationScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
 final String houseType = Get.arguments ?? "Unknown";
  @override
  Widget build(BuildContext context) {
    print(houseType);
    return Scaffold(
      body: const HouseInformationBody(),
      floatingActionButton: Obx(() {
        /// ✅ Fix: Wrap `isLoading` check inside `Obx`
        if (homeController.isLoading.value) {
          return const CustomLoader(); // Show loader when loading
        }

        return CustomButton(
          width: MediaQuery.of(context).size.width / 1.1,
          onTap: () async {
            /// ✅ Ensure a room is added before saving
            if (homeController.rooms.isEmpty) {
              toastMessage(message: "❌ Please add a room before saving.");
              return;
            }

            /// ✅ Get the first room
            var room = homeController.rooms[0];

            File roomImageFile = await HouseAdd.getFileFromAsset(
                homeController.selectedIconPath);

            /// ✅ Send data to API
            homeController.setLoading(true); // Start loading
            await HouseAdd.houseRoomAdd(
              context: context,
              houseName: homeController.houseNameController.text,
              roomName: room['name'],
              roomImage: roomImageFile, // ✅ Send File
            );
            homeController.setLoading(false); // Stop loading
          },
          fillColor: Colors.white,
          title: AppStrings.save.tr,
        );
      }),
    );
  }
}

class HouseInformationBody extends StatefulWidget {
  const HouseInformationBody({super.key});

  @override
  _HouseInformationBodyState createState() => _HouseInformationBodyState();
}

class _HouseInformationBodyState extends State<HouseInformationBody> {
  final HomeController homeController = Get.find<HomeController>();

  /// ✅ Show Dialog to Add Room
  void showDialoge(BuildContext context) {
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
                      showIconSelection(context, (icon) {
                        setStateDialog(() {
                          homeController.selectedIconPath = icon;
                        });
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.blue100,
                      child: Row(
                        children: [
                          CustomImage(
                            imageSrc: homeController.selectedIconPath,
                            imageType: ImageType.png,
                          ),
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
                    onTap: () {
                      if (homeController.roomNameController.text.isNotEmpty) {
                        if (homeController.rooms.isEmpty) {
                          homeController.addRoom(
                              homeController.roomNameController.text,
                              homeController.selectedIconPath);
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

  @override
  void initState() {
    super.initState();

    String houseType = Get.arguments ?? "";
    homeController.houseNameController.text = houseType;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xCCF5F5F5),
            Color(0xFFB5D8EE),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CustomMenuAppbar(
              title: AppStrings.houseInformation.tr,
              onBack: () {
                Get.back();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ✅ House Name Input
                  CustomTextField(
                    hintText: AppStrings.houseName,
                    textEditingController: homeController.houseNameController,
                  ),
                  SizedBox(height: 30.h),

                  /// ✅ Add Room Button (Disappears after adding a room)
                  Obx(() {
                    return homeController.rooms.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              showDialoge(context);
                            },
                            child: Row(
                              children: [
                                const CustomImage(imageSrc: AppIcons.addRoom),
                                CustomText(
                                  left: 10,
                                  text: "Add Room".tr,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: AppColors.dark500,
                                ),
                              ],
                            ),
                          )
                        : Container(); // Hide button after adding a room
                  }),
                  SizedBox(height: 10.h),

                  /// ✅ Display Room (Only One Room Allowed)
                  Obx(() => homeController.rooms.isEmpty
                      ? const Center(
                          child: Text("No room added",
                              style: TextStyle(color: Colors.grey)))
                      : Column(
                          children: [
                            Row(
                              children: [
                                // CustomImage(
                                //     imageSrc: homeController.rooms[0]['icon'],
                                //   imageType: ImageType.png,),


                                CustomText(
                                  left: 10,
                                  text:"Room Name: ${homeController.rooms[0]['name']}",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.dark500,
                                ),
                              ],
                            ),
                          ],
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
