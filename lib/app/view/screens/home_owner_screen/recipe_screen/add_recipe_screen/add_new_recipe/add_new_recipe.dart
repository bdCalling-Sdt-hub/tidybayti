import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
class AddNewRecipe extends StatefulWidget {
  const AddNewRecipe({super.key});

  @override
  _AddNewRecipeState createState() => _AddNewRecipeState();
}

class _AddNewRecipeState extends State<AddNewRecipe> {
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController describeStepsController = TextEditingController();

  final List<String> ingredientsList = [];
  final List<String> stepsList = [];

  final formKey = GlobalKey<FormState>();

  // List of categories
  final List<String> categories = [
    'Appetizers', 'Asian', 'Breakfast', 'Dessert', 'Dinner',
  ];

  // List to keep track of selected items
  List<bool> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    // Initialize the selection list with false (not selected)
    selectedCategories = List.generate(categories.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 4),
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
              ///=============================== Menu Title ========================
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomMenuAppbar(
                    title: 'Add New Recipe',
                    onBack: () {
                      Get.back();
                    },
                  ),
                ],
              ),

              ///=============================== Form and Grid Content ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    ///=============================== Form Content ========================
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            hintText: AppStrings.recipeName,
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            hintText: AppStrings.addPhoto,
                            suffixIcon: const Icon(Icons.photo,color: Colors.grey,),
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            hintText: AppStrings.cookingTime,
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            hintText: AppStrings.description,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 16),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Ingredient Input Field
                              Expanded(
                                  flex: 3,
                                  child: CustomTextField(
                                    hintText: AppStrings.addIngredients,
                                    textEditingController: ingredientsController,
                                  )),
                              const SizedBox(width: 20),

                              /// Add Button
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white, backgroundColor: AppColors.employeeCardColor, // Text color
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    textStyle: const TextStyle(fontSize: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1), // Rounded corners
                                    ),
                                  ),
                                  onPressed: () {
                                    if (ingredientsController.text.isNotEmpty) {
                                      setState(() {
                                        ingredientsList.add(ingredientsController.text);
                                        ingredientsController.clear();
                                      });
                                    }
                                  },
                                  child: const Icon(Icons.add,color: AppColors.blue900,),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          /// Display Ingredients List
                          Column(
                            children: ingredientsList.map((ingredient) {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Container(
                                        height: 64,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppColors.employeeCardColor,
                                          borderRadius: BorderRadius.circular(8),
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
                                        foregroundColor: Colors.white, backgroundColor: AppColors.employeeCardColor, // Text color
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                        textStyle: const TextStyle(fontSize: 18),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(1), // Rounded corners
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          ingredientsList.remove(ingredient);
                                        });
                                      },
                                      child: const Icon(Icons.remove,color: AppColors.blue900,),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Step Input Field
                              Expanded(
                                flex: 3,
                                child: CustomTextField(
                                  hintText: AppStrings.describeSteps,
                                  textEditingController: describeStepsController,
                                ),
                              ),
                              const SizedBox(width: 20),

                              /// Add Step Button
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white, backgroundColor: AppColors.employeeCardColor, // Text color
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    textStyle: const TextStyle(fontSize: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1), // Rounded corners
                                    ),
                                  ),
                                  onPressed: () {
                                    if (describeStepsController.text.isNotEmpty) {
                                      setState(() {
                                        stepsList.add(describeStepsController.text);
                                        describeStepsController.clear();
                                      });
                                    }
                                  },
                                  child: const Icon(Icons.add,color: AppColors.blue900,),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          /// Display Steps List
                          Column(
                            children: stepsList.map((step) {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 64,
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColors.employeeCardColor,
                                        borderRadius: BorderRadius.circular(8),
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
                                        foregroundColor: Colors.white, backgroundColor: AppColors.employeeCardColor, // Text color
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                        textStyle: const TextStyle(fontSize: 18),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(1), // Rounded corners
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          stepsList.remove(step);
                                        });
                                      },
                                      child: const Icon(Icons.remove,color: AppColors.blue900,),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 20),

                          ///=============================== Category Selection ========================
                          const Text(
                            'Select Tags',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300,color: AppColors.dark300),
                          ),
                          const SizedBox(height: 10),

                          // Category GridView
                          GridView.builder(
                            shrinkWrap: true, // To prevent it from expanding infinitely
                            physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Number of columns
                              crossAxisSpacing: 10.0, // Spacing between columns
                              mainAxisSpacing: 10.0, // Spacing between rows
                              childAspectRatio: 2.5, // Aspect ratio for the buttons
                            ),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Toggle selection state
                                    selectedCategories[index] = !selectedCategories[index];
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selectedCategories[index] ? AppColors.blue900 : AppColors.employeeCardColor,
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: selectedCategories[index] ? AppColors.light200 : AppColors.dark300,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            width: MediaQuery.of(context).size.width / 1.1,
                            onTap: () {
                            Get.toNamed(AppRoutes.myRecipeScreen);
                            },
                            fillColor: Colors.white,
                            title: AppStrings.saveAndChange,
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

      /// Floating Action Button for Save

    );
  }
}
