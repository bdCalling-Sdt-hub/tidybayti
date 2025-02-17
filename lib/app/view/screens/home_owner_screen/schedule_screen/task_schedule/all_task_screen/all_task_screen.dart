import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/task_controller/task_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class AllTaskScreen extends StatelessWidget {
  AllTaskScreen({super.key});

  final TaskController controller = Get.find<TaskController>();

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

              ///=============================== Task Filter ========================
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(controller.dayName.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectedDayIndex.value = index;
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
                            text: controller.dayName[index],
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
                  final tasks = controller.filteredTasks;
                  return tasks.isNotEmpty
                      ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return Column(
                        children: [
                          CustomRoomCard(
                            taskName: task["taskName"]!,
                            assignedTo: task["assignedTo"]!,
                            time: task["time"]!,
                            onInfoPressed: () {},
                            onDeletePressed: () {},
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  )
                      : const Center(
                    child: CustomText(
                      text: "No tasks available",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue900,
                    ),
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
