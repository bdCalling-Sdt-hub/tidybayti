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
  static const editEmployee = "$baseUrl/user/edit-employee";
  static const employeeDelete = "$baseUrl/user/delete-employee";
  static String singleEmployee(String employeeId) =>
      "$baseUrl/user/get-single-employee?userId=$employeeId";

///==================================✅✅Task✅✅=======================
  static const addTask = "$baseUrl/task/post-task";
  static const getCompleteTask = "$baseUrl/task/get-my-task?status=completed";
  static const getPendingTask = "$baseUrl/task/get-my-task?status=pending";
  static const getOngoing= "$baseUrl/task/get-my-task?status=ongoing";
  static const taskDelete= "$baseUrl/task/delete-task";
  static String taskSingle(String taskID) =>
      "$baseUrl/task/get-task?taskId=$taskID";

  static String roomTaskSingle(String roomId) =>
      "$baseUrl/task/get-all-task?room=$roomId";

///==================================✅✅Home✅✅=======================
  static const houseRomeCreate = "$baseUrl/room/post-room";
  static const myAllHouse = "$baseUrl/room/get-my-houses";
  static const allRoom = "$baseUrl/room/get-my-room";
  static String getMyRoom(String houseId) =>
      "$baseUrl/room/get-my-room?houseId=$houseId";
  static String getSingleRoom(String roomId) =>
      "$baseUrl/room/get-single-room?roomId=$roomId";
  static const houseCreate = "$baseUrl/room/post-house";

  ///==================================✅✅Budget✅✅=======================
  static const budgetCreate = "$baseUrl/wallet/post-budget";
  static const getMyBudget = "$baseUrl/wallet/get-my-budget?limit=100";
  static const getCategoryBudget = "$baseUrl/wallet/get-budget-category";
  static const upDateBudget = "$baseUrl/wallet/update-budget";
  static const deleteBudget = "$baseUrl/wallet/delete-budget";
  static const expenseCreate = "$baseUrl/wallet/post-expense";
  static String getSingleBudget(String budgetId) =>
      "$baseUrl/wallet/get-budget?budgetId=$budgetId";

}
