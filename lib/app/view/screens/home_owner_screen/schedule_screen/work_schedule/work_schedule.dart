import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/work_schedule_controller/work_schedule_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/time_converter/time_converter.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';

import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/user_task_card/user_task_card.dart';

class WorkSchedule extends StatefulWidget {
  const WorkSchedule({super.key});

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
  final WorkScheduleController controller = Get.find<WorkScheduleController>();

  @override
  void initState() {
    super.initState();
    controller.getUserTask(dayName: "All");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ========================= Day Name Selection ========================= ///
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() => Row(
                  children: List.generate(controller.dayName.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedDayIndex.value = index;
                        String selectedDay = controller.dayName[index];

                        // ✅ If "All" is selected, remove day filter
                        controller.getUserTask(dayName: selectedDay);

                        print("Selected Day: $selectedDay");
                      },
                      child: Container(
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
                          text: controller.dayName[index],
                          color: controller.selectedDayIndex.value == index
                              ? Colors.white
                              : AppColors.blue900,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }),
                )),
          ),

          const SizedBox(height: 20),

          /// ========================= Display Selected Day ========================= ///
          Obx(() {
            if (controller.selectedDayIndex.value < 0 ||
                controller.selectedDayIndex.value >=
                    controller.dayName.length) {
              return const SizedBox(); // Avoid index out of range errors
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  text:
                      'Selected Day: ${controller.dayName[controller.selectedDayIndex.value]}',
                  color: AppColors.dark300,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                const SizedBox(height: 10),

                /// ========================= Task List & Loader ========================= ///
                Obx(() {
                  if (controller.isLoading.value) {
                    // ✅ Show loader when data is loading
                    return const Center(
                      child: CustomLoader(
                      ),
                    );
                  }

                  final taskList = controller.userTaskData.value.result ?? [];
                  if (taskList.isEmpty) {
                    // ✅ Show message when no tasks are found
                    return const Center(
                      child: CustomText(
                        text: "No tasks available for this day.",
                        color: AppColors.dark200,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    );
                  }

                  return Column(
                    children: List.generate(taskList.length, (index) {
                      final data = taskList[index];

                      return UserTaskCard(
                        name:
                            "${data.assignedTo?.firstName ?? ""} ${data.assignedTo?.lastName ?? ""}",
                        role: data.status ?? "Pending",
                        workTitle: data.taskName ?? "Unknown Task",
                        workDetails: data.taskDetails ?? "No details provided",
                        time:
                            "${DateConverter.estimatedDate(data.startDateTime?.toLocal() ?? DateTime.now())} To ${DateConverter.estimatedDate(DateConverter.parseTimeString(data.endDateStr) ?? DateTime.now())}",
                        imageUrl: "${ApiUrl.networkUrl}"
                            "${data.assignedTo?.profileImage ?? ""}",
                      );
                    }),
                  );
                })
              ],
            );
          }),
        ],
      ),
    );
  }
}
