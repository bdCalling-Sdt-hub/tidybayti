import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:tidybayte/app/controller/owner_controller/home_controller/home_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:http/http.dart'as http;
import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class HouseAdd{
  ///==================================✅✅House Room Create✅✅=======================

  static Future<void> houseRoomAdd({
    required BuildContext context,
    required String houseName,
    required String roomName,
    required File roomImage,

  }) async {
    HomeController homeController = Get.find();
    homeController.setLoading(true);

    var url = Uri.parse(ApiUrl.houseRomeCreate);

    var request = http.MultipartRequest("POST", url);

    request.fields["houseName"] = houseName;
    request.fields["roomName"] = roomName;


    request.files.add(await http.MultipartFile.fromPath(
      "roomImage",
      roomImage.path,
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

      homeController
          .setLoading(false);

      if (response.statusCode == 200) {

        toastMessage(message: "✅ Room created successfully");
        print("✅ Room created successfully");
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
      homeController.setLoading(false);
      toastMessage(
          message: "❌ An error occurred. Please check your connection.");
      print("❌ Error: $e");
    }
  }


}