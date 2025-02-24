import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';

import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';


class AssignWorkScreen extends StatefulWidget {
  const AssignWorkScreen({super.key});

  @override
  State<AssignWorkScreen> createState() => _AssignWorkScheduleScreenState();
}

class _AssignWorkScheduleScreenState extends State<AssignWorkScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=============================== Menu Title ========================
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomMenuAppbar(
                    title: AppStrings.assignWork,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ],
              ),

              ///=============================== Menu Items ========================
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: CustomButton(
                            onTap: () {
                              usePresets(context);
                            },
                            fillColor: Colors.white,
                            title: AppStrings.addNewTask,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomButton(
                            onTap: () {
                              showBreakTime(context);
                            },
                            fillColor: Colors.white,
                            title: AppStrings.addBreakTime,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: List.generate(4, (index) {
                        return CustomRoomCard(
                          taskName: 'Clean',
                          assignedTo: 'Annette Black',
                          time: '10.00 am - 11 am',
                          onInfoPressed: () {

                          },
                          onDeletePressed: () {

                          },
                        );
                      }),
                    )
                  ],
                ),
              ),

              CustomButton(
                width: MediaQuery.of(context).size.width / 1.1,
                onTap: () {
                  Get.toNamed(AppRoutes.assignTaskSuccessfullyScreen);
                },
                fillColor: Colors.white,
                title: AppStrings.finish,
              ),
              SizedBox(
                height: 40.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}


void showBreakTime(BuildContext context) {
  showDialog(
    context: context, // Required to pass the context
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(child: Text('Add break Time')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 10.h),

              Row(children: [
              const Expanded(
                flex: 5,
                child: CustomTextField(
                  readOnly: true,
                  fillColor: AppColors.blue100,
                  hintText: 'Start Time',
                  suffixIcon: Icon(Icons.watch_later_outlined),
                ),
              ),
              SizedBox(width: 10.h),
              const Expanded(
                flex: 5,
                child: CustomTextField(
                  readOnly: true,
                  suffixIcon: Icon(Icons.watch_later_outlined),
                  fillColor: AppColors.blue100,
                  hintText: 'End Time',
                ),
              ),
            ],),
              SizedBox(height: 25.h),
              CustomButton(onTap: (){
                Get.back();
              },

              fillColor: AppColors.blue300,
                title: AppStrings.addBreak,
              )

            ],
          ),
        ),
      );
    },
  );
}

void usePresets(BuildContext context) {
  showDialog(
    context: context, // Required to pass the context
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(child: Text('Add New Work')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(
                readOnly: true,
                fillColor: AppColors.blue100,
                hintText: 'Select room',
                suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
              ),

              SizedBox(height: 15.h),

              CustomTextField(
                readOnly: true,
                fillColor: AppColors.blue100,
                hintText: 'Use Presets',
                suffixIcon: Icon(Icons.card_giftcard),
              ),
              SizedBox(height: 15.h),

              Row(children: [
              const Expanded(
                flex: 5,
                child: CustomTextField(
                  readOnly: true,
                  fillColor: AppColors.blue100,
                  hintText: 'Start Time',
                  suffixIcon: Icon(Icons.watch_later_outlined),
                ),
              ),
              SizedBox(width: 10.h),
              const Expanded(
                flex: 5,
                child: CustomTextField(
                  readOnly: true,
                  suffixIcon: Icon(Icons.watch_later_outlined),
                  fillColor: AppColors.blue100,
                  hintText: 'End Time',
                ),
              ),
            ],),
              SizedBox(height: 15.h),

              const CustomTextField(
                readOnly: true,
                fillColor: AppColors.blue100,
                hintText: 'Details',
                maxLines: 5,
              ),
              SizedBox(height: 25.h),
              CustomButton(onTap: (){
                Get.back();
              },

              fillColor: AppColors.blue300,
                title: AppStrings.addTask,
              )

            ],
          ),
        ),
      );
    },
  );
}