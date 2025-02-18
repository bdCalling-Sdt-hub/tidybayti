import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/task_controller/task_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class PendingTask extends StatefulWidget {
  const PendingTask({super.key});

  @override
  State<PendingTask> createState() => _PendingTaskState();
}

class _PendingTaskState extends State<PendingTask> {
  final TaskController taskController = Get.find<TaskController>();


  @override
  void initState() {
    taskController.getTaskData(apiUrl: ApiUrl.getPendingTask);

    super.initState();
  }
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
              ///===============================  Title ========================
              CustomMenuAppbar(
                title: AppStrings.pendingTask.tr,
                onBack: () {
                  Get.back();
                },
              ),

              ///===============================  Items ========================
              Expanded(child: Obx(() {
                switch (taskController.rxRequestStatus.value) {
                  case Status.loading:
                    return const CustomLoader(); // Show loading indicator

                  case Status.internetError:
                    return NoInternetScreen(onTap: () {
                      taskController.getTaskData(apiUrl: ApiUrl.getPendingTask);
                    });

                  case Status.error:
                    return GeneralErrorScreen(
                      onTap: () {
                        taskController.getTaskData(apiUrl: ApiUrl.getPendingTask);
                      },
                    );

                  case Status.completed:
                    if (taskController.taskData.value.result == null ||
                        taskController.taskData.value.result!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                        ),
                      );
                    }
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
