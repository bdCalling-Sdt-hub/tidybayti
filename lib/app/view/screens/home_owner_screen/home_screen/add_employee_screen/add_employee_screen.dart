import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddEmployeeScreen extends StatelessWidget {
  AddEmployeeScreen({super.key});

  final AddEmployeeController controller = Get.find<AddEmployeeController>();
  File? profileImage;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print("✅ Selected Image: ${profileImage!.path}");
    } else {
      print("❌ No Image Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 4),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xCCE8F3FA), // First color (with opacity)
              Color(0xFFB5D8EE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              ///==================================✅✅Add Employee Tiitle✅✅=======================
              CustomMenuAppbar(
                title: AppStrings.addEmployee.tr,
                onBack: () {
                  Get.back();
                },
              ),

              ///==================================✅✅Employee Image✅✅=======================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ClipOval(
                        //   child: SizedBox(
                        //     width: 117, // specify width
                        //     height: 117, // specify height
                        //     child: CustomImage(
                        //       imageSrc: AppImages.avatar,
                        //       imageType: ImageType.png,
                        //     ),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: CustomNetworkImage(
                              imageUrl: AppConstants.userNtr,
                              height: 117,
                              width: 117),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    ///==================================✅✅Employee Personal List✅✅=======================

                    CustomTextField(
                      hintText: AppStrings.firstName.tr,
                      fillColor: AppColors.employeeCardColor,
                      textEditingController: controller.firstNameController,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextField(
                      hintText: AppStrings.lastName.tr,
                      fillColor: AppColors.employeeCardColor,
                      textEditingController: controller.lastNameController,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),

                    ///==================================✅✅jobType✅✅=======================

                    Obx(() => CustomTextField(
                          textEditingController: controller.jobTypeController,
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            onSelected: (value) {
                              controller.updateJobType(value);
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: "Full Time",
                                child: Text("Full Time"),
                              ),
                              const PopupMenuItem(
                                value: "Part Time",
                                child: Text("Part Time"),
                              ),
                            ],
                          ),
                          hintText: controller.selectedJobType.value.isEmpty
                              ? AppStrings.jobType.tr
                              : controller.selectedJobType.value,
                          readOnly: true,
                          fillColor: AppColors.employeeCardColor,
                        )),
                    SizedBox(
                      height: 8.h,
                    ),

                    ///==================================✅✅cPR✅✅=======================

                    CustomTextField(
                      readOnly: true,
                      onTap: () {
                        controller.isCprOpen.value =
                            !controller.isCprOpen.value;
                      },
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.cPR.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Obx(() => controller.isCprOpen.value
                        ? Column(
                            children: [
                              CustomTextField(
                                textEditingController:
                                    controller.cprNumberController,
                                hintText: AppStrings.cprNumber.tr,
                                fillColor: Colors.white,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              CustomTextField(
                                textEditingController:
                                    controller.cprExpireDateController,
                                readOnly: true,
                                hintText: AppStrings.expireDate.tr,
                                fillColor: Colors.white,
                                suffixIcon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          )
                        : const SizedBox()),
                    SizedBox(
                      height: 8.h,
                    ),

                    ///==================================✅✅passport✅✅=======================

                    CustomTextField(
                      readOnly: true,
                      onTap: () {
                        controller.isPassportOpen.value =
                            !controller.isPassportOpen.value;
                      },
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.passport.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Obx(() => controller.isPassportOpen.value
                        ? Column(
                            children: [
                              CustomTextField(
                                textEditingController:
                                    controller.passportController,
                                hintText: AppStrings.passportNumber.tr,
                                fillColor: Colors.white,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              CustomTextField(
                                textEditingController:
                                    controller.passportExpireDateController,
                                readOnly: true,
                                hintText: AppStrings.expireDate.tr,
                                fillColor: Colors.white,
                                suffixIcon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          )
                        : const SizedBox()),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextField(
                      textEditingController: controller.noteController,
                      hintText: AppStrings.note.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextField(
                      textEditingController: controller.phoneNumberController,
                      hintText: AppStrings.contactNumber.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),

                    ///==================================✅✅email✅✅=======================

                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextField(
                      textEditingController: controller.emailController,
                      hintText: AppStrings.email.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),

                    ///==================================✅✅temporaryPassword✅✅=======================

                    CustomTextField(
                      textEditingController: controller.passwordController,
                      hintText: AppStrings.temporaryPassword.tr,
                      fillColor: AppColors.employeeCardColor,
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    ///==================================✅✅addNewEmployee Button✅✅=======================

                    CustomButton(
                      onTap: () {
                        addEmployee(
                            firstName: "John",
                            lastName: "Doe",
                            email: "johndoffyefguftd@email.com",
                            password: "123456",
                            profileImage: profileImage!,
                            phoneNumber: "1234567890",
                            jobType: "Developer",
                            cprNumber: "123456",
                            cprExpDate: "2025-12-31",
                            passportNumber: "AB123456",
                            passportExpDate: "2026-10-15",
                            note: "Test Employee",
                            dutyTime: "9 AM - 5 PM",
                            workingDay: [
                              "Monday",
                              "Tuesday",
                              "Wednesday",
                              "Thursday",
                              "Friday"
                            ],
                            offDay: 'Saturday');
                      },
                      fillColor: Colors.white,
                      title: AppStrings.addNewEmployee.tr,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> addEmployee(
    {required String firstName,
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
    required String offDay}) async {
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
  var token =savedToken;


  request.headers.addAll({
    "Authorization": "Bearer $token",
    "Content-Type": "multipart/form-data",
  });

  try {
    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("✅ Employee added successfully!");
      print(responseData);
    } else {
      print("❌ Failed: ${response.statusCode}");
      print("❌ Error Response: $responseData");
    }
  } catch (e) {
    print("❌ Error: $e");
  }
}
