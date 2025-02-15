import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class AddEmployee {
  ///==================================✅✅Add Employee✅✅=======================

  static Future<void> addEmployee({
    required BuildContext context,  // Add this line
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required File profileImage,
    required String phoneNumber,
    required String jobType,
    required String cprNumber,
    required String cprExpDate,
    required String passportNumber,
    required String passportExpDate,
    required String note,
    required String dutyTime,
    required List workingDay,
    required String offDay,
  }) async {
    AddEmployeeController employeeController = Get.find();
    employeeController.setLoading(true);

    var url = Uri.parse(ApiUrl.addEmployee);

    var request = http.MultipartRequest("POST", url);

    request.fields["firstName"] = firstName;
    request.fields["lastName"] = lastName;
    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["phoneNumber"] = phoneNumber;
    request.fields["jobType"] = jobType;
    request.fields["CPRNumber"] = cprNumber;
    request.fields["CPRExpDate"] = cprExpDate;
    request.fields["passportNumber"] = passportNumber;
    request.fields["passportExpDate"] = passportExpDate;
    request.fields["note"] = note;
    request.fields["dutyTime"] = dutyTime;
    request.fields["workingDay"] = jsonEncode(workingDay);
    request.fields["offDay"] = offDay;

    request.files.add(await http.MultipartFile.fromPath(
      "profile_image",
      profileImage.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    String? savedToken = await SharePrefsHelper.getString(AppConstants.token);
    var token = savedToken;

    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
    });

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      employeeController.setLoading(false); // Set loading to false after request

      if (response.statusCode == 200) {
          employeeController.addEmployeeFieldClear();
          employeeController.sendEmail(context);
          toastMessage(message: "✅ Employee added successfully!");
        print("✅ Employee added successfully!");
        print(responseData);
      } else {
        print("❌ Failed: ${response.statusCode}");
        print("❌ Error Response: $responseData");

        String errorMessage = "Something went wrong!";
        try {
          var decodedData = json.decode(responseData);
          if (decodedData["message"] != null) {
            errorMessage = decodedData["message"];
          }
        } catch (e) {
          print("❌ JSON Parsing Error: $e");
        }

        toastMessage(message: "❌ $errorMessage");
      }
    } catch (e) {
      employeeController.setLoading(false);
      toastMessage(message: "❌ An error occurred. Please check your connection.");
      print("❌ Error: $e");
    }
  }

///==================================✅✅Edit Employee✅✅=======================

  static Future<void> editEmployee({
    required BuildContext context,  // Add this line
    required String firstName,
    required String lastName,
    required File profileImage,
    required String phoneNumber,
    required String jobType,
    required String cprNumber,
    required String cprExpDate,
    required String passportNumber,
    required String passportExpDate,
    required String note,
    required String dutyTime,
    required List workingDay,
    required String offDay,
    required String authId,
    required String userId
  }) async {
    AddEmployeeController employeeController = Get.find();
    employeeController.editLoading(true);

    var url = Uri.parse(ApiUrl.editEmployee);

    var request = http.MultipartRequest("PATCH", url);

    request.fields["firstName"] = firstName;
    request.fields["lastName"] = lastName;
    request.fields["phoneNumber"] = phoneNumber;
    request.fields["jobType"] = jobType;
    request.fields["CPRNumber"] = cprNumber;
    request.fields["CPRExpDate"] = cprExpDate;
    request.fields["passportNumber"] = passportNumber;
    request.fields["passportExpDate"] = passportExpDate;
    request.fields["note"] = note;
    request.fields["dutyTime"] = dutyTime;
    request.fields["workingDay"] = jsonEncode(workingDay);
    request.fields["offDay"] = offDay;
    request.fields["authId"] = authId;
    request.fields["userId"] = userId;

    request.files.add(await http.MultipartFile.fromPath(
      "profile_image",
      profileImage.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    String? savedToken = await SharePrefsHelper.getString(AppConstants.token);
    var token = savedToken;

    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
    });

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      employeeController.editLoading(false); // Set loading to false after request

      if (response.statusCode == 200) {
        Get.back();
        employeeController.getEmployee();
        toastMessage(message: "✅ Employee updated successfully!");
        print("✅ Employee updated successfully!");
        print(responseData);
      } else {
        print("❌ Failed: ${response.statusCode}");
        print("❌ Error Response: $responseData");

        String errorMessage = "Something went wrong!";
        try {
          var decodedData = json.decode(responseData);
          if (decodedData["message"] != null) {
            errorMessage = decodedData["message"];
          }
        } catch (e) {
          print("❌ JSON Parsing Error: $e");
        }

        toastMessage(message: "❌ $errorMessage");
      }
    } catch (e) {
      employeeController.editLoading(false);
      toastMessage(message: "❌ An error occurred. Please check your connection.");
      print("❌ Error: $e");
    }
  }

}
