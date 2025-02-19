import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/home_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class RoomDetailsScreen extends StatefulWidget {
  const RoomDetailsScreen({super.key});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getSingleRoomTask(roomId: roomId);
    });
    super.initState();
  }

  final String roomId = Get.arguments[0];
  final String roomName = Get.arguments[1];

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
            children: [
              ///=============================== roomName Title ========================
              CustomMenuAppbar(
                isEdit: true,
                title: roomName,
                onBack: () {
                  Get.back();
                },
                onTap: () {
                  showEditRoomDialog(
                      context); // Call to show the Edit Room Dialog
                },
              ),

              ///=============================== Menu Items ========================
              Expanded(child: Obx(() {
                switch (homeController.rxRequestStatus.value) {
                  case Status.loading:
                    return const CustomLoader(); // Show loading indicator

                  case Status.internetError:
                    return NoInternetScreen(onTap: () {
                      homeController.getSingleRoomTask(roomId: roomId);
                    });

                  case Status.error:
                    return GeneralErrorScreen(
                      onTap: () {
                        homeController.getSingleRoomTask(roomId: roomId);
                      },
                    );

                  case Status.completed:
                    final roomList = homeController.singleRoomModels.value.result ?? [];

                    if (roomList.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                    return ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        Column(
                          children: List.generate(
                              homeController
                                      .singleRoomModels.value.result?.length ??
                                  0, (index) {
                            final data = homeController
                                .singleRoomModels.value.result?[index];
                            return CustomRoomCard(
                              taskName: data?.taskName ?? "",
                              assignedTo: 'Annette Black',
                              time: '10.00 am - 11 am',
                              onInfoPressed: () {
                                TaskInfoDialog.showTask(
                                  context: context,
                                  content:
                                      'Are you sure you want to delete this task?',
                                  onConfirm: () {
                                    // Handle confirm action (e.g., delete task)
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  onCancel: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog without any action
                                  },
                                );
                              },
                              onDeletePressed: () {
                                TaskAlertDialog.showTaskDialog(
                                  context: context,
                                  title: 'Delete Task',
                                  content:
                                      'Are you sure you want to delete this task?',
                                  onConfirm: () {
                                    // Handle confirm action (e.g., delete task)
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  onCancel: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog without any action
                                  },
                                );
                              },
                            );
                          }),
                        )
                      ],
                    );
                }
              })),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(5.0)), // Adjust the radius as needed
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.backspace_outlined),
              ),
            ],
          ),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Room:',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark300,
                    fontSize: 16,
                  ),
                  CustomText(
                    text: 'Bedroom',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark300,
                    fontSize: 16,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Task title:',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark300,
                    fontSize: 16,
                  ),
                  CustomText(
                    text: 'Clean',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark300,
                    fontSize: 16,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Time',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark300,
                    fontSize: 16,
                  ),
                  CustomText(
                    text: '05:00 pm -06:00pm',
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark300,
                    fontSize: 16,
                  ),
                ],
              ),
              CustomText(
                top: 25,
                text: 'Details',
                fontWeight: FontWeight.w400,
                color: AppColors.dark300,
                fontSize: 16,
              ),
              CustomText(
                textAlign: TextAlign.start,
                text:
                    'Diam elit, odio elit, sollicitudin, urna, goasfgg, this is good for me.',
                fontWeight: FontWeight.w400,
                color: AppColors.dark300,
                fontSize: 12,
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(5.0)), // Adjust the radius as needed
        ),
        title: const CustomText(
          text: 'Edit New Room',
          color: AppColors.dark500,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40.h,
              ),
              const CustomTextField(
                fillColor: AppColors.blue100,
                hintText: 'Room Name',
              ),
              SizedBox(height: 10.h),
              const CustomTextField(
                suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                fillColor: AppColors.blue100,
                hintText: 'Add Icon',
              ),
              SizedBox(height: 40.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: AppColors.light300,
                      child: const CustomText(
                        text: 'Cancel',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
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
