import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/task_controller/task_controller.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class PendingTask extends StatelessWidget {
  PendingTask({super.key});

  final TaskController taskController = Get.find<TaskController>();

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
                title: AppStrings.pendingTask.tr,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Settings Items ========================
              Expanded(child: Obx(() {
                switch (taskController.rxRequestStatus.value) {
                  case Status.loading:
                    return const CustomLoader(); // Show loading indicator

                  case Status.internetError:
                    return NoInternetScreen(onTap: () {
                      taskController.getPendingTask();
                    });

                  case Status.error:
                    return GeneralErrorScreen(
                      onTap: () {
                        taskController.getPendingTask();
                      },
                    );

                  case Status.completed:
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        Column(
                          children: List.generate(
                              taskController.taskData.value.result?.length ?? 0,
                              (index) {
                            final data =
                                taskController.taskData.value.result?[index];
                            return CustomRoomCard(
                                taskName: data?.taskName ?? "",
                                assignedTo:
                                    "${data?.assignedTo?.firstName ?? ""} ${data?.assignedTo?.lastName ?? ""}",
                                time:
                                    '${data?.startDateStr ?? ""} To ${data?.endDateStr ?? ""}',
                                onInfoPressed: () {},
                                onDeletePressed: () {});
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
    );
  }
}
