import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare_admin/data/response/status.dart';
import 'package:medicare_admin/models/doctor_model/doctor_model.dart';
import 'package:medicare_admin/res/app_url/app_url.dart';
import 'package:medicare_admin/res/repository/doctor_repository.dart';
import 'package:http/http.dart' as http;

class DoctorViewModel extends GetxController {
  final _repo = DoctorRepository();
  Rx<Status> reqStatusResponse = Status.completed.obs;

  final userNameController = TextEditingController().obs;
  final qualificationController = TextEditingController().obs;
  final workingHourController = TextEditingController().obs;
  final feesController = TextEditingController().obs;
  RxList<DoctorModel> allDoctorsList = <DoctorModel>[].obs;
  RxString specialization = ''.obs;
  Rx<File> selectedImage = File('').obs;

  void setReqStatusResponse(Status status) {
    reqStatusResponse.value = status;
  }

  void addDoctorData() async {
    setReqStatusResponse(Status.loading);

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(AppUrl.addDoctor));

    // Add the image file to the request
    var pic =
        await http.MultipartFile.fromPath('image', selectedImage.value.path);
    request.files.add(pic);

    // Add other form data to the request
    request.fields['name'] = userNameController.value.text;
    request.fields['qualification'] = qualificationController.value.text;
    request.fields['workingHours'] = workingHourController.value.text;
    request.fields['fees'] = feesController.value.text;
    request.fields['specialization'] = specialization.value;

    // Send the request
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 200) {
      setReqStatusResponse(Status.completed);
      getAllDoctor();
      Get.back();
      userNameController.value.clear();
      qualificationController.value.clear();
      workingHourController.value.clear();
      feesController.value.clear();
    } else {
      setReqStatusResponse(Status.error);
      print('Failed to add doctor: ${response.reasonPhrase}');
    }
  }

  void getAllDoctor() async {
    await _repo.getAllDoctorData().then((value) {
      for (var element in value['doctors']) {
        allDoctorsList.add(DoctorModel.fromJson(element));
      }
    }).onError((error, stackTrace) {
      setReqStatusResponse(Status.error);

      print(error);
    });
  }
}