import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/wallet_controller/wallet_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class CreateBudgetScreen extends StatelessWidget {
  CreateBudgetScreen({super.key});

  final WalletController controller = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                children: [
                  ///=============================== Budget Appbar ========================
                  CustomMenuAppbar(
                    title: AppStrings.budget.tr,
                    onBack: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ///=================== Form Section ===================
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),

                            ///===============================Select Category===============
                            Obx(() => CustomTextField(
                                  fillColor: Colors.white,
                                  textEditingController:
                                      controller.categoryNameController,
                                  hintText: AppStrings.selectCategory.tr,
                                  suffixIcon: Icon(
                                    controller.isSelected.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down_rounded,
                                    size: 28,
                                    color: AppColors.blue900,
                                  ),
                                  onTap: () {
                                    controller.isSelected.toggle();
                                  },
                                )),
                            SizedBox(height: 10.h),

                            /// Category Dropdown
                            Obx(() => controller.isSelected.value
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      controller.budgetCategoryList.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          controller.categoryNameController
                                              .text = controller
                                                  .budgetCategoryList[index]
                                                  .name ??
                                              "";

                                          controller.imageController.text =
                                              controller
                                                      .budgetCategoryList[index]
                                                      .image ??
                                                  "";
                                          controller.isSelected.value = false;
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              CustomNetworkImage(
                                                  imageUrl: controller
                                                          .budgetCategoryList[
                                                              index]
                                                          .image ??
                                                      "",
                                                  height: 20,
                                                  width: 20),
                                              CustomText(
                                                left: 15,
                                                textAlign: TextAlign.start,
                                                text: controller
                                                        .budgetCategoryList[
                                                            index]
                                                        .name ??
                                                    "",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.dark500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox()),

                            SizedBox(height: 12.h),

                            ///==================================✅✅selectDate✅✅=======================
                            CustomTextField(
                              textEditingController: controller.dateController,
                              readOnly: true,
                              hintText: AppStrings.selectDate.tr,
                              fillColor: Colors.white,
                              suffixIcon: const Icon(Icons.calendar_month),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      "${pickedDate.month.toString().padLeft(2, '0')}/"
                                      "${pickedDate.day.toString().padLeft(2, '0')}/"
                                      "${pickedDate.year}";
                                  controller.dateController.text =
                                      formattedDate;
                                }
                              },
                            ),

                            SizedBox(height: 12.h),

                            Row(
                              children: [
                                Expanded(
                                  flex: 4,

                                  ///==================================✅✅selectedCurrency✅✅=======================
                                  child: Obx(() => CustomTextField(
                                        readOnly: true,
                                        hintText:
                                            controller.selectedCurrency.value,
                                        textEditingController:
                                            controller.currencyController,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            showCurrencyPicker(
                                              context: context,
                                              showFlag: true,
                                              showSearchField: true,
                                              showCurrencyName: true,
                                              showCurrencyCode: true,
                                              favorite: [
                                                'USD',
                                                "BHD",
                                                'SAR',
                                                "AED",
                                                'KWD'
                                              ],
                                              onSelect: (Currency currency) {
                                                controller.selectedCurrency
                                                    .value = currency.code;
                                                controller.currencyController
                                                    .text = currency.code;
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 24,
                                            color: AppColors.dark500,
                                          ),
                                        ),
                                      )),
                                ),
                                SizedBox(width: 8.w),

                                ///==================================✅✅amountController✅✅=======================
                                Expanded(
                                  flex: 6,
                                  child: CustomTextField(
                                    textEditingController:
                                        controller.amountController,
                                    keyboardType: TextInputType.number,
                                    hintText: AppStrings.enterAmount,
                                    fieldBorderRadius: 8,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 250.h),

                            ///==================================✅✅Create Button✅✅=======================
                            controller.isCreateLoading.value
                                ? const CustomLoader()
                                : CustomButton(
                                    onTap: () {
                                      controller.budgetCreate();
                                    },
                                    title: AppStrings.createBudgets.tr,
                                    fillColor: AppColors.blue50,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
