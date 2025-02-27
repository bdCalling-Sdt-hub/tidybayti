import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tidybayte/app/controller/owner_controller/grocery_controller/grocery_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
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
    _fetchGroceryData();
  }

  Future<void> _fetchGroceryData() async {
    await controller.getMyGrocery(apiUrl: ApiUrl.getMyGrocery);
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
              /// Grocery Title
              CustomMenuAppbar(
                title: AppStrings.grocery.tr,
                onBack: () => Get.back(),
              ),

              /// Settings Items
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(), // ✅ Loader
                        )
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          children: [
                            /// AddGroceryButton
                            const AddGroceryButton(),

                            /// Show loader under AddGroceryButton when loading
                            if (controller.isLoading.value)
                              const Center(
                                child:
                                    CircularProgressIndicator(), // ✅ Loader under button
                              ),

                            /// Pending & Completed Tabs
                            Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTabButton(
                                      "Pending", 0, ApiUrl.getMyGrocery),
                                  _buildTabButton(
                                      "Completed", 1, ApiUrl.groceryComplete),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            /// Grocery List
                            controller.selectedTabIndex.value == 0
                                ? _buildGroceryList(ApiUrl.getMyGrocery)
                                : _buildGroceryList(ApiUrl.groceryComplete),
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

  /// **Tab Button Builder**
  Widget _buildTabButton(String title, int index, String apiUrl) {
    return GestureDetector(
      onTap: () async {
        controller.selectedTabIndex.value = index;
        controller.isLoading.value = true; // Show loader on tap
        await controller.getMyGrocery(apiUrl: apiUrl);
        controller.isLoading.value = false; // Hide loader after data load
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

  /// **Grocery List Builder**
  Widget _buildGroceryList(String apiUrl) {
    return Obx(
      () {
        final groceryData = controller.groceryData.value.result;

        if (groceryData == null || groceryData.isEmpty) {
          return const Center(
            child: CustomText(
              text: "No Data Found", // Message when no data is available
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
                time: "${DateConverter.estimatedDate(
                  data.startDateStr != null
                      ? DateFormat("MM/dd/yyyy").parse(data.startDateStr!)
                      : DateTime.now(),
                )}"
                    " To ${DateConverter.estimatedDate(
                  data.endDateStr != null
                      ? DateFormat("MM/dd/yyyy").parse(data.endDateStr!)
                      : DateTime.now(),
                )}",
                onInfoPressed: () {},
                onDeletePressed: () {},
              );
            },
          ),
        );
      },
    );
  }
}
