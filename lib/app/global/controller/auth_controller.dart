
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/local_db/local_db.dart';
import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class AuthController extends GetxController {
  ApiClient apiClient = serviceLocator();
  DBHelper dbHelper = serviceLocator();

 final firstNameController = TextEditingController();
 final lastNameController = TextEditingController();
 final emailController = TextEditingController();
 final phoneNumberController = TextEditingController();
 final passwordController = TextEditingController();
 final confirmPasswordController = TextEditingController();

  ///==================================✅✅SignUp Method✅✅=======================

  RxBool signUpLoading = false.obs;

  signup() async {
    signUpLoading.value = true;
    var body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "phoneNumber": phoneNumberController.text,
      "password": passwordController.text,
      "confirmPassword": confirmPasswordController.text,
      "role": "USER"
    };

    var response = await apiClient.post(body: body, url: ApiUrl.register);
    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.signUpOtp);
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      Get.toNamed(AppRoutes.signUpOtp);
      toastMessage(message: response.body["message"]);
    }
    else {
      ApiChecker.checkApi(response);
    }
    signUpLoading.value = false;
    signUpLoading.refresh();
  }

  ///==================================✅✅Sign In Method✅✅=======================

  RxBool isSignInLoading = false.obs;

  signIn() async {
    isSignInLoading.value = true;
    var body = {
      "email": emailController.text,
      "password":passwordController.text
    };

    var response = await apiClient.post(body: body, url: ApiUrl.login);
    if (response.statusCode == 200) {
      SharePrefsHelper.setString(
          AppConstants.token, response.body['data']["accessToken"]);
      debugPrint(
          '======================token   ${response.body['data']['accessToken']}');
      Get.toNamed(AppRoutes.homeScreen);
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    }
    else {
      ApiChecker.checkApi(response);
    }
    isSignInLoading.value = false;
    isSignInLoading.refresh();
  }


}
