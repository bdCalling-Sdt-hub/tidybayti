

import 'package:get/get.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_additional_task_screen/employee_additional_screen.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_home_screen/employee_home_screen.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_notification_screen/employee_notification_screen.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_profile_screen/employee_edit_profile/employee_edit_profile.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_profile_screen/employee_profile_screen.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_sign_in_screen/employee_sign_in_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/authentication/forget_password_screen/forgot_password_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/authentication/forgot_password_otp/forgot_password_otp.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/authentication/free_service_screen/free_service_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/authentication/reset_password_screen/reset_password_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/authentication/sign_in_screen/sign_in_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/authentication/sign_up_otp/sign_up_otp.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/authentication/sign_up_screen/sign_up_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/add_employee_screen/add_employee_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/add_employee_screen/assign_task_successfully_screen/assign_task_successfully_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/add_employee_screen/assign_work_schedule_screen/assign_work_schedule_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/add_employee_screen/assign_work_screen/assign_work_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/add_employee_screen/mail_sent_successfully_screen/main_sent_successfully_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/all_employee_show/all_employee_show.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/employee_details/edit_employee_details/edit_employee_details.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/employee_details/employee_details.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/home_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/house_information_screen/house_information_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/house_type_screen/house_type_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/home_screen/room_details_screen/room_details_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/my_plan_screen/my_plan_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/personal_info_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/personal_info_screen/personal_info_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/setting_screen/about_us_screen/about_us_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/setting_screen/change_password_screen/change_password_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/setting_screen/help_where_screen/help_where_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/setting_screen/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/setting_screen/setting_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/setting_screen/terms_and_service_screen/terms_and_service_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/menu_screen/upgrade_packages/upgrade_packages.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/recipe_screen/add_recipe_screen/add_new_recipe/add_new_recipe.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/recipe_screen/add_recipe_screen/add_recipe_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/recipe_screen/favorite_recipes_screen/favorites_recipe_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/recipe_screen/my_recipe_screen/my_recipe_details/my_recipe_details.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/recipe_screen/my_recipe_screen/my_recipe_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/recipe_screen/search_recipe_screen/search_recipe_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/recipe_screen/tags_screen/tags_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/task_schedule/all_task_screen/all_task_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/task_schedule/completed_task/completed_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/task_schedule/create_task/create_task.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/task_schedule/grocery_task/add_grocery_task/add_grocery_task.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/task_schedule/grocery_task/employee_list/employee_list.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/task_schedule/grocery_task/grocery_task.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/task_schedule/ongoing_task/ongoing_task.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/task_schedule/pending_task/pending_task.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/splash_screen/splash_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/wallet_screen/add_expense_screen/add_expense_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/wallet_screen/budget_details_screen/budget_details_screen.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/wallet_screen/crerate_budget_screen/create_budget_screen.dart';
import 'package:tidybayte/app/view/screens/onboard_screen/chose_onboard_screen/chose_onboard_screen.dart';
import 'package:tidybayte/app/view/screens/onboard_screen/home_owner_chose_auth/home_owner_chose_auth.dart';
import 'package:tidybayte/app/view/screens/onboard_screen/onBoard_screen/onboard_screen.dart';

class AppRoutes {

  static const String splashScreen = "/SplashScreen";
  static const String signInScreen = "/SignInScreen";
  static const String employeeNotificationScreen = "/EmployeeNotificationScreen";
  static const String onboardScreen = "/OnboardScreen";
  static const String choseOnBoardingScreen = "/ChoseOnBoardingScreen";
  static const String homeOwnerChoseAuth = "/HomeOwnerChoseAuth";
  static const String signUpScreen = "/SignUpScreen";
  static const String signUpOtp = "/SignUpOtp";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen";
  static const String forgotPasswordOtp = "/ForgotPasswordOtp";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String freeServiceScreen = "/FreeServiceScreen";

  ///=================================Home Section=================
  static const String homeScreen = "/HomeScreen";
  static const String houseTypeScreen = "/HouseTypeScreen";
  static const String houseInformationScreen = "/HouseInformationScreen";
  static const String allEmployeeShow = "/AllEmployeeShow";
  static const String employeeDetails = "/EmployeeDetails";
  static const String addEmployeeScreen = "/AddEmployeeScreen";
  static const String roomDetailsScreen = "/RoomDetailsScreen";
  static const String editEmployeeDetails = "/EditEmployeeDetails";
  static const String mainSentSuccessfullyScreen = "/MainSentSuccessfullyScreen";
  static const String assignWorkScheduleScreen = "/AssignWorkScheduleScreen";
  static const String assignWorkScreen = "/AssignWorkScreen";
  static const String assignTaskSuccessfullyScreen = "/AssignTaskSuccessfullyScreen";

  ///===================Wallet Section===================
  static const String createBudgetScreen = "/CreateBudgetScreen";
  static const String budgetDetailsScreen = "/BudgetDetailsScreen";
  static const String addExpenseScreen = "/AddExpenseScreen";


  ///====================Recipe section===================
  static const String addRecipeScreen = "/AddRecipeScreen";
  static const String myRecipeScreen = "/MyRecipeScreen";
  static const String searchRecipeScreen = "/SearchRecipeScreen";
  static const String favoritesRecipeScreen = "/FavoritesRecipeScreen";
  static const String tagsScreen = "/TagsScreen";
  static const String addNewRecipe = "/AddNewRecipe";
  static const String myRecipeDetails = "/MyRecipeDetails";

