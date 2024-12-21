import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/view/screens/home_owner_screen/home_screen/home_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/menu_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/recipe_screen/recipe_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/schedule_screen/schedule_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/wallet_screen/wallet_screen.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<NavBar> {
  late int bottomNavIndex;

  final List<String> unselectedIcon = [
    AppIcons.homeUnselected,
    AppIcons.scheduleUnselected,
    AppIcons.walletUnselected,
    AppIcons.recipeUnselected,
    AppIcons.menuUnselected,
  ]; final List<String> selectedIcon = [
    AppIcons.homeSelected,
    AppIcons.scheduleSelected,
    AppIcons.walletSelected,
    AppIcons.recipeSelected,
    AppIcons.menuSelected,
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
          Get.offAll(() => const HomeScreen());
          break;
        case 1:
          Get.to(() => const ScheduleScreen());
          break;
        case 2:
          Get.to(() =>  WalletScreen());
          break;
        case 3:
          Get.to(() => const RecipeScreen());
          break;
        case 4:
          Get.to(() => const MenuScreen());
      }
    }
  }
}
