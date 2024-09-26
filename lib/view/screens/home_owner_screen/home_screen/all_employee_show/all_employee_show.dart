import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/main.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_menu_item/custom_menu_item.dart';
import 'package:tidybayte/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class AllEmployeeShow extends StatelessWidget {
  const AllEmployeeShow({super.key});

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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=============================== Menu Title ========================
              /// Menu Title
              CustomMenuAppbar(
                title: AppStrings.employees,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Menu Items ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    CustomTextField(
                      readOnly: true,
                      onTap: () {},
                      hintText: AppStrings.addEmployee,
                      prefixIcon: Icon(Icons.add),
                    ),
                    Card(
                      color: Colors.white,
                      child: Row(
                        children: [
                          CustomNetworkImage(
                            imageUrl: AppConstants.userNtr,
                            height: 53,
                            width: 53,
                            boxShape: BoxShape.circle,
                          ),
                          SizedBox(width: 10.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: 'Sadhu',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.dark400,
                                  ),SizedBox(width: 60.w,),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.info_outline))
                                ],
                              ),
                              CustomText(
                                text: 'Designation: Assistant',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.dark300,
                              ),
                              CustomText(
                                text: 'Id: 123456789',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.dark400,
                              ),
                              CustomText(
                                text: 'Sadhu',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.dark300,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
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
