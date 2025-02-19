import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class HouseInformationScreen extends StatelessWidget {
  const HouseInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HouseInformationBody(),
      floatingActionButton: CustomButton(
        width: MediaQuery.of(context).size.width / 1.1,
        onTap: () {
          Get.toNamed(AppRoutes.homeScreen);
        },
        fillColor: Colors.white,
        title: AppStrings.save.tr,
      ),
    );
  }
}

class HouseInformationBody extends StatefulWidget {
  const HouseInformationBody({super.key});

  @override
  _HouseInformationBodyState createState() => _HouseInformationBodyState();
}

class _HouseInformationBodyState extends State<HouseInformationBody> {
  final List<Map<String, dynamic>> _rooms = [];

  void _addRoom(String roomName, String iconName) {
    setState(() {
      _rooms.add({'name': roomName, 'icon': iconName});
    });
  }

  void _removeRoom(int index) {
    setState(() {
      _rooms.removeAt(index); // Remove the room at the specified index
    });
  }

  void _editRoom(int index, String newRoomName, String iconName) {
    setState(() {
      _rooms[index] = {
        'name': newRoomName,
        'icon': iconName
      };
    });
  }

  void showDialoge(BuildContext context,
      {Map<String, dynamic>? currentRoom, int? index}) {
    TextEditingController roomController =
        TextEditingController(text: currentRoom?['name']);
    String selectedIcon =
        currentRoom?['icon'] ?? AppIcons.villa; // Default icon if editing

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///==================================✅✅Room Name✅✅=======================

              CustomTextField(
                textEditingController: roomController,
                hintText: AppStrings.roomName.tr,
                fillColor: AppColors.blue100,
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  showIconSelection(context, (icon) {
                    setState(() {
                      selectedIcon = icon; // Update selected icon
                    });
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: AppColors.blue100,
                  child: Row(
                    children: [
                      CustomImage(imageSrc: selectedIcon),
                      const SizedBox(width: 10),
                      const Text('Select Icon',
                          style: TextStyle(color: AppColors.dark500)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Row(
                children: [
                  ///==================================✅✅Cancel Button✅✅=======================

                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.light200,
                      child: CustomText(
                        text: AppStrings.cancel.tr,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  ///==================================✅✅Save Button✅✅=======================
                  GestureDetector(
                    onTap: () {
                      if (roomController.text.isNotEmpty) {
                        if (index != null) {
                          _editRoom(index, roomController.text,
                              selectedIcon); // Call to edit room
                        } else {
                          _addRoom(roomController.text,
                              selectedIcon); // Call to add room
                        }
                        Get.back();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.blue300,
                      child: CustomText(
                        text: AppStrings.save.tr,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ///==================================✅✅Select Icon Dialog✅✅=======================
  void showIconSelection(
      BuildContext context, Function(String) onIconSelected) {
    List<String> icons = [
      AppIcons.villa,
      AppIcons.appartMent,
      AppIcons.addRoom,
      AppIcons.edit
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Icon'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CustomImage(imageSrc: icons[index]),
                  title: Text('Icon ${index + 1}'),
                  onTap: () {
                    onIconSelected(icons[index]);
                    Get.back(); // Close the icon selection dialog
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
  Widget build(BuildContext context) {
    return Container(
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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///==================================✅✅House Information ✅✅=======================
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
                      ///==================================✅✅House Name✅✅=======================
                      const CustomTextField(
                        hintText: AppStrings.houseName,

                      ),
                      SizedBox(height: 42.h),
                      ///==================================✅✅addNewRoom✅✅=======================
                      GestureDetector(
                        onTap: () {
                          showDialoge(context);
                        },
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomImage(imageSrc: AppIcons.addRoom),
                            CustomText(
                              left: 10,
                              text: AppStrings.addNewRoom.tr,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: AppColors.dark500,
                            ),
                          ],
                        ),
                      ),
                      // Display the list of rooms
                      ..._rooms.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> room = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: Row(
                              children: [
                                ///==================================✅✅Room Icon SHow✅✅=======================
                                CustomImage(imageSrc: room['icon']),
                                ///==================================✅✅Room Name SHow✅✅=======================
                                CustomText(
                                  left: 10,
                                  text: room['name'],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.dark500,
                                ),
                                const Spacer(),
                                ///==================================✅✅Edit✅✅=======================
                                GestureDetector(
                                  onTap: () {
                                    showDialoge(context,
                                        currentRoom: room,
                                        index:
                                            index); // Pass room and index to edit
                                  },
                                  child: const CustomImage(
                                      imageSrc: AppIcons.edit),
                                ),
                                const SizedBox(width: 10),
                                ///==================================✅✅Close✅✅=======================
                                GestureDetector(
                                  onTap: () {
                                    _removeRoom(
                                        index); // Remove room when tapped
                                  },
                                  child:
                                      const CustomImage(imageSrc: AppIcons.x),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
