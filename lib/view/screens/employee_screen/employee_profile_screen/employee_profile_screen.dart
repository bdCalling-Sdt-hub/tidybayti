import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';

import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/employee_nav_bar/employee_navbar.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const EmployeeNavbar(currentIndex: 2),
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
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=============================== profile Appbar ========================
                CustomMenuAppbar(
                  onTap: () {
                    Get.toNamed(AppRoutes.employeeEditProfile);
                  },
                  isEdit: true,
                  title: AppStrings.profile,
                  onBack: () {
                    Get.back();
                  },
                ),

                ///==========================Body Here=====================

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.blue100, // First color (with opacity)
                          AppColors.blue100, // First color (with opacity)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child:  Column(
                      children: [
                        CustomNetworkImage(
                            boxShape: BoxShape.circle,
                            imageUrl: AppConstants.employee, height: 128, width: 128),
                        const CustomText(
                          top: 10,
                          text: 'Habib',
                          color: AppColors.dark400,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),  const CustomText(
                          text: 'assistant',
                          color: AppColors.dark300,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          bottom: 24,
                        ),
                        ///============================First Name=====================
                        const CustomProfileItem(
                          title:'${ AppStrings.designation}:',
                          subTitle: 'Assistant ',
                        ),

                        ///================================last Name========================
                        const CustomProfileItem(
                          title: AppStrings.id,
                          subTitle: 'Raj',
                        ),

                        ///================================Email========================
                        const CustomProfileItem(
                          title: '${AppStrings.email}:',
                          subTitle: 'masumrna927@gmail.com',
                        ),

                        ///================================Contact No========================
                        const CustomProfileItem(
                          title: "${AppStrings.contactNumber}:",
                          subTitle: '0172228692',
                        ),

                        ///================================Address========================
                        const CustomProfileItem(
                          title: '${AppStrings.address}:',
                          subTitle: 'Dhaka',
                        ),

                        ///================================CPR========================
                        const CustomProfileItem(
                          title: '${AppStrings.cPR}:',
                          subTitle: ' S2054RDSAD',
                        ),
                        ///================================Passport:  ========================
                        const CustomProfileItem(
                          title: '${AppStrings.passport}:',
                          subTitle: ' 3216516549655',
                        ),

                        ///================================drivingLicense  ========================
                        const CustomProfileItem(
                          title: '${AppStrings.drivingLicense}:',
                          subTitle: ' 12335548949',
                        ),

                        ///================================jobType  ========================
                        const CustomProfileItem(
                          title: '${AppStrings.jobType}:',
                          subTitle: ' Full Time',
                        ),

                        ///================================joiningDate  ========================
                        const CustomProfileItem(
                          title: AppStrings.joiningDate,
                          subTitle: '  1/1/2024',
                        ),

                        ///================================drivingLicense  ========================
                        const CustomProfileItem(
                          title: 'Duty Time',
                          subTitle: '10 am - 08:00pm',
                        ), ///================================drivingLicense  ========================
                        const CustomProfileItem(
                          title: 'Working Day',
                          subTitle: 'Sat,Mon',
                        ),

                       SizedBox(height: 20.h,),
                       CustomButton(onTap: (){

                       },
                       fillColor: AppColors.blue50,
                         title: AppStrings.changePassword,
                       )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class CustomProfileItem extends StatelessWidget {
  final String title;
  final String subTitle;

  const CustomProfileItem({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: CustomText(
            textAlign: TextAlign.start,
            color: AppColors.dark300,
            text: title,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            bottom: 10,
          ),
        ),  Expanded(
          flex: 6,
          child: CustomText(
            textAlign: TextAlign.start,
            color: AppColors.dark300,
            text: subTitle,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            bottom: 10,
          ),
        ),

        SizedBox(height: 8.h),
      ],
    );
  }
}
