class ApiUrl {

  static const baseUrl = "http://10.0.60.26:8002";
  static const networkUrl = "http://10.0.60.26:8002/";

  ///<======================= For Auth part ====================>
  static const register = "$baseUrl/auth/register";
  static const activateAccount = "$baseUrl/auth/activate-account";
  static const login = "$baseUrl/auth/login";
  static const forgotPassword = "$baseUrl/auth/forgot-password";
  static const forgetPasswordOtpVerify = "$baseUrl/auth/forget-pass-otp-verify";
  static const resetPassword = "$baseUrl/auth/reset-password";

  ///==================================✅✅Owner Profile✅✅=======================
  static const getOwnerProfile = "$baseUrl/user/profile";
  static const updateProfile = "$baseUrl/user/edit-profile";
  static const changePassword = "$baseUrl/auth/change-password";

  ///==================================✅✅Add Employee✅✅=======================
  static const addEmployee = "$baseUrl/user/add-employee";
  static const getEmployee = "$baseUrl/user/get-my-employee";

}
