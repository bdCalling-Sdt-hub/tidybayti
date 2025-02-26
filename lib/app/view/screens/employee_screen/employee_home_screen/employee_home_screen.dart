import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_home_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/time_converter/time_converter.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/employee_nav_bar/employee_navbar.dart';
import 'package:tidybayte/app/view/components/user_task_card/user_task_card.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_home_screen/inner_widget/employee_home_app_bar.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final EmployeeHomeController controller = Get.find<EmployeeHomeController>();

  @override
  void initState() {
    controller.getEmployeeAllTask(dayName: "All");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.addedColor,
      bottomNavigationBar: const EmployeeNavbar(currentIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EmployeeHomeAppBar(scaffoldKey: scaffoldKey),

            /// ========================= Day Name Selection ========================= ///
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() => Row(
                      children:
                          List.generate(controller.dayName.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectedDayIndex.value = index;
                            String selectedDay = controller.dayName[index];

                            // ✅ If "All" is selected, remove day filter
                            controller.getEmployeeAllTask(dayName: selectedDay);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.selectedDayIndex.value == index
                                  ? AppColors.blue900
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    controller.selectedDayIndex.value == index
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
            ),

            /// ========================= Display Selected Day ========================= ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ✅ Wrap only the `Selected Day` text in `Obx()`
                  Obx(() => CustomText(
                        textAlign: TextAlign.start,
                        text:
                            'Selected Day: ${controller.dayName[controller.selectedDayIndex.value]}',
                        color: AppColors.dark300,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 10),

                  /// ✅ Separate Obx() for Loader and Task List
                  Obx(() {
                    if (controller.isLoading.value) {
                      // ✅ Show loader when data is loading
                      return const Center(child: CustomLoader());
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

                    /// ✅ Display Task List
                    return Column(
                      children: List.generate(taskList.length, (index) {
                        final data = taskList[index];

                        return UserTaskCard(
                          name:
                              "${data.assignedTo?.firstName ?? ""} ${data.assignedTo?.lastName ?? ""}",
                          role: data.status ?? "Pending",
                          workTitle: data.taskName ?? "Unknown Task",
                          workDetails:
                              data.taskDetails ?? "No details provided",
                          time:
                              "${DateConverter.estimatedDate(data.startDateTime?.toLocal() ?? DateTime.now())} To ${DateConverter.estimatedDate(DateConverter.parseTimeString(data.endDateStr) ?? DateTime.now())}",
                          imageUrl:
                              "${ApiUrl.networkUrl}${data.assignedTo?.profileImage ?? ""}",
                        );
                      }),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
