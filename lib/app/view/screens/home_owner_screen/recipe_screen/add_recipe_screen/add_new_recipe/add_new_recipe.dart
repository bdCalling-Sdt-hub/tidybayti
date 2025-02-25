import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipeApi.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipe_controller.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';

import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class AddNewRecipe extends StatefulWidget {
  const AddNewRecipe({super.key});

  @override
  _AddNewRecipeState createState() => _AddNewRecipeState();
}

class _AddNewRecipeState extends State<AddNewRecipe> {
  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    recipeController.selectedCategories =
        List.generate(recipeController.categories.length, (index) => false);
    recipeController.selectedCategoryNames = [];
  }

  final RecipeController recipeController = Get.find<RecipeController>();

  final String isEdit = Get.arguments[0];
  final String recipeId = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    print(isEdit);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xCCE8F3FA), // First color (with opacity)
              Color(0xFFB5D8EE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              ///=============================== addNewRecipe ========================
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomMenuAppbar(
                    title: AppStrings.addNewRecipe.tr,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ],
              ),

              ///=============================== Form and Grid Content ========================
              Expanded(
                child: Obx(() {
                  return ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      ///=============================== Form Content ========================
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///=============================== recipeName ========================

                            CustomTextField(
                                textEditingController:
                                    recipeController.recipeNameController,
                                hintText: AppStrings.recipeName.tr),
                            const SizedBox(height: 16),

                            ///=============================== Image ========================
                            Obx(() => CustomTextField(
                                  onTap: () {
                                    recipeController.pickImage();
                                  },
                                  readOnly: true,
                                  // If an image is selected, we show an empty hint text; otherwise, we display the default hint text.
                                  hintText:
                                      recipeController.profileImage.value ==
                                              null
                                          ? AppStrings.addPhoto.tr
                                          : '',
                                  // If an image is selected, display it as a prefix icon.
                                  prefixIcon: recipeController
                                              .profileImage.value !=
                                          null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.file(
                                              recipeController
                                                  .profileImage.value!,
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : null,
                                  // Keep your suffix icon if needed.
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.photo,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )),

                            const SizedBox(height: 16),

                            ///=============================== cookingTime ========================
                            CustomTextField(
                              hintText: AppStrings.cookingTime.tr,
                              textEditingController:
                                  recipeController.cookingTimeController,
                            ),
                            const SizedBox(height: 16),

                            ///=============================== description ========================
                            CustomTextField(
                              hintText: AppStrings.description.tr,
                              textEditingController:
                                  recipeController.descriptionController,
                              maxLines: 5,
                            ),
                            const SizedBox(height: 16),

                            ///=============================== Ingredients Step ========================

                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Ingredient Input Field
                                    Expanded(
                                        flex: 3,
                                        child: CustomTextField(
                                          hintText: AppStrings.addIngredients,
                                          textEditingController:
                                              recipeController
                                                  .ingredientsController,
                                        )),
                                    const SizedBox(width: 20),

                                    /// Add Button
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              AppColors.employeeCardColor,
                                          // Text color
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                          textStyle:
                                              const TextStyle(fontSize: 18),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                1), // Rounded corners
                                          ),
                                        ),
                                        onPressed: () {
                                          if (recipeController
                                              .ingredientsController
                                              .text
                                              .isNotEmpty) {
                                            setState(() {
                                              recipeController.ingredientsList
                                                  .add(recipeController
                                                      .ingredientsController
                                                      .text);
                                              recipeController
                                                  .ingredientsController
                                                  .clear();

                                              print(
                                                  'ingredients=======${jsonEncode(recipeController.ingredientsList)}');
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: AppColors.blue900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: recipeController.ingredientsList
                                      .map((ingredient) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Container(
                                              height: 64,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.employeeCardColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                ingredient,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 18),

                                        /// Remove Button
                                        Expanded(
                                          flex: 1,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  AppColors.employeeCardColor,
                                              // Text color
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              textStyle:
                                                  const TextStyle(fontSize: 18),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1), // Rounded corners
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                recipeController.ingredientsList
                                                    .remove(ingredient);
                                                print(
                                                    'ingredients=======${jsonEncode(recipeController.ingredientsList)}');
                                              });
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              color: AppColors.blue900,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),

                            ///=============================== Description Step ========================

                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Step Input Field
                                    Expanded(
                                      flex: 3,
                                      child: CustomTextField(
                                        hintText: AppStrings.describeSteps.tr,
                                        textEditingController: recipeController
                                            .describeStepsController,
                                      ),
                                    ),
                                    const SizedBox(width: 20),

                                    /// Add Step Button
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              AppColors.employeeCardColor,
                                          // Text color
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                          textStyle:
                                              const TextStyle(fontSize: 18),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                1), // Rounded corners
                                          ),
                                        ),
                                        onPressed: () {
                                          if (recipeController
                                              .describeStepsController
                                              .text
                                              .isNotEmpty) {
                                            setState(() {
                                              recipeController.stepsList.add(
                                                  recipeController
                                                      .describeStepsController
                                                      .text);
                                              recipeController
                                                  .describeStepsController
                                                  .clear();

                                              print(
                                                  'StepList=======${jsonEncode(recipeController.stepsList)}');
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: AppColors.blue900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                /// Display Steps List
                                Column(
                                  children:
                                      recipeController.stepsList.map((step) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            height: 64,
                                            padding: const EdgeInsets.all(12),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.employeeCardColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              step,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 18),

                                        /// Remove Step Button
                                        Expanded(
                                          flex: 1,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  AppColors.employeeCardColor,
                                              // Text color
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              textStyle:
                                                  const TextStyle(fontSize: 18),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1), // Rounded corners
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                recipeController.stepsList
                                                    .remove(step);
                                                print(
                                                    'StepList=======${jsonEncode(recipeController.stepsList)}');
                                              });
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              color: AppColors.blue900,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),

                            ///=============================== Select Tags ========================
                            TagSection(),
                            const SizedBox(height: 20),

                            ///=============================== saveAndChange Button ========================

                            recipeController.isLoading.value
                                ? const CustomLoader()
                                : CustomButton(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    onTap: () {

                                      if (recipeController.profileImage.value ==
                                          null) {
                                        toastMessage(
                                            message:
                                                "Please select a Recipe image.");
                                        print(
                                            "❌ Please select a Recipe image.");
                                        return;
                                      }
                                      isEdit == false?
                                      RecipeApi.addRecipe(
                                          context: context,
                                          recipeName: recipeController
                                              .recipeNameController.text,
                                          recipeImage: recipeController
                                              .profileImage.value!,
                                          cookingTime: recipeController
                                              .cookingTimeController.text,
                                          description: recipeController
                                              .descriptionController.text,
                                          ingredients:
                                              recipeController.ingredientsList,
                                          steps: recipeController.stepsList,
                                          tags: recipeController
                                              .selectedCategoryNames):
                                      RecipeApi.editRecipe(

                                          context: context,
                                          recipeName: recipeController
                                              .recipeNameController.text,
                                          recipeImage: recipeController
                                              .profileImage.value!,
                                          cookingTime: recipeController
                                              .cookingTimeController.text,
                                          description: recipeController
                                              .descriptionController.text,
                                          ingredients:
                                          recipeController.ingredientsList,
                                          steps: recipeController.stepsList,
                                          tags: recipeController
                                              .selectedCategoryNames, recipeId: recipeId);
                                      // recipeController.addNewRecipe();
                                    },
                                    fillColor: Colors.white,
                                    title: AppStrings.saveAndChange.tr,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Tag Section
  Column TagSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectTags.tr,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: AppColors.dark300),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 2.5,
          ),
          itemCount: recipeController.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle the selection for this category.
                  recipeController.selectedCategories[index] =
                      !recipeController.selectedCategories[index];

                  // Update the list of selected category names.
                  recipeController.selectedCategoryNames = recipeController
                      .categories
                      .asMap()
                      .entries
                      .where((entry) =>
                          recipeController.selectedCategories[entry.key])
                      .map((entry) => entry.value)
                      .toList();

                  // For debugging or further processing:
                  print(
                      'Selected Categories: "${recipeController.selectedCategoryNames}"');
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: recipeController.selectedCategories[index]
                      ? AppColors.blue900
                      : AppColors.employeeCardColor,
                  border: Border.all(color: Colors.black12),
                ),
                child: Text(
                  recipeController.categories[index],
                  style: TextStyle(
                    color: recipeController.selectedCategories[index]
                        ? AppColors.light200
                        : AppColors.dark300,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
