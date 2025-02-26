import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/work_schedule_controller/work_schedule_controller.dart';
import 'package:tidybayte/app/global/helper/time_converter/time_converter.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

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
    controller.getUserTask(dayName: 'Tuesday');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///<<<<========================= Day Name ================================>>>>
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() => Row(
                  children: List.generate(controller.dayName.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedDayIndex.value =
                            index; // ✅ Update selected index using `.value`
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
          controller.selectedDayIndex != null
              ? Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///<<<<========================= Selected Day ================================>>>>
                      CustomText(
                        textAlign: TextAlign.start,
                        text:
                            'Selected Day: ${controller.dayName[controller.selectedDayIndex.value]}',
                        color: AppColors.dark300,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 10),

                      ///<<<<========================= Task Card ================================>>>>
                      Column(
                        children: List.generate(
                            controller.userTaskData.value.result?.length ?? 0,
                            (index) {
                          final data =
                              controller.userTaskData.value.result?[index];
                          return UserTaskCard(
                            name:
                                "${data?.assignedTo?.firstName ?? ""}${data?.assignedTo?.lastName ?? ""}",
                            role: data?.status ?? "",
                            workTitle: data?.taskName ?? "",
                            workDetails: data?.taskDetails ?? "",
                            time:
                                "${DateConverter.estimatedDate(data?.startDateTime?.toLocal() ??
                                    DateTime.now())} To ""${DateConverter.estimatedDate(
                                    DateConverter.parseTimeString(data?.endDateStr) ?? DateTime.now()
                                )}"
                            ,
                            imageUrl: AppConstants.userNtr,
                          );
                        }),
                      )
                    ],
                  );
                })
              : const SizedBox(),
          // Empty placeholder
        ],
      ),
    );
  }
}
