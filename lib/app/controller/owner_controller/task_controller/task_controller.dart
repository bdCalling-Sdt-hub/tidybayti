import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/all_room_model.dart';
import 'package:tidybayte/app/data/model/owner_model/task_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class TaskController extends GetxController {
  ApiClient apiClient = serviceLocator();

  // DBHelper dbHelper = serviceLocator();
  final taskTitleController = TextEditingController();
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();
  final taskDetailsController = TextEditingController();
  final additionalController = TextEditingController();
  final recurrenceController = TextEditingController();
  late String assignedId = "";
  late String roomId = "";

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;

  clearField() {
    taskTitleController.clear();
    startDateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    endDateController.clear();
    taskDetailsController.clear();
    additionalController.clear();
  }

  ///==================================✅✅Add Task Method✅✅=======================

  RxBool isTaskLoading = false.obs;

  addTask() async {
    isTaskLoading.value = true;
    var body = {
      "assignedTo": assignedId,
      "roomId": roomId,
      "taskName": taskTitleController.text,
      "recurrence": recurrenceController.text,
      "startDateStr": startDateController.text,
      "startTimeStr": startTimeController.text,
      "endDateStr": endDateController.text,
      "endTimeStr": endTimeController.text,
      "taskDetails": taskDetailsController.text,
      "additionalMessage": additionalController.text
    };

    var response = await apiClient.post(body: body, url: ApiUrl.addTask);
    if (response.statusCode == 200) {
      clearField();
      toastMessage(message: response.body["message"]);
      Get.back();
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isTaskLoading.value = false;
    isTaskLoading.refresh();
  }

  var selectedDayIndex = Rxn<int>();

  ///==================================✅✅Get All Room✅✅=======================

  Rx<RoomList> roomModel = RoomList().obs;

  getAllRoom() async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response =
          await apiClient.get(url: ApiUrl.allRoom, showResult: true);

      if (response.statusCode == 200) {
        roomModel.value = RoomList.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print('Room Result==================${roomModel.value.rooms?.length}');
        setRxRequestStatus(Status.completed);
        refresh();
      } else {
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
    }
  }

  ///==================================✅✅Get All Task✅✅=======================

  Rx<TaskData> taskData = TaskData().obs;

  Future<void> getTaskData({required String apiUrl}) async {
    setRxRequestStatus(Status.loading);
    refresh();

    try {
      final response = await apiClient.get(url: apiUrl, showResult: true);

      if (response.statusCode == 200) {
        taskData.value = TaskData.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print(
            'taskData Result==================${taskData.value.result?.length}');

        setRxRequestStatus(Status.completed);
        refresh();
      } else {
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
      print('Error fetching data: $e');
    }
  }

  ///==================================✅✅Remove Task✅✅=======================
  RxBool isRemoveTask = false.obs;

  removeTask({required String taskId}) async {
    isRemoveTask.value = true;
    var body = {"taskId": taskId.toString()};

    var response = await apiClient.delete(body: body, url: ApiUrl.taskDelete);
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isRemoveTask.value = false;
    isRemoveTask.refresh();
  }

  ///==================================✅✅All Preset here✅✅=======================
  List<String> presetTitles = [
    "Check and replace air fresheners",
    "Clean ceiling fans",
    "Clean or replace air conditioning filters",
    "Clean radiators",
    "Clean the lampshades",
    "Clean walls and ceiling",
    "Declutter closets",
    "Deep clean carpets and rugs",
    "Dust and clean electronics (TV, iPad, Computer, etc.)",
    "Wash bathroom rugs",
    "Wash shower curtain",
    "Wash towels",
    "Wipe down countertop and sink",
    "Wipe down light switches and doorknobs",
    "Wipe marks and spots off mirror and faucets",
    "Wipe down mirrors",
    "Change bed sheets",
    "Dust surfaces and furniture",
    "Flush, clean and disinfect drains",
    "Mop floor",
    "Refill handwash soap",
    "Refill toilet paper",
    "Replace towels",
    "Scrub grout",
    "Sweep cobwebs",
    "Vacuum floor",
    "Clean and scrub sink",
    "Clean the air vents",
    "Clean the bathroom cabinets, drawers, and shelves",
    "Clean toothbrush holder",
    "Clean washing machine",
    "Clean window sills",
    "Clean windows",
    "Disinfect doorknobs and handles",
    "Clean and scrub bathtub",
    "Clean and scrub shower",
    "Clean, scrub and disinfect toilet",
    "Organize drawers and cabinets",
    "Clean bathroom tiles",
    "Clean bathroom vanities",
    "Clean doors",
    "Clean lighting appliance",
    "Clean showerhead",
    "Launder and air out pillows",
    "Make the bed",
    "Polish wooden furniture",
    "Rotate and flip mattress",
    "Tidy up wardrobe",
    "Vacuum mattress",
    "Vacuum pillows",
    "Wash blankets/quilts",
    "Wash blinds",
    "Pick up dog poop",
    "Refill birdfeeder",
    "Vacuum pet bedding",
    "Wash litter box",
    "Wash pet bed",
    "Wash pet blankets",
    "Wash pet bowls",
    "Wash pet toys",
    "Dust laundry area",
    "Fold dry clothes, put away",
    "Iron clothes",
    "Organize storage",
    "Wash and hang clothes",
    "Wipe down laundry appliances",
    "Clean and sweep the fireplace",
    "Clean under couch",
    "Dust stairs and landings",
    "Wash the dishes",
    "Wipe kitchen cabinets",
    "Wipe kitchen countertops and sink",
    "Wipe down refrigerator (outside)",
    "Wipe spots and marks off kitchen faucets",
    "Wipe stovetop and burners",
    "Clean and organize laundry area",
    "Clean dryer",
    "Refill dishwasher rinse aid/salt",
    "Refill paper towels",
    "Replace kitchen towels",
    "Replace water filter",
    "Wash or replace stove hood filters",
    "Wash stovetop grates",
    "Clean top of fridge",
    "Deep clean oven",
    "Deep clean stovetop",
    "Descale coffee maker",
    "Dispose of old or expired food",
    "Dust kitchen appliances",
    "Load, switch on and unload dishwasher",
    "Organize pantry and discard expired products",
    "Clean drawers and cabinets",
    "Clean freezer",
    "Clean kitchen tiles",
    "Clean microwave oven",
    "Clean oven",
    "Clean refrigerator",
    "Clean stove hood",
    "Clean the trash disposal",
    "Clean toaster and empty crumbs",
    "Clean outdoor furniture",
    "Cut the grass",
    "Fertilize plants",
    "Remove leaves",
    "Sweep porch",
    "Pressure wash pool deck",
    "Clean and polish appliance surfaces",
    "Clean coffee maker",
    "Clean dishwasher",
    "Pressure wash driveway and pathways",
    "Pressure wash house and fence",
    "Take out the trash",
    "Vacuum car",
    "Wash car",
    "Wipe down appliances",
    "Clean entrance carpet and floor",
    "Clean shoes",
    "Clean barbecue",
    "Put away toys and games",
    "Wipe down table & chairs",
    "Organize shelves",
    "Clean and dust decorative items",
    "Clean entrance doors",
    "Deep clean furniture",
    "Deep clean upholstery",
    "Launder throw blankets and cushion covers",
    "Wash carpeting and rugs",
    "Wash curtains",
    "Wash mattress pad",
    "Water plants",
    "Wipe blinds",
    "Wipe down baseboards and door frames",
    "Wipe down entertainment appliances",
    "Declutter wardrobe",
    "Place dirty clothing into the laundry"
  ];


  @override
  void onInit() {
    getAllRoom();
    super.onInit();
  }
}
