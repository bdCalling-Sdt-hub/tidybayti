
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/notification_controller/notification_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/home_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/profile_controller/profile_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/recipe_controller/recipe_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/setting_controller/setting_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/task_controller/task_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/wallet_controller/wallet_controller.dart';
import 'package:tidybayte/app/global/controller/auth_controller.dart';



class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Owner section==================
   Get.lazyPut(() => AuthController(), fenix: true);
   Get.lazyPut(() => ProfileController(), fenix: true);
   Get.lazyPut(() => SettingController(), fenix: true);
   Get.lazyPut(() => RecipeController(), fenix: true);
   Get.lazyPut(() => WalletController(), fenix: true);
   Get.lazyPut(() => NotificationController(), fenix: true);
   Get.lazyPut(() => AddEmployeeController(), fenix: true);
   Get.lazyPut(() => TaskController(), fenix: true);
   Get.lazyPut(() => HomeController(), fenix: true);




  }
}
