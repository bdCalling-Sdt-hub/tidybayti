import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/task_controller/task_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/global/helper/global_alart/global_alart.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class OngoingTask extends StatefulWidget {
  const OngoingTask({super.key});

  @override
  State<OngoingTask> createState() => _OngoingTaskState();
}

class _OngoingTaskState extends State<OngoingTask> {
  final TaskController taskController = Get.find<TaskController>();

  @override
  void initState() {
    taskController.getTaskData(apiUrl: ApiUrl.getOngoing);

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
                title: AppStrings.ongoingTask.tr,
                onBack: () {
                  Get.back();
                },
              ),

              ///===============================  ========================
              Expanded(child: Obx(() {
                switch (taskController.rxRequestStatus.value) {
                  case Status.loading:
                    return const CustomLoader(); // Show loading indicator

                  case Status.internetError:
                    return NoInternetScreen(onTap: () {
                      taskController.getTaskData(apiUrl: ApiUrl.getOngoing);
                    });

                  case Status.error:
                    return GeneralErrorScreen(
                      onTap: () {
                        taskController.getTaskData(apiUrl: ApiUrl.getOngoing);
                      },
                    );

                  case Status.completed:
                    if (taskController.taskData.value.result == null ||
                        taskController.taskData.value.result!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
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
                              onInfoPressed: () {
                                GlobalAlert.singleTaskDialog(
                                  context,
                                  data?.taskName ?? "",
                                  "${data?.assignedTo?.firstName ?? ""}${data?.assignedTo?.lastName ?? ""}",
                                  data?.recurrence ?? "",
                                  data!.startDateStr.toString(),
                                  data.startTimeStr??"",
                                  data.endDateStr.toString(),
                                  data.endTimeStr??"",
                                );
                              },
                              onDeletePressed: () async {
                                bool? isConfirmed =
                                    await GlobalAlert.showDeleteDialog(context,
                                        () async {
                                  await taskController.removeTask(
                                      taskId: data?.id ?? "");

                                  await taskController.getTaskData(
                                      apiUrl: ApiUrl.getPendingTask);
                                }, "Remove Your Ongoing Task");

                                if (isConfirmed ?? false) {
                                  print("Task Deleted & Refreshed!");
                                }
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
    );
  }
}
