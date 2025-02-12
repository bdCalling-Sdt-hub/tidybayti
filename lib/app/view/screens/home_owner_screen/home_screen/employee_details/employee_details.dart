import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_profile_item/custom_profile_item.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///==================================✅✅employeeDetails Appbar✅✅=======================

                CustomMenuAppbar(
                  onTap: () {
                    Get.toNamed(AppRoutes.editEmployeeDetails);
                  },
                  isEdit: true,
                  title: AppStrings.employeeDetails.tr,
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
                          Color(0xCCE8F3FA), // First color (with opacity)
                          Color(0xCCE8F3FA), // First color (with opacity)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CustomNetworkImage(
                              boxShape: BoxShape.circle,
                              imageUrl: AppConstants.employee,
                              height: 128,
                              width: 128),
                        ),

                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          children: [
                            CustomText(
                              textAlign: TextAlign.start,
                              top: 10,
                              text: "${AppStrings.firstName}: ".tr,
                              color: AppColors.dark400,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            const Expanded(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                top: 10,
                                text: "",
                                color: AppColors.dark400,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),

                        ///============================First Name=====================
                         CustomProfileItem(
                          title: "${AppStrings.lastName} :".tr,
                          subTitle: '',
                        ),

                        ///================================last Name========================
                         CustomProfileItem(
                          title: AppStrings.id.tr,
                          subTitle: '',
                        ),

                        ///================================Email========================
                         CustomProfileItem(
                          title: '${AppStrings.email.tr}:',
                          subTitle: '',
                        ),

                        ///================================Contact No========================
                         CustomProfileItem(
                          title: "${AppStrings.contactNumber.tr}:",
                          subTitle: '',
                        ),



                        ///================================CPR========================
                         CustomProfileItem(
                          title: '${AppStrings.cPR.tr}:',
                          subTitle: '',
                        ),

                        ///================================Passport:  ========================
                         CustomProfileItem(
                          title: '${AppStrings.passport.tr}:',
                          subTitle: '',
                        ),

                        ///================================drivingLicense  ========================
                         CustomProfileItem(
                          title: "${AppStrings.note.tr} :",
                          subTitle: '',
                        ),

                        ///================================jobType  ========================
                         CustomProfileItem(
                          title: '${AppStrings.jobType.tr}:',
                          subTitle: '',
                        ),

                        ///================================joiningDate  ========================
                         CustomProfileItem(
                          title: AppStrings.joiningDate.tr,
                          subTitle: ' ',
                        ),

                        ///================================dutyTime  ========================
                         CustomProfileItem(
                          title: AppStrings.dutyTime.tr,
                          subTitle: '',
                        ),

                        ///================================workingDay  ========================
                         CustomProfileItem(
                          title: AppStrings.workingDay.tr,
                          subTitle: '',
                        ),

                        ///================================offDay  ========================
                         CustomProfileItem(
                          title: AppStrings.offDay.tr,
                          subTitle: '',
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
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


