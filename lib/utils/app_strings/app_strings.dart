class AppStrings {
  static RegExp passRegexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.{8,}$)');
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String fieldCantBeEmpty = "Field can't be empty";
  static const String passDoesNotMatch = "Password does not match";
  static const String passwordMustHaveEightWith =
      "Password must have 8 characters With(A-z,a-z,0-9)";
  static const String enterValidEmail = "Enter a valid email";
  static const String passMustContainBoth =
      "Password must be 8 characters long & must include one capital letter";
  static const String enterAValidName = "Enter a valid name";
  static const String enterValidEamil = "Please Enter Your Email Address";


}
