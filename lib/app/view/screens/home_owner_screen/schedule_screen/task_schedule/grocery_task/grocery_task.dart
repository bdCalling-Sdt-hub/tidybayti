import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/grocery_controller/grocery_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class GroceryTask extends StatelessWidget {
  const GroceryTask({super.key});

  @override
  Widget build(BuildContext context) {
    final GroceryController controller = Get.find<GroceryController>();

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
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.addGroceryTask),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(20),
                        color: AppColors.blue50,
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImage(imageSrc: AppIcons.add),
                            CustomText(
                              left: 10,
                              text: AppStrings.addGrocery,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: AppColors.dark400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(controller.dayName.length, (index) {
                          return GestureDetector(
                            onTap: () => controller.selectedDayIndex.value = index,
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
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                          () => controller.selectedDayIndex.value != null
                          ? CustomRoomCard(
                        taskName: 'Clean Car',
                        assignedTo: 'Annette Black',
                        time: '10 Aug, 2024',
                        onInfoPressed: () {},
                        onDeletePressed: () {},
                      )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
