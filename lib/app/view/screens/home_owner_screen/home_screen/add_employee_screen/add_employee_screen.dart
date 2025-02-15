
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
import 'dart:io';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
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
                child: Obx(
                 () {
                    return ListView(
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
                                    textEditingController: controller.cprExpireDateController,
                                    readOnly: true,
                                    hintText: AppStrings.expireDate.tr,
                                    fillColor: Colors.white,
                                    suffixIcon: const Icon(Icons.calendar_month),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );

                                      if (pickedDate != null) {
                                        String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                                        controller.cprExpireDateController.text = formattedDate;
                                      }
                                    },
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
                                    textEditingController: controller.passportExpireDateController,
                                    readOnly: true,
                                    hintText: AppStrings.expireDate.tr,
                                    fillColor: Colors.white,
                                    suffixIcon: const Icon(Icons.calendar_month),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );

                                      if (pickedDate != null) {
                                        String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                                        controller.passportExpireDateController.text = formattedDate;
                                      }
                                    },
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
                      controller.isLoading.value?CustomLoader():
                        CustomButton(
                          onTap: () {
                            if (profileImage == null) {
                              print("❌ Please select a profile image.");
                              return;
                            }

                            AddEmployee.addEmployee(
                              firstName: controller.firstNameController.text.trim(),
                              lastName: controller.lastNameController.text.trim(),
                              email: controller.emailController.text.trim(),
                              password: controller.passwordController.text.trim(),
                              profileImage: profileImage!,
                              phoneNumber: controller.phoneNumberController.text.trim(),
                              jobType: controller.selectedJobType.value,
                              cprNumber: controller.cprNumberController.text.trim(),
                              cprExpDate: controller.cprExpireDateController.text.trim(),
                              passportNumber: controller.passportController.text.trim(),
                              passportExpDate: controller.passportExpireDateController.text.trim(),
                              note: controller.noteController.text.trim(),
                              dutyTime: "9 AM - 5 PM",
                              workingDay: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
                              offDay: "Saturday",
                            );
                          },
                          fillColor: Colors.white,
                          title: AppStrings.addNewEmployee.tr,
                        )

                      ],
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

