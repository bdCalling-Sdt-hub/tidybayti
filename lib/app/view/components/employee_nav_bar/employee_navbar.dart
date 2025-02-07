import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_additional_task_screen/employee_additional_screen.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_home_screen/employee_home_screen.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_profile_screen/employee_profile_screen.dart';


class EmployeeNavbar extends StatefulWidget {
  final int currentIndex;

  const EmployeeNavbar({required this.currentIndex, super.key});

  @override
  State<EmployeeNavbar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<EmployeeNavbar> {
  late int bottomNavIndex;

  final List<String> unselectedIcon = [
    AppIcons.homeUnselected,
    AppIcons.scheduleUnselected,
    AppIcons.person,
  ]; final List<String> selectedIcon = [
    AppIcons.homeSelected,
    AppIcons.scheduleSelected,
    AppIcons.personSelected,
  ];



  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      color: AppColors.blue300,
      height: 64.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
              (index) => InkWell(
            onTap: () => onTap(index),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: CustomImage(
                imageSrc: bottomNavIndex == index
                    ? selectedIcon[index]
                    : unselectedIcon[index],
                imageType: ImageType.svg,
                size: 24.r,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index != bottomNavIndex) {
      switch (index) {
        case 0:
          Get.offAll(() =>  EmployeeHomeScreen( ));
          break;
        case 1:
          Get.to(() => const EmployeeAdditionalScreen());
          break;
        case 2:
          Get.to(() => const EmployeeProfileScreen());

      }
    }
  }
}
