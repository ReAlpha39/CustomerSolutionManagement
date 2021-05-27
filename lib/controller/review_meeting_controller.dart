import 'dart:io';

import 'package:customer/models/review_meeting.dart';
import 'package:customer/models/type.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ReviewMeetingController extends GetxController {
  PanelController? panelController;
  final dateFormat = DateFormat('EEE, MMMM dd yyyy');
  final _picker = ImagePicker();
  final List<String> reviewMeetingTypes = [
    typeValues.reverse[ReviewMeetingType.Monthly]!,
    typeValues.reverse[ReviewMeetingType.Weekly]!
  ];
  GlobalKey<FormState>? formKey;
  TextEditingController? titleTextController;
  TextEditingController? dateTextController;
  TextEditingController? agendaTextController;
  TextEditingController? noteTextController;
  RxString dateMeeting = "".obs;
  RxString tempImagePath = "".obs;
  RxString savedImagePath = "".obs;
  Rx<File> image = File("").obs;
  RxBool isPicked = false.obs;
  RxBool isUpdate = false.obs;
  RxInt radioIndex = 0.obs;

  @override
  void onInit() {
    panelController = PanelController();
    formKey = GlobalKey<FormState>();
    titleTextController = TextEditingController();
    dateTextController = TextEditingController();
    agendaTextController = TextEditingController();
    noteTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    titleTextController?.dispose();
    dateTextController?.dispose();
    agendaTextController?.dispose();
    noteTextController?.dispose();
    super.onClose();
  }

  void onClosePanel() {
    resetPanel();
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
  }

  void resetPanel() {
    try {
      tempImagePath.value = "";
      titleTextController!.clear();
      dateTextController!.clear();
      noteTextController!.clear();
      agendaTextController!.clear();
      isPicked.value = false;
      if (image.value.existsSync()) {
        image.value.delete();
        image.refresh();
      }
    } catch (e) {
      print(e);
    }
  }

  Future imageFromCamera() async {
    isPicked.value = false;
    var file = await _picker.getImage(source: ImageSource.camera);
    if (file != null) {
      image = Rx<File>(File(file.path));
      image.refresh();
      isPicked.value = true;
    } else {
      print('No image selected');
    }
  }

  Future imageFromGallery() async {
    isPicked.value = false;
    var file =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (file != null) {
      image = Rx<File>(File(file.path));
      image.refresh();
      isPicked.value = true;
    } else {
      print('No image selected');
    }
  }

  void saveData() {
    if (formKey!.currentState!.validate()) {
      ReviewMeeting data = ReviewMeeting(
        tanggal: dateTextController!.text,
        nama: titleTextController!.text,
        agenda: agendaTextController!.text,
        note: noteTextController!.text,
        type: reviewMeetingTypes[radioIndex.value],
        picture: savedImagePath.value,
      );
    }
  }

  void closeCurrentDialog() {
    if (Get.isDialogOpen!) {
      Navigator.of(Get.overlayContext!).pop();
    }
  }

  showDialog({required String title, required String middleText}) {
    closeCurrentDialog();
    Get.defaultDialog(
        barrierDismissible: false,
        titleStyle: TextStyle(fontSize: 24),
        middleTextStyle: TextStyle(fontSize: 18),
        title: title,
        middleText: middleText,
        textConfirm: 'OK',
        radius: 17,
        buttonColor: Colors.yellow.shade600,
        confirmTextColor: Colors.black87,
        onConfirm: () {
          panelController!.close();
          Navigator.of(Get.overlayContext!).pop();
          resetPanel();
        });
  }
}
