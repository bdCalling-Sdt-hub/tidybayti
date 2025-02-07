
import 'package:get/get.dart';
import 'package:tidybayte/app/global/controller/auth_controller.dart';



class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================User section==================
   Get.lazyPut(() => AuthController(), fenix: true);




  }
}
