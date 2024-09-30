import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key});

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
              CustomMenuAppbar(
                isEdit: true,
                title: 'Bedroom',
                onBack: () {
                  Get.back();
                },
                onTap: () {
                  showEditRoomDialog(context); // Call to show the Edit Room Dialog
                },
              ),

              ///=============================== Menu Items ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Column(
                      children: List.generate(3, (index) {
                        return CustomRoomCard(
                          taskName: 'Clean',
                          assignedTo: 'Annette Black',
                          time: '10.00 am - 11 am',
                          onInfoPressed: () {
                            TaskInfoDialog.showTask(
                              context: context,
                              content: 'Are you sure you want to delete this task?',
                              onConfirm: () {
                                // Handle confirm action (e.g., delete task)
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              onCancel: () {
                                Navigator.of(context).pop(); // Close the dialog without any action
                              },
                            );
                          },
                          onDeletePressed: () {
                            TaskAlertDialog.showTaskDialog(
                              context: context,
                              title: 'Delete Task',
                              content: 'Are you sure you want to delete this task?',
                              onConfirm: () {
                                // Handle confirm action (e.g., delete task)
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              onCancel: () {
                                Navigator.of(context).pop(); // Close the dialog without any action
                              },
                            );
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomButton(
        width: MediaQuery.of(context).size.width / 1.1,
        onTap: () {
          Get.toNamed(AppRoutes.assignWorkScheduleScreen);
        },
        fillColor: AppColors.blue100,
        title: AppStrings.assignWork,
      ),
    );
  }
}

class TaskAlertDialog {
  static Future<void> showTaskDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: onCancel,
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: onConfirm,
            ),
          ],
        );
      },
    );
  }
}

class TaskInfoDialog {
  static Future<void> showTask({
    required BuildContext context,
    required String content,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Text('Task'),
              Spacer(),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.backspace_outlined),
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Room:',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark400,
                    fontSize: 20,
                  ),
                  CustomText(
                    text: 'Bedroom',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark400,
                    fontSize: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Task title:',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark400,
                    fontSize: 20,
                  ),
                  CustomText(
                    text: 'Clean',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark400,
                    fontSize: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Time',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark400,
                    fontSize: 20,
                  ),
                  CustomText(
                    text: '05:00 pm -06:00pm',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark400,
                    fontSize: 20,
                  ),
                ],
              ),
              CustomText(
                top: 25,
                text: 'Details',
                fontWeight: FontWeight.w400,
                color: AppColors.dark400,
                fontSize: 20,
              ),
              CustomText(
                textAlign: TextAlign.start,
                text: 'Diam elit, odio elit, sollicitudin, urna, goasfgg, this is good for me.',
                fontWeight: FontWeight.w400,
                color: AppColors.dark400,
                fontSize: 14,
                maxLines: 5,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Function to display the Edit Room dialog
void showEditRoomDialog(BuildContext context) {
  showDialog(
    context: context, // Required to pass the context
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit New Room'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                fillColor: AppColors.blue50,
                hintText: 'Room Name',
              ),
              SizedBox(height: 10.h),
              const CustomTextField(
                suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                fillColor: AppColors.blue50,
                hintText: 'Add Icon',
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.light200,
                      child: const CustomText(
                        text: 'Cancel',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: () {

                        Get.back();
                      },

                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.blue300,
                      child: const CustomText(
                        text: 'Change',
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
        ),
      );
    },
  );
}
