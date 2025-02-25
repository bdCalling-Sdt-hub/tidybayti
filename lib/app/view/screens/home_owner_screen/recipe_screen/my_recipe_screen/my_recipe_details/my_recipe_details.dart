import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipe_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

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
              Color(0xCCE8F3FA),
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
              Obx(() {
                switch (recipeController.rxRequestStatus.value) {
                  case Status.loading:
                    return const CustomLoader(); // Show loading indicator

                  case Status.internetError:
                    return NoInternetScreen(onTap: () {
                      recipeController.getRecipeSingle(recipeId: recipeId);
                    });

                  case Status.error:
                    return GeneralErrorScreen(
                      onTap: () {
                        recipeController.getRecipeSingle(recipeId: recipeId);
                      },
                    );

                  case Status.completed:
                    var data = recipeController.recipeSingleData.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //TODO:Image
                          CustomNetworkImage(
                              imageUrl:
                                  "${ApiUrl.networkUrl}${data.recipeImage ?? ""}",
                              height: 191,
                              width: 375),
                          const SizedBox(
                            height: 25,
                          ),
                          //TODO:Recipe Title
                          RecipeInfoRow(
                              label: "${AppStrings.recipeName}:".tr,
                              value: "${data.recipeName ?? " "} "),
                          const SizedBox(height: 8),
                          //TODO:Cooking time
                          RecipeInfoRow(
                              label: AppStrings.cookingTimes.tr,
                              value: "${data.cookingTime ?? " "} minutes"),
                          const SizedBox(height: 8),
                          //TODO:Tag
                          CustomText(
                            text: AppStrings.tag.tr,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: AppColors.dark400,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(data.tags?.length ?? 0, (index) {
                              final tags = data.tags?[index];
                              return CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                text: "${index + 1}. ${tags ?? " "}", // ✅ প্রতিটি স্টেপের আগে সিরিয়াল নম্বর দেখাবে
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.dark300,
                              );
                            }),
                          ),

                          const SizedBox(height: 32),
                          //TODo:Description
                          RecipeSectionTitle(
                              title: "${AppStrings.description}:".tr),
                          const SizedBox(height: 8),
                          RecipeDescription(
                            description: data.description ?? "",
                          ),
                          const SizedBox(height: 16),
                          //TODo:Ingredients
                          RecipeSectionTitle(title: AppStrings.ingredients.tr),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(data.ingredients?.length ?? 0, (index) {
                              final ingredients = data.ingredients?[index];
                              return CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                text: "${index + 1}. ${ingredients ?? " "}", // ✅ প্রতিটি স্টেপের আগে সিরিয়াল নম্বর দেখাবে
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.dark300,
                              );
                            }),
                          ),
                          const SizedBox(height: 16),
                          //TODo:steps
                          RecipeSectionTitle(
                              title: "${AppStrings.describeSteps.tr}:"),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(data.steps?.length ?? 0, (index) {
                              final steps = data.steps?[index];
                              return CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                text: "${index + 1}. ${steps ?? " "}", // ✅ প্রতিটি স্টেপের আগে সিরিয়াল নম্বর দেখাবে
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.dark300,
                              );
                            }),
                          )

                        ],
                      ),
                    );
                }
              })
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

  const RecipeInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          textAlign: TextAlign.start,
          text: '$label ',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.dark300,
          right: 30,
        ),
        Expanded(
          child: CustomText(
            textAlign: TextAlign.start,
            maxLines: 10,
            text: '$value ',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.dark300,
            right: 30,
          ),
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
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.black,
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
