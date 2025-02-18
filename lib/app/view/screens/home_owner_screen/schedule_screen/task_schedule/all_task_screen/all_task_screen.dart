import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/task_controller/task_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/global_alart/global_alart.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class AllTaskScreen extends StatelessWidget {
  AllTaskScreen({super.key});

  final TaskController controller = Get.find<TaskController>();

  // Task Status Tabs
  final List<String> taskStatuses = ["Pending", "Ongoing", "Completed"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xCCE8F3FA),
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
                title: AppStrings.allTasks.tr,
                onBack: () => Get.back(),
              ),

              ///=============================== Task Status Tabs ========================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(taskStatuses.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          // ✅ Call API based on selected status
                          controller.selectedDayIndex.value = index;
                          if (index == 0) {
                            controller.getTaskData(apiUrl: ApiUrl.getPendingTask);
                          } else if (index == 1) {
                            controller.getTaskData(apiUrl: ApiUrl.getOngoing);
                          } else if (index == 2) {
                            controller.getTaskData(apiUrl: ApiUrl.getCompleteTask);
                          }
                        },
                        child: Obx(() => Container(
                          decoration: BoxDecoration(
                            color: controller.selectedDayIndex.value == index
                                ? AppColors.blue900
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: controller.selectedDayIndex.value == index
                                  ? AppColors.blue900
                                  : AppColors.blue50,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 10),
                          child: CustomText(
                            text: taskStatuses[index],
                            color: controller.selectedDayIndex.value == index
                                ? Colors.white
                                : AppColors.blue900,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        )),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),

              ///=============================== Task List ========================
              Expanded(
                child: Obx(() {
                  if (controller.rxRequestStatus.value == Status.loading) {
                    return const CustomLoader(); // ✅ Show Loader
                  }
                  if (controller.rxRequestStatus.value == Status.internetError) {
                    return const Center(child: CustomText(text: "No Internet Connection", fontSize: 16));
                  }
                  if (controller.rxRequestStatus.value == Status.error) {
                    return const Center(child: CustomText(text: "Something went wrong", fontSize: 16));
                  }
                  if (controller.taskData.value.result == null ||
                      controller.taskData.value.result!.isEmpty) {
                    return const Center(
                      child: CustomText(
                        text: "No Tasks Found",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.taskData.value.result?.length ?? 0,
                    itemBuilder: (context, index) {
                      final task = controller.taskData.value.result![index];
                      return Column(
                        children: [
                          CustomRoomCard(
                            taskName: task.taskName ?? "",
                            assignedTo:
                            "${task.assignedTo?.firstName ?? ""} ${task.assignedTo?.lastName ?? ""}",
                            time: "${task.startDateStr ?? ""} To ${task.endDateStr ?? ""}",
                            onInfoPressed: () {},
                            onDeletePressed: () async {
                              bool? isConfirmed = await GlobalAlert.showDeleteDialog(
                                  context,
                                      () async {
                                    // ✅ Step 1: Delete the task
                                    await controller.removeTask(taskId: task.id ?? "");

                                    // ✅ Step 2: Call the correct API based on the selected tab
                                    if (controller.selectedDayIndex.value == 0) {
                                      // If "Pending" is selected
                                      await controller.getTaskData(apiUrl: ApiUrl.getPendingTask);
                                    } else if (controller.selectedDayIndex.value == 1) {
                                      // If "Ongoing" is selected
                                      await controller.getTaskData(apiUrl: ApiUrl.getOngoing);
                                    } else if (controller.selectedDayIndex.value == 2) {
                                      // If "Completed" is selected
                                      await controller.getTaskData(apiUrl: ApiUrl.getCompleteTask);
                                    }
                                  },
                                  "Are you sure you want to delete this task?"
                              );

                              if (isConfirmed ?? false) {
                                print("✅ Task Deleted & Correct API Called!");
                              }
                            },


                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
