import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';

import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  final List<String> dayName = [
    'Completed Tasks',
    'Ongoing Tasks',
    'Pending Tasks',
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=============================== Menu Title ========================
              CustomMenuAppbar(
                title: AppStrings.allTasks,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Settings Items ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
                    ),
                    const SizedBox(height: 20),
                    selectedDayIndex != null
                        ? Column(
                          children: [
                            SizedBox(
                              height: 16.h,
                            ),
                            const Divider(color: AppColors.blue500,),
                            SizedBox(
                              height: 16.h,
                            ),
                            CustomRoomCard(
                                taskName: 'Clean Car',
                                assignedTo: 'Annette Black',
                                time: '10 Aug,2024',
                                onInfoPressed: () {},
                                onDeletePressed: () {}),
                          ],
                        )
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
