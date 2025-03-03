class AppStrings {
  AppStrings._();
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
  static const String passwordLengthAndContain =
      "Password must be at least 8 characters long and at least one uppercase letter, one lowercase letter, one number";


  ///=========================Start Page===================
  static const String welcome = "Welcome";
  static const String faq = "Faq";
  static const String id = "Id:";
  static const String bhd120 = "BHD 3.99 /month/year";
  static const String sixMonth = "6 Months package";
  static const String selectYourLanguage = "Select Your Language";
  static const String profile = "Profile";
  static const String name = "Name:";
  static const String note = "Note";
  static const String cprNumber = "CPR Number";
  static const String expireDate = "Expire Date";
  static const String temporaryPassword = "Temporary Password";
  static const String bhdSix = "BHD  4.99/ monthly ";
  static const String autoRenewal = "Auto-renewal";
  static const String reNewPlan = "Re-new plan";
  static const String joiningDate = "Joining date:";
  static const String buyNewPackages = "Buy new package";
  static const String alreadyHaveAnYAccount = "Already have any account?";
  static const String emailForVerification = "email for verification.";
  static const String enterSIxDegit = "Enter 6 digit verification code";
  static const String verifyCode = "Verify Code";
  static const String updatePassword = "Update password";
  static const String upDate = "Update";
  static const String owner = "Owner";
  static const String gettingStarted = "Getting Started";
  static const String employee = "Employee";
  static const String signIn = "Sign In";
  static const String signUp = "Sing Up";
  static const String bySigningUp = "By Signing up, you agree to ";
  static const String termsOfUse = "Terms of use";
  static const String and = "and";
  static const String privacyPolicy = "Privacy policy";
  static const String createAnAccountAndAccess = "Create an account and access our awesome services";


  ///============================Authentication in Home Owner===================
  static const String email = "Email";
  static const String enterPassword = "Enter Password";
  static const String forgetPassword = "Forgot Password?";
  static const String dontHaveAnyAccount = "Don’t have any account?";
  static const String firstName = "First name";
  static const String lastName = "Last name";
  static const String language = "Language";
  static const String contactNumber = "Contact number";
  static const String password = "Password";
  static const String confirmPassword = "Confirm Password";
  static const String createAccount = "Create Account";
  static const String account = "Account";
  static const String sendYourVerificationOnYour = "Send your verification on your Contact number";
  static const String sendVerificationCode = "Send Verification Code";
  static const String resendConfirmationCode = "Resend Confirmation Code";
  static const String confirm = "Confirm";
  static const String confirmTask = "Confirm task";
  static const String cost = "Cost";
  static const String left = "Left";
  static const String youHaveFiveDays = "You have  5 days free service.";
  static const String ourSubscriptionPackages = "Our Subscription packages";

  ///=====================================Premium Pacage===============
  static const String congratulationsYOuAreGiven = "Congratulations, You are given 7 days free trail. During this trail period, you are getting this facilities !";
  static const String inviteUnlimited = 'Invite unlimited home members ';
  static const String assignTasksTo = 'Assign tasks to multiple people';
  static const String masterYourCleaningSchedule = 'Master your cleaning schedule';
  static const String manageMultiplePlaces = 'Manage multiple places';
  static const String outSubscriptionPackages = 'Our Subscription packages';
  static const String premium = 'Premium';
  static const String assignTask = 'AssignTask';
  static const String premiumPro = 'Premium-Pro';
  static const String twelveMonthPackage = '12 Months package';
  static const String oneMonthsPackage = '1 Months package';
  static const String bhd3 = 'BHD 3.99/Month';
  static const String bhd4 = 'BHD 4.99/Month';
  static const String continues  = 'Continue';
  static const String congratulations  = 'Congratulations, You are given 7 days free trail. During this trail period, you are gettingthis facilities !';

  ///===============================Home Section=======================
  static const String chooseYourHouseType  = 'Choose your house type';
  static const String custom  = 'Custom';
  static const String mansion  = 'Mansion';
  static const String bungalow  = 'Bungalow';
  static const String villa  = 'Villa';
  static const String house  = 'House';
  static const String apartment  = 'Apartment';
  static const String houseInformation  = 'House Information';
  static const String houseName  = 'House name';
  static const String addNewRoom  = 'Add new room';
  static const String save  = 'Save';
  static const String totalRooms   = 'Total rooms';
  static const String seeAll   = 'See all';
  static const String employees   = 'Employees';
  static const String assignWork   = 'Assign work';
  static const String addEmployee   = 'Add employee';
  static const String employeeDetails   = 'Employee details';
  static const String taskDetails   = 'Task details';
  static const String task   = 'Task :';
  static const String assignToColon= 'Assign to:   ';
  static const String roomName= 'Room Name';
  static const String recurrenceColon= 'Recurrence: ';
  static const String date= 'Date:';
  static const String time= 'Time: ';
  static const String taskDetailsColon= 'Task details: ';
  static const String additionalMessageColon= 'Additionsal message:  ';
  static const String editEmployeeDetails   = 'Edit employee details';
  static const String employeeName   = 'Employee name';
  static const String designation   = 'Designation';
  static const String jobType   = 'Job type';
  static const String cPR   = 'CPR';
  static const String passport   = 'Passport';
  static const String passportNumber   = 'Passport Number';
  static const String employeeAddedSu   = 'Employee Added Successfully';
  static const String emplyeesAccountDetails   = 'Employees accounts details is sending to employee email :';
  static const String drivingLicense   = 'Driving license';
  static const String address   = 'Address';
  static const String confirmDelete   = 'Confirm Delete';
  static const String cancel   = 'Cancel';
  static const String delete   = 'Delete';
  static const String dutyTime   = 'Duty Time:';
  static const String workingDay   = 'Working Day:';
  static const String offDay   = 'Off day';
  static const String areYouSureYouWant   = 'Are you sure you want to delete this employee?';
  static const String selectWorkingDays   = 'Select working days';
  static const String selectOffDays   = 'Select off days';
  static const String upgradeProfile    = 'Upgrade profile';
  static const String employeeAddedSuccessfully    = 'Employee added successfully';
  static const String sendEmail    = 'Send email';
  static const String notification    = 'Notification';
  static const String mailSendSuccessfully    = 'Mail sent successfully ';
  static const String assignWorkSchedule    = 'Assign work sedule';
  static const String addNewEmployee    = 'Add new employee';
  static const String scheduleOverview    = 'Schedule overview';
  static const String backToHome    = 'Back to home';
  static const String addNewTask    = 'Add new task';
  static const String addBreakTime    = 'Add break time';
  static const String addNewRecipe    = 'Add New Recipe';
  static const String selectTags    = 'Select Tags';
  static const String finish     = 'Finish';
  static const String selectRoom     = 'Select room';
  static const String taskTitle     = 'Task title';
  static const String usePresets     = 'Use presets';
  static const String startTime     = 'Start time';
  static const String endTime     = 'End time';
  static const String details     = 'Details';
  static const String addTask     = 'Add task';
  static const String recipeDetails     = 'Recipe Details';
  static const String addBreak     = 'Add break';
  static const String assignTaskSuccessfully     = 'Assign task succesfully';


  ///============================Schedule Overview=======================
  static const String workSchedule     ='Work Schedule';
  static const String taskSchedule      ='Task Schedule';
  static const String taskScheduleDetails      ='Task schedule details';
  static const String allTasks      ='All tasks';
  static const String completedTasks      ='Completed tasks';
  static const String ongoingTask      ='Ongoing task';
  static const String pendingTask      ='Pending tasks';
  static const String groceryList       ='Grocery list';
  static const String createTask       ='Create Task';
  static const String assignTo       ='Assign to';
  static const String recurrence       ='Recurrence';
  static const String ontime       ='Ontime';
  static const String weekly       ='Weekly';
  static const String monthly       ='Monthly';
  static const String selectDate       ='Select date';
  static const String selectTime       ='Select Time';
  static const String additionalMessage       ='Additional message';
  static const String downloadPdf       ='Download PDF';
  static const String additionalTask       ='Additional Task';
  static const String doYouWantToDownload       ='Do you want to download Task details';
  static const String downloadNow       ='Download now';
  static const String grocery       ='Grocery';
  static const String addGrocery       ='Add Grocery';
  static const String pendingTasks       ='Pending tasks';
  static const String completedTask       ='Completed tasks';
  static const String addItem       ='Add item';
  static const String employeeList        ='Employee list';
  static const String selectEmployee        ='Select employee';


  ///==============================wallet=============================
  static const String wallet  ='Wallet';
  static const String budget  ='Budget';
  static const String overview  ='Overview';
  static const String ok  ='OK';
  static const String createBudgets  ='Create budgets';
  static const String keepYourBudgetsOnTrack  ='Keep your budgets on track and under control with budgets ';
  static const String selectCategory  ='Select category';
  static const String enterAmount  ='Enter amount';
  static const String budgetDetails  ='Budget details';
  static const String expenseOverview  ='Expense overview';
  static const String addExpanse  ='Add expense';
  static const String editBudget   ='Edit budget';
  static const String selectYear   ='Select year';
  static const String selectMonth   ='Select month';


  ///=============================recipe Section===================
  static const String addRecipe   ='Add recipe';
  static const String myRecipe   ='My recipe';
  static const String searchRecipe   ='Search recipe';
  static const String favoriteRecipes   ='Favorite recipes';
  static const String tags   ='Tags';
  static const String tag   ='Tags:';
  static const String ingredients   ='Ingredients:';
  static const String newBlackRecipe   ='New blank recipe';
  static const String importFromWebsite   ='Import from website';
  static const String uploadFile   ='Upload file';
  static const String recipeName   ='Recipe name';
  static const String addPhoto   ='Add photo';
  static const String urlHere    ='URL here';
  static const String cookingTime    ='Cooking time (Min)';
  static const String cookingTimes    ='Cooking time:';
  static const String description    ='Description';
  static const String addIngredients    ='Add ingredients';
  static const String describeSteps    ='Describe steps';
  static const String myRecipes    ='My recipe';
  static const String search     ='Search';
  static const String editRecipe      ='Edit recipe';

  ///==================================Menu Section======================
  static const String menu      ='Menu';
  static const String personalInformation      ='Personal Information';
  static const String upgradePackages      ='Upgrade Packages';
  static const String byeNow      ='Bye now';
  static const String myPlan      ='My plan';
  static const String settings      ='Settings';
  static const String logOut      ='Log out';
  static const String contactNo      ='Contact no:';
  static const String editProfile      ='Edit Profile';
  static const String saveAndChange      ='Save & Change';
  static const String changePassword      ='Change password';
  static const String termsOfService      ='Terms of use';
  static const String aboutUs      ='About US';
  static const String helpWhere      ='Help';
  static const String presentPassword      ='Present Password';
  static const String newPassword      ='New Password';
  //
  static const String recipe      ='Recipe';
  static const String selectYearAndMonth      ='Select Year and Month';




}
