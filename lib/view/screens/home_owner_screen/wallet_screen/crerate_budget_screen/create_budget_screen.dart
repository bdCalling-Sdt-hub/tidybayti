import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tidybayte/helper/time_converter/time_converter.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';

class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({super.key});

  @override
  _CreateBudgetScreenState createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSelected = false;
  DateTime selectedDate = DateTime.now();

  // Method to handle date selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///=============================== Budget Appbar ========================
                CustomMenuAppbar(
                  title: AppStrings.budget,
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
                      Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),

                            ///===============================Select Category============
                            CustomTextField(
                              fillColor: Colors.white,
                              hintText: AppStrings.selectCategory,
                              suffixIcon: Icon(
                                isSelected
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down_rounded,
                                size: 28,
                                color: AppColors.blue,
                              ),
                              onTap: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              },
                            ),

                            /// Category Dropdown
                            if (isSelected)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  5, // Replace this with actual category count
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelected = false;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.blue,
                                            width: 1.0,
                                          ),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: CustomText(
                                        text: "Category $index",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.dark500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            SizedBox(height: 12.h),

                            ///==================================Select Date==================
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      color: AppColors.dark500,
                                      fontWeight: FontWeight.w500,
                                      text: DateConverter.estimatedDate(
                                          selectedDate),
                                    ),
                                    const CustomImage(
                                      imageSrc: AppIcons.calendar,
                                      size: 24,
                                      imageColor: AppColors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),


                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    readOnly: true,
                                    hintText: 'BHD',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        // showCurrencyPicker(
                                        //   context: context,
                                        //   showFlag: true,
                                        //   showSearchField: true,
                                        //   showCurrencyName: true,
                                        //   showCurrencyCode: true,
                                        //   favorite: ['USD', "BHD", 'SAR', "AED", 'KWD'],
                                        //   onSelect: (Currency currency) {
                                        //     print('Selected currency: ${currency.name}');
                                        //   },
                                        // );
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 24,
                                        color: AppColors.dark500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                const Expanded(
                                  flex: 2,
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    hintText: AppStrings.enterAmount,
                                    fieldBorderRadius: 8,
                                    fillColor:Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 250.h),
                            /// Add Budget Button as BottomNavigationBar
                        CustomButton(
                              onTap: () {
                                Get.back();
                              },
                              title: AppStrings.createBudgets,
                              fillColor: AppColors.blue50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }
}
