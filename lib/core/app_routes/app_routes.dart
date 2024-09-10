

import 'package:get/get.dart';
import 'package:tidybayte/view/screens/employee_screen/employee_additional_task_screen/employee_additional_screen.dart';
import 'package:tidybayte/view/screens/employee_screen/employee_home_screen/employee_home_screen.dart';
import 'package:tidybayte/view/screens/employee_screen/employee_profile_screen/employee_edit_profile/employee_edit_profile.dart';
import 'package:tidybayte/view/screens/employee_screen/employee_profile_screen/employee_profile_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/authentication/forget_password_screen/forgot_password_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/authentication/forgot_password_otp/forgot_password_otp.dart';
import 'package:tidybayte/view/screens/home_owner_screen/authentication/free_service_screen/free_service_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/authentication/reset_password_screen/reset_password_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/authentication/sign_in_screen/sign_in_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/authentication/sign_up_otp/sign_up_otp.dart';
import 'package:tidybayte/view/screens/home_owner_screen/authentication/sign_up_screen/sign_up_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/home_screen/home_screen.dart';
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
import 'package:tidybayte/view/screens/home_owner_screen/recipe_screen/add_recipe_screen/add_recipe_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/wallet_screen/add_expense_screen/add_expense_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/wallet_screen/budget_details_screen/budget_details_screen.dart';
import 'package:tidybayte/view/screens/home_owner_screen/wallet_screen/crerate_budget_screen/create_budget_screen.dart';

class AppRoutes {

  static const String signInScreen = "/SignInScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String signUpOtp = "/SignUpOtp";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen";
  static const String forgotPasswordOtp = "/ForgotPasswordOtp";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String freeServiceScreen = "/FreeServiceScreen";

  ///=================================Home Section=================
  static const String homeScreen = "/HomeScreen";

  ///===================Wallet Section===================
  static const String createBudgetScreen = "/CreateBudgetScreen";
  static const String budgetDetailsScreen = "/BudgetDetailsScreen";
  static const String addExpenseScreen = "/AddExpenseScreen";


  ///====================Recipe section===================
  static const String addRecipeScreen = "/AddRecipeScreen";

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

  ///====================Employee section===================
  static const String employeeEditProfile = "/EmployeeEditProfile";
  static const String employeeProfileScreen = "/EmployeeProfileScreen";
  static const String employeeHomeScreen = "/EmployeeHomeScreen";
  static const String employeeAdditionalScreen = "/EmployeeAdditionalScreen";

  static List<GetPage> routes = [
    GetPage(name: signInScreen, page: () => const SignInScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: signUpOtp, page: () => const SignUpOtp()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: forgotPasswordOtp, page: () => const ForgotPasswordOtp()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: freeServiceScreen, page: () => const FreeServiceScreen()),

    ///===========================Home Section=======================
    GetPage(name: homeScreen, page: () => const HomeScreen()),


    ///=========================Wallet section==============
    GetPage(name: createBudgetScreen, page: () => const CreateBudgetScreen()),
    GetPage(name: budgetDetailsScreen, page: () => const BudgetDetailsScreen()),
    GetPage(name: addExpenseScreen, page: () => const AddExpenseScreen()),


    ///======================Recipe Section====================
    GetPage(name: addRecipeScreen, page: () => const AddRecipeScreen()),


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

    ///======================Employee section=========================
    GetPage(name: employeeEditProfile, page: () => const EmployeeEditProfile()),
    GetPage(name: employeeProfileScreen, page: () => const EmployeeProfileScreen()),
    GetPage(name: employeeHomeScreen, page: () => const EmployeeHomeScreen()),
    GetPage(name: employeeAdditionalScreen, page: () => const EmployeeAdditionalScreen()),
  ];
}
