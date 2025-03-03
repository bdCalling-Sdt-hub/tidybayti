import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/language_controller/langauge_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_appbar/custom_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';


class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final LanguageController languageController = Get.find<LanguageController>();
  final List<String> languageList = ["English", "German"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.blue500,
      appBar: CustomAppBar(

        appBarContent: AppStrings.language.tr,
        iconData: Icons.arrow_back,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///===========================Select Your language==================
              CustomText(
                text: AppStrings.selectYourLanguage.tr,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                bottom: 10,
              ),

              /// Language selection row
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 44,
                      child: CustomTextField(

                        inputTextStyle: const TextStyle(color: Colors.black),
                        onTap: () {
                          languageController.isLanguage.value =
                          !languageController.isLanguage.value;
                        },
                        readOnly: true,
                        textEditingController: languageController.language,
                        hintText: 'Language',
                        fillColor: Colors.white,
                        fieldBorderColor: AppColors.profileCard,
                        suffixIcon: Icon(
                          languageController.isLanguage.value
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    /// Dropdown options
                    if (languageController.isLanguage.value)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: languageList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Update locale and UI
                                final selectedLocale =
                                index == 0
                                    ? const Locale("en", "US")
                                    : const Locale("de", "DE"); // Changed to German
                                Get.updateLocale(selectedLocale);

                                languageController.selectedCategory.value = index;
                                languageController.language.text =
                                languageList[index];
                                languageController.isLanguage.value = false;
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: CustomText(
                                  text: languageList[index],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: languageController.selectedCategory.value == index
                                      ? AppColors.profileCard
                                      : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
