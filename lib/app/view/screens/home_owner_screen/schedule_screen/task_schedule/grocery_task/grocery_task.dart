import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tidybayte/app/controller/owner_controller/grocery_controller/grocery_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/global_alart/global_alart.dart';
import 'package:tidybayte/app/global/helper/time_converter/time_converter.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'inner_widgets/add_grocery_button.dart';

class GroceryTask extends StatefulWidget {
  const GroceryTask({super.key});

  @override
  State<GroceryTask> createState() => _GroceryTaskState();
}

class _GroceryTaskState extends State<GroceryTask> {
  final GroceryController controller = Get.find<GroceryController>();

  @override
  void initState() {
    super.initState();
    controller.fetchGroceryData();
  }

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
              CustomMenuAppbar(
                title: AppStrings.grocery.tr,
                onBack: () => Get.back(),
              ),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          children: [
                            const AddGroceryButton(),
                            Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTabButton(
                                      "Pending", 0, ApiUrl.getMyGrocery),
                                  _buildTabButton(
                                      "Ongoing", 1, ApiUrl.getGroceryOngoing),
                                  _buildTabButton(
                                      "Completed", 2, ApiUrl.groceryComplete),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Obx(
                              () => _buildGroceryList(
                                  controller.selectedTabIndex.value),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index, String apiUrl) {
    return GestureDetector(
      onTap: () async {
        controller.selectedTabIndex.value = index;
        controller.isLoading.value = true;
        await controller.getMyGrocery(apiUrl: apiUrl);
        controller.isLoading.value = false;
      },
      child: Container(
        decoration: BoxDecoration(
          color: controller.selectedTabIndex.value == index
              ? AppColors.blue900
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: controller.selectedTabIndex.value == index
                ? AppColors.blue900
                : AppColors.blue50,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: CustomText(
          text: title,
          color: controller.selectedTabIndex.value == index
              ? Colors.white
              : AppColors.blue900,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildGroceryList(int selectedIndex) {
    String apiUrl;
    switch (selectedIndex) {
      case 1:
        apiUrl = ApiUrl.getGroceryOngoing;
        break;
      case 2:
        apiUrl = ApiUrl.groceryComplete;
        break;
      default:
        apiUrl = ApiUrl.getMyGrocery;
    }

    final groceryData = controller.groceryData.value.result;
    if (groceryData == null || groceryData.isEmpty) {
      return const Center(
        child: CustomText(
          text: "No Data Found",
          color: AppColors.blue900,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Column(
      children: List.generate(
        groceryData.length,
        (index) {
          final data = groceryData[index];
          return CustomRoomCard(
            taskName: data.groceryName ?? "",
            assignedTo:
                "${data.assignedTo?.firstName ?? ""} ${data.assignedTo?.lastName ?? ""}",
            time:
                "${DateConverter.estimatedDate(DateFormat("MM/dd/yyyy").parse(data.startDateStr ?? DateTime.now().toString()))} To ${DateConverter.estimatedDate(DateFormat("MM/dd/yyyy").parse(data.endDateStr ?? DateTime.now().toString()))}",
            onInfoPressed: () {},
            onDeletePressed: () {
              GlobalAlert.showDeleteDialog(context, () {
                controller.removeGrocery(groceryId: data.id ?? "");
              }, "Are You Sure you want to remove");
            },
          );
        },
      ),
    );
  }
}
