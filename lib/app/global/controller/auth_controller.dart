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
  final otpController = TextEditingController();

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
      String errorMessage = response.body["message"];

      if (errorMessage.contains("Account active. Please Login")) {
        toastMessage(message: errorMessage);
        Get.toNamed(AppRoutes.signInScreen);
      } else if (errorMessage
          .contains("Already have an account. Please activate")) {
        toastMessage(message: errorMessage);
        Get.toNamed(AppRoutes.signUpOtp,);
      } else {
        toastMessage(message: errorMessage);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    signUpLoading.value = false;
    signUpLoading.refresh();
  }

  ///==================================✅✅SignUp OTp✅✅=======================

  RxBool isSignUpOtp = false.obs;

  signUpOtp() async {
    isSignUpOtp.value = true;
    var body = {
      "email": emailController.text,
      "activationCode":otpController.text
    };

    var response = await apiClient.post(body: body, url: ApiUrl.activateAccount);
    if (response.statusCode == 201) {
      SharePrefsHelper.setString(
          AppConstants.token, response.body['data']["accessToken"]);
      Get.offAllNamed(AppRoutes.freeServiceScreen);
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isSignUpOtp.value = false;
    isSignUpOtp.refresh();
  }

  ///==================================✅✅Sign In Method✅✅=======================

  RxBool isSignInLoading = false.obs;

  signIn() async {
    isSignInLoading.value = true;
    var body = {
      "email": emailController.text,
      "password": passwordController.text
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
    } else {
      ApiChecker.checkApi(response);
    }
    isSignInLoading.value = false;
    isSignInLoading.refresh();
  }

  ///==================================✅✅Forget Method✅✅=======================

  RxBool isForgetLoading = false.obs;

  forgetEmail() async {
    isForgetLoading.value = true;
    var body = {
      "email": emailController.text
    };

    var response = await apiClient.post(body: body,
        url: ApiUrl.forgotPassword);
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]);
      Get.toNamed(AppRoutes.forgotPasswordOtp);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isForgetLoading.value = false;
    isForgetLoading.refresh();
  }

  ///==================================✅✅Forget Otp Method✅✅=======================

  RxBool isForgetOtp = false.obs;

  forgetOtpVerify() async {
    isForgetOtp.value = true;
    var body ={
      "email": emailController.text,
      "code": otpController.text
    };

    var response = await apiClient.post(body: body,
        url: ApiUrl.forgetPasswordOtpVerify);
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]);
      Get.toNamed(AppRoutes.resetPasswordScreen);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isForgetOtp.value = false;
    isForgetOtp.refresh();
  }
}
