import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/2.Domain/Model/ImagePickerModel.dart';
import 'package:get_storage/get_storage.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final rememberProfilePhoto = GetStorage();
  var profilePhoto = "".obs;

  _updateProfilePhoto(String path) {
    profilePhoto.value = path;
    rememberProfilePhoto.write("profilephoto", path);
  }

  @override
  void initState() {
    super.initState();
    profilePhoto.value = rememberProfilePhoto.read("profilephoto") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(children: [
          Positioned(
              bottom: Get.height * .55,
              left: Get.width * .37,
              child: Column(
                children: [
                  Obx(() => ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: Get.height * .15,
                          width: Get.width * .31,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(100)),
                          child: profilePhoto.isEmpty
                              ? Icon(Icons.person)
                              : Image.file(
                                  File(profilePhoto.value),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      )),
                  
                  
                  const Text("Kaushik Das" , style: TextStyle(fontSize: 18),)
                ],
              )),
          Positioned(
              left: Get.width * .58,
              height: Get.height * .4,
              child: IconButton(
                  onPressed: () {
                    Get.dialog(AlertDialog(
                      actions: [
                        //Gallery Taking
                        InkWell(
                          onTap: () async {
                            profilePhoto.value = await imagePickerModel()
                                .PickImageProfileFromGallery() ;
                            _updateProfilePhoto(profilePhoto.value);
                            Get.back();
                          },
                          child: const ListTile(
                              leading: Icon(Icons.file_present_outlined),
                              title: Text("Take from Gallery")),
                        ),
                        //Camera Taking
                        InkWell(
                          onTap: () async {
                            profilePhoto.value = await imagePickerModel()
                                .PickImageProfileFromCamera();
                            _updateProfilePhoto(profilePhoto.value);
                            Get.back();
                          },
                          child: const ListTile(
                              leading: Icon(Icons.camera_alt_outlined),
                              title: Text("Take From Camera")),
                        )
                      ],
                    ));
                  },
                  icon: Icon(size: Get.height * .04, Icons.edit))),
        ]),
      ),
    );
  }
}
