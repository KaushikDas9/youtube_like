import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_clone/2.Domain/Model/ImagePickerModel.dart';

class Add_Video {
  Future add(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: Get.height * .1 ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //   onTap: () {},
              //   child: ListTile(
              //     leading: const Icon(Icons.smart_display),
              //     title: Container(
              //       child: const Text("Create a Short"),
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () async{
                  await imagePickerModel().pickGallery();
                },
                child: ListTile(
                    leading: const Icon(Icons.upload),
                    title: Container(
                      child: const Text("Upload a Video"),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}



// 