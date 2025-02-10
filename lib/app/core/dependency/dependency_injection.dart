
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/profile_controller/profile_controller.dart';
import 'package:tidybayte/app/global/controller/auth_controller.dart';



class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Owner section==================
   Get.lazyPut(() => AuthController(), fenix: true);
   Get.lazyPut(() => ProfileController(), fenix: true);




  }
}
