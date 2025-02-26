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
  static const getEmployeePendingTask = "$baseUrl/task/get-all-task?status=pending";
  static const getOngoing= "$baseUrl/task/get-my-task?status=ongoing";
  static const taskDelete= "$baseUrl/task/delete-task";
  static const userAllTasks= "$baseUrl/task/get-all-task";
  static String taskSingle(String taskID) =>
      "$baseUrl/task/get-task?taskId=$taskID";

  static String userDayOfTask(String dayName) =>
      "$baseUrl/task/get-all-task?dayOfWeek=$dayName";

  static String roomTaskSingle(String roomId) =>
      "$baseUrl/task/get-all-task?room=$roomId";

  // employee
  static const employeeAllTask= "$baseUrl/task/get-employee-specific-task";
  static String employeeDateAllTask(String dayName) =>
      "$baseUrl/task/get-employee-specific-task?dayOfWeek=$dayName";
  static const updateStatus= "$baseUrl/task/update-task-or-grocery-status";

///==================================✅✅Home✅✅=======================
  static const houseRomeCreate = "$baseUrl/room/post-room";
  static const myAllHouse = "$baseUrl/room/get-my-houses";
  static const allRoom = "$baseUrl/room/get-my-room";
  static const editRoom = "$baseUrl/room/edit-single-room";
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
  static const deleteExpense = "$baseUrl/wallet/delete-expense";
  static const expenseCreate = "$baseUrl/wallet/post-expense";
  static String getSingleBudget(String budgetId) =>
      "$baseUrl/wallet/get-budget?budgetId=$budgetId";


  ///==================================✅✅Manage✅✅=======================
  static const terms = "$baseUrl/manage/get-terms-conditions";
  static const privacy = "$baseUrl/manage/get-privacy-policy";
  static const getFaq = "$baseUrl/manage/get-faq";

  ///==================================✅✅Notification✅✅=======================
  static const notification = "$baseUrl/task/get-notifications";

  ///==================================✅✅Recipe✅✅=======================
  static const addRecipe = "$baseUrl/recipe/post-recipe";
  static const updateRecipe = "$baseUrl/recipe/update-recipe";
  static const myRecipe = "$baseUrl/recipe/get-my-recipe";
  static const searchRecipe = "$baseUrl/recipe/get-my-recipe?searchTerm";
  static const deleteRecipe = "$baseUrl/recipe/delete-recipe";
  static String favoriteRecipe(String recipeId) =>
      "$baseUrl/recipe/favorite-unfavorite-recipe?recipeId=$recipeId";
  static String singleRecipe(String recipeId) =>
      "$baseUrl/recipe/get-recipe?recipeId=$recipeId";



  static String tagFilter(String tagText) =>
      "$baseUrl/recipe/get-my-recipe?tags=$tagText";

}
