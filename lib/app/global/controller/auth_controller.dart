import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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

  ///==================================✅✅Remember✅✅=======================

  RxBool isRemember = false.obs;

  toggleRemember() {
    isRemember.value = !isRemember.value;
    debugPrint("Remember me==============>>>>>>>>>$isRemember");
    refresh();
    SharePrefsHelper.setBool(AppConstants.isRememberMe, isRemember.value);
  }

  ///==================================✅✅Controller✅✅=======================

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController =
      TextEditingController(text: kDebugMode ? "lisina7524@lxheir.com" : "");
  final phoneNumberController = TextEditingController();
  final passwordController =
      TextEditingController(text: kDebugMode ? "Masum017" : "");
  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
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
        Get.toNamed(
          AppRoutes.signUpOtp,
        );
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
      "activationCode": otpController.text
    };

    var response =
        await apiClient.post(body: body, url: ApiUrl.activateAccount);
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
      emailController.clear();
      passwordController.clear();
      Map<String, dynamic> decodedToken =
      JwtDecoder.decode(response.body["data"]['accessToken']);
      print("Decoded Token:========================== $decodedToken");
      String role = decodedToken['role'];

      print('Role:============================ $role');
      SharePrefsHelper.setString(
          AppConstants.token, response.body['data']["accessToken"]);
      if (isRemember.value) {
        SharePrefsHelper.setBool(AppConstants.rememberMe, true);
        SharePrefsHelper.setBool(AppConstants.isOwner, true);
        if (role == 'USER') {
          SharePrefsHelper.setBool(AppConstants.isOwner, true);
        } else if (role == 'EMPLOYEE') {
          SharePrefsHelper.setBool(AppConstants.isOwner, false);
        }
      } else {
        SharePrefsHelper.setBool(AppConstants.rememberMe, false);
        SharePrefsHelper.setBool(AppConstants.isOwner, false);
      }
      if (role == 'USER') {
        Get.offAllNamed(AppRoutes.homeScreen);
      } else if (role == 'EMPLOYEE') {
        Get.toNamed(AppRoutes.employeeHomeScreen);
      } else {
        return null;
      }
      // debugPrint(
      //     '======================token   ${response.body['data']['accessToken']}');
      // Get.offAllNamed(AppRoutes.homeScreen);
      // if (isRemember.value) {
      //   SharePrefsHelper.setBool(AppConstants.rememberMe, true);
      //   SharePrefsHelper.setBool(AppConstants.isOwner, true);
      // } else {
      //   SharePrefsHelper.setBool(AppConstants.rememberMe, false);
      //   SharePrefsHelper.setBool(AppConstants.isOwner, false);
      // }
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      isSignInLoading.value = false;
      isSignInLoading.refresh();
      toastMessage(message: response.body["message"]);
    } else {
      SharePrefsHelper.setBool(AppConstants.rememberMe, false);
      SharePrefsHelper.setBool(AppConstants.isOwner, false);
      ApiChecker.checkApi(response);
    }
    isSignInLoading.value = false;
    isSignInLoading.refresh();
  }

  ///==================================✅✅Forget Method✅✅=======================

  RxBool isForgetLoading = false.obs;

  forgetEmail() async {
    isForgetLoading.value = true;
    var body = {"email": emailController.text};

    var response = await apiClient.post(body: body, url: ApiUrl.forgotPassword);
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

  ///==================================✅✅Resend Otp✅✅=======================

  RxBool isResendOtp = false.obs;

  resendOtp() async {
    isResendOtp.value = true;
    var body = {"email": emailController.text};

    var response = await apiClient.post(body: body, url: ApiUrl.resendOtp);
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isResendOtp.value = false;
    isResendOtp.refresh();
  }

  ///==================================✅✅Forget Otp Method✅✅=======================

  RxBool isForgetOtp = false.obs;

  forgetOtpVerify() async {
    isForgetOtp.value = true;
    var body = {"email": emailController.text, "code": otpController.text};

    var response =
        await apiClient.post(body: body, url: ApiUrl.forgetPasswordOtpVerify);
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

  ///==================================✅✅Reset password Method✅✅=======================

  RxBool isResetLoading = false.obs;

  resetPassword() async {
    isResetLoading.value = true;
    var body = {
      "email": emailController.text,
      "confirmPassword": confirmPasswordController.text,
      "newPassword": newPasswordController.text
    };

    var response = await apiClient.post(body: body, url: ApiUrl.resetPassword);
    if (response.statusCode == 200) {
      clearResetField();
      toastMessage(message: response.body["message"]);
      Get.toNamed(AppRoutes.signInScreen);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isResetLoading.value = false;
    isResetLoading.refresh();
  }

  clearResetField() {
    emailController.clear();
    otpController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
