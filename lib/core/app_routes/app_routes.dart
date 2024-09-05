

import 'package:get/get.dart';
import 'package:tidybayte/view/screens/home_owner_screen/authentication/sign_in_screen/sign_in_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/my_plan_screen/my_plan_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/personal_info_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/personal_info_screen/personal_info_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/setting_screen/about_us_screen/about_us_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/setting_screen/change_password_screen/change_password_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/setting_screen/help_where_screen/help_where_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/setting_screen/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/setting_screen/setting_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/setting_screen/terms_and_service_screen/terms_and_service_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/menu_screen/upgrade_packages/upgrade_packages.dart';

class AppRoutes {
  static const String signInScreen = "/SignInScreen";

  ///================================Menu Screen =====================
  static const String personalInfoScreen = "/PersonalInfoScreen";
  static const String upgradePackages = "/UpgradePackages";
  static const String myPlanScreen = "/MyPlanScreen";
  static const String settingScreen = "/SettingScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String termsAndServiceScreen = "/TermsAndServiceScreen";
  static const String privacyPolicyScreen = "/PrivacyPolicyScreen";
  static const String aboutUsScreen = "/AboutUsScreen";
  static const String helpWhereScreen = "/HelpWhereScreen";
  static const String editProfileScreen = "/EditProfileScreen";

  static List<GetPage> routes = [
    GetPage(name: signInScreen, page: () => const SignInScreen()),


    ///================================Menu Screen =====================
    GetPage(name: personalInfoScreen, page: () => const PersonalInfoScreen()),
    GetPage(name: upgradePackages, page: () => const UpgradePackages()),
    GetPage(name: myPlanScreen, page: () => const MyPlanScreen()),
    GetPage(name: settingScreen, page: () => const SettingScreen()),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: termsAndServiceScreen, page: () => const TermsAndServiceScreen()),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: aboutUsScreen, page: () => const AboutUsScreen()),
    GetPage(name: helpWhereScreen, page: () => const HelpWhereScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
  ];
}
