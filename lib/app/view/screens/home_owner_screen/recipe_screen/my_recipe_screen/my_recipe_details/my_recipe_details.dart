import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipe_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class MyRecipeDetails extends StatefulWidget {
  const MyRecipeDetails({super.key});

  @override
  State<MyRecipeDetails> createState() => _MyRecipeDetailsState();
}

class _MyRecipeDetailsState extends State<MyRecipeDetails> {
  final String recipeId = Get.arguments;
  final RecipeController recipeController = Get.find<RecipeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      recipeController.getRecipeSingle(recipeId: recipeId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(recipeId);
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///==================================✅✅Recipe Details✅✅=======================

              CustomMenuAppbar(
                title: AppStrings.recipeDetails.tr,
                onBack: () {
                  Get.back();
                },
                isEdit: true,
                onTap: () {
                  Get.toNamed(AppRoutes.addNewRecipe);
                },
              ),
              const SizedBox(
                height: 15,
              ),

              ///==================================✅✅Recipe Details✅✅=======================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO:Image
                    CustomNetworkImage(
                        imageUrl: AppConstants.fruits, height: 191, width: 375),
                    const SizedBox(
                      height: 25,
                    ),
                    //TODO:Recipe Title
                    const CustomText(
                      text: 'Recipe Title',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.dark400,
                    ),
                    const SizedBox(height: 8),
                    //TODO:Cooking time
                    const RecipeInfoRow(
                        label: 'Cooking time:', value: '30 min'),
                    const SizedBox(height: 8),
                    //TODO:Tag
                    const RecipeInfoRow(label: 'Tag:', value: 'Asian / Indian'),

                    const SizedBox(height: 32),
                    //TODo:Description
                    const RecipeSectionTitle(title: 'Description:'),
                    const SizedBox(height: 8),
                    const RecipeDescription(
                      description: '',
                    ),
                    const SizedBox(height: 16),
                    //TODo:Ingredients
                    const RecipeSectionTitle(title: 'Ingredients:'),
                    const SizedBox(height: 8),
                    const RecipeIngredients(
                      ingredients:
                          '· 3 cups rice\n· 1 cup skinless black gram urad daal\n· 1/4 teaspoon salt\n· 2 tablespoons vegetable oil, or canola oil',
                    ),
                    const SizedBox(height: 16),
                    //TODo:steps
                    const RecipeSectionTitle(title: 'Describe steps:'),
                    const SizedBox(height: 8),
                    RecipeSteps(steps: ""),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const RecipeInfoRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: '$label ',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.dark300,
          right: 30,
        ),
        CustomText(
          text: '$value ',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.dark300,
          right: 30,
        ),
      ],
    );
  }
}

class RecipeSectionTitle extends StatelessWidget {
  final String title;

  const RecipeSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: '$title ',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.dark300,
      right: 30,
    );
  }
}

class RecipeDescription extends StatelessWidget {
  final String description;

  const RecipeDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: '$description ',
      fontSize: 16,
      maxLines: 8,
      textAlign: TextAlign.start,
      fontWeight: FontWeight.w400,
      color: AppColors.dark300,
      right: 30,
    );
  }
}

class RecipeIngredients extends StatelessWidget {
  final String ingredients;

  const RecipeIngredients({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: '$ingredients ',
      fontSize: 16,
      textAlign: TextAlign.start,
      fontWeight: FontWeight.w400,
      color: AppColors.dark300,
    );
  }
}

class RecipeSteps extends StatelessWidget {
  final String steps;

  const RecipeSteps({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      textAlign: TextAlign.start,
      text: '$steps ',
      fontSize: 16,
      maxLines: 10,
      fontWeight: FontWeight.w400,
      color: AppColors.dark300,
      right: 30,
    );
  }
}