  ///===================Schedule Screen====================
  static const String allTaskScreen = "/AllTaskScreen";
  static const String completedScreen = "/CompletedScreen";
  static const String ongoingTask = "/OngoingTask";
  static const String pendingTask = "/PendingTask";
  static const String groceryTask = "/GroceryTask";
  static const String addGroceryTask = "/AddGroceryTask";
  static const String employeeList = "/EmployeeList";

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
  static const String employeeSignInScreen = "/EmployeeSignInScreen";
  static const String employeeEditProfile = "/EmployeeEditProfile";
  static const String employeeProfileScreen = "/EmployeeProfileScreen";
  static const String employeeHomeScreen = "/EmployeeHomeScreen";
  static const String employeeAdditionalScreen = "/EmployeeAdditionalScreen";
  static const String createTask = "/CreateTask";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () =>  const SplashScreen()),
    GetPage(name: signInScreen, page: () =>  SignInScreen()),
    GetPage(name: onboardScreen, page: () => const OnboardScreen()),
    GetPage(name: choseOnBoardingScreen, page: () => const ChoseOnboardScreen()),
    GetPage(name: homeOwnerChoseAuth, page: () =>  HomeOwnerChoseAuth()),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen()),
    GetPage(name: signUpOtp, page: () =>  SignUpOtp()),
    GetPage(name: forgotPasswordScreen, page: () =>  ForgotPasswordScreen()),
    GetPage(name: forgotPasswordOtp, page: () =>  ForgotPasswordOtp()),
    GetPage(name: resetPasswordScreen, page: () =>  ResetPasswordScreen()),
    GetPage(name: freeServiceScreen, page: () =>  FreeServiceScreen()),

    ///===========================Home Section=======================
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: houseTypeScreen, page: () => const HouseTypeScreen()),
    GetPage(name: houseInformationScreen, page: () =>  HouseInformationScreen()),
    GetPage(name: allEmployeeShow, page: () =>  AllEmployeeShow()),
    GetPage(name: employeeDetails, page: () =>  const EmployeeDetails()),
    GetPage(name: addEmployeeScreen, page: () =>  const AddEmployeeScreen()),
    GetPage(name: roomDetailsScreen, page: () =>  const RoomDetailsScreen()),
    GetPage(name: mainSentSuccessfullyScreen, page: () => const MainSentSuccessfullyScreen()),
    GetPage(name: assignWorkScheduleScreen, page: () => const AssignWorkScheduleScreen()),
    GetPage(name: assignWorkScreen, page: () => const AssignWorkScreen()),
    GetPage(name: assignTaskSuccessfullyScreen, page: () => const AssignTaskSuccessfullyScreen()),


    ///=========================Wallet section==============
    GetPage(name: createBudgetScreen, page: () =>  const CreateBudgetScreen()),
    GetPage(name: budgetDetailsScreen, page: () => const BudgetDetailsScreen()),
    GetPage(name: addExpenseScreen, page: () => const AddExpenseScreen()),


    ///======================Recipe Section====================
    GetPage(name: addRecipeScreen, page: () => const AddRecipeScreen()),
    GetPage(name: myRecipeScreen, page: () => const MyRecipeScreen()),
    GetPage(name: searchRecipeScreen, page: () => const SearchRecipeScreen()),
    GetPage(name: favoritesRecipeScreen, page: () => const FavoritesRecipeScreen()),
    GetPage(name: tagsScreen, page: () =>  TagsScreen()),
    GetPage(name: addNewRecipe, page: () =>  const AddNewRecipe()),
    GetPage(name: myRecipeDetails, page: () =>  const MyRecipeDetails()),


    ///===========================Schedule Screen=====================
    GetPage(name: allTaskScreen, page: () =>  AllTaskScreen()),
    GetPage(name: completedScreen, page: () => const CompletedScreen()),
    GetPage(name: ongoingTask, page: () =>  const OngoingTask()),
    GetPage(name: pendingTask, page: () =>  const PendingTask()),
    GetPage(name: groceryTask, page: () => const GroceryTask()),
    GetPage(name: addGroceryTask, page: () => const AddGroceryTask()),
    GetPage(name: employeeList, page: () => const EmployeeList()),


    ///================================Menu Screen =====================
    GetPage(name: personalInfoScreen, page: () =>  PersonalInfoScreen()),
    GetPage(name: upgradePackages, page: () =>  UpgradePackages()),
    GetPage(name: myPlanScreen, page: () =>  MyPlanScreen()),
    GetPage(name: settingScreen, page: () => const SettingScreen()),
    GetPage(name: changePasswordScreen, page: () =>  ChangePasswordScreen()),
    GetPage(name: termsAndServiceScreen, page: () => const TermsAndServiceScreen()),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: aboutUsScreen, page: () => const AboutUsScreen()),
    GetPage(name: helpWhereScreen, page: () => const HelpWhereScreen()),
    GetPage(name: editProfileScreen, page: () =>  const EditProfileScreen()),
    GetPage(name: createTask, page: () =>  const CreateTask()),

















    ///======================Employee section=========================
    GetPage(name: employeeEditProfile, page: () => const EmployeeEditProfile()),
    GetPage(name: employeeSignInScreen, page: () => const EmployeeSignInScreen()),
    GetPage(name: employeeProfileScreen, page: () =>  EmployeeProfileScreen()),
    GetPage(name: employeeHomeScreen, page: () =>  EmployeeHomeScreen()),
    GetPage(name: employeeNotificationScreen, page: () =>  const EmployeeNotificationScreen()),
    GetPage(name: employeeAdditionalScreen, page: () => const EmployeeAdditionalScreen()),
    GetPage(name: editEmployeeDetails, page: () => const EditEmployeeDetails()),
  ];
}
