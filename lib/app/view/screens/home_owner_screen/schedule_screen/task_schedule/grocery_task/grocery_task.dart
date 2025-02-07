import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
class GroceryTask extends StatefulWidget {
  const GroceryTask({super.key});

  @override
  State<GroceryTask> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<GroceryTask> {
  final List<String> dayName = [
    'Pending Tasks',
    'Completed Tasks',
  ];

  // To track selected day index
  int? selectedDayIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Column(
            children: [


              ///=============================== Menu Title ========================
              CustomMenuAppbar(
                title: AppStrings.grocery,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Settings Items ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.addGroceryTask);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(20),
                        color: AppColors.blue50,
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImage(imageSrc: AppIcons.add),
                            CustomText(
                              left: 10,
                              text: AppStrings.addGrocery,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: AppColors.dark400,
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(dayName.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDayIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedDayIndex == index
                                  ? AppColors.blue900
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedDayIndex == index
                                    ? AppColors.blue900
                                    : AppColors.blue50,
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 10),
                            child: CustomText(
                              text: dayName[index],
                              color: selectedDayIndex == index
                                  ? Colors.white
                                  : AppColors.blue900,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    selectedDayIndex != null
                        ? CustomRoomCard(
                        taskName: 'Clean Car',
                        assignedTo: 'Annette Black',
                        time: '10 Aug,2024',
                        onInfoPressed: () {},
                        onDeletePressed: () {})
                        : const SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
