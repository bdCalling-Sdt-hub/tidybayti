import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/data/model/owner_model/notification/notification.dart';

class NotificationController extends GetxController {
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;
  ApiClient apiClient = serviceLocator();

  /// **✅ Fixed Model Handling**
  RxList<NotificationData> notificationList = <NotificationData>[].obs;

  Future<void> getNotification() async {
    setRxRequestStatus(Status.loading);
    refresh();

    try {
      final response = await apiClient.get(url: ApiUrl.notification, showResult: true);

      if (response.statusCode == 200 && response.body != null) {
        var responseData = response.body["data"];

        if (responseData != null) {

          notificationList.assignAll(
            List<NotificationData>.from(
                responseData.map((x) => NotificationData.fromJson(x))
            ),
          );

          print('✅ Success: Status Code = ${response.statusCode}');
          print('📄 Total notifications=============== ${notificationList.length}');
          setRxRequestStatus(Status.completed);
        } else {
          print("⚠️ Warning: Response data is null");
          setRxRequestStatus(Status.error);
        }
      } else {
        print("❌ Error: Unexpected Status Code = ${response.statusCode}");
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print("❗ Exception: $e");
      setRxRequestStatus(Status.error);
    } finally {
      refresh();
    }
  }


  @override
  void onInit() {
    getNotification();
    super.onInit();
  }
}
