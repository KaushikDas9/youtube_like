// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/3.Presentation/VideoPreview/longVideoPreview.dart';

// ignore: camel_case_types
class imagePickerModel {
  Future pickGallery() async {
    await ImagePicker().pickVideo(source: ImageSource.gallery).then((value) {
      if (value != null) {
        print(value.toString());
        Get.to(videoPreviewPage(
          videoFile: File(value.path),
          videoPath: value.path,
        ));
      } else {
        print("Error in pickGallery");
      }
    });
  }

  Future PickImageProfileFromGallery() async {
    try {
      final xfile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (xfile != null) {
        debugPrint(File(xfile.path).path);
        return File(xfile.path).path;
      } else {
        debugPrint(
            " error in PickImage().PickImageProfileFromGallery : xfile is null");
      }
    } on PlatformException catch (e) {
      Get.snackbar("Error", e.message.toString());
    }
  }

  Future PickImageProfileFromCamera() async {
    try {
      final xfile = await ImagePicker().pickImage(
          source: ImageSource.camera );
      if (xfile != null) {
        return File(xfile.path).path;
      }
    } on PlatformException catch (e) {
      Get.snackbar("Error", e.message.toString());
    }
  }
}
