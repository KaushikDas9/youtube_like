import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/1.Data/FileStroage/GetVideo.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:youtube_clone/3.Presentation/YTVideoPlayer/YTPlayer.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = GetStorage();
  Rx profilePhoto = "".obs;
  RxList url = [].obs;
  RxList thumbnails = [].obs;
  RxList video_title = [].obs;

  Future video() async {
    url.addAll(await GetVideo().GetAllVideo());
    video_title.addAll(await GetVideo().GetAllVideoTitle());

    await thumbnail();
    setState(() {});
    debugPrint("Again Home ${url[0]}");
  }

  Future thumbnail() async {
    for (int i = 0; i < url.length; i++) {
      final fileName = await VideoThumbnail.thumbnailData(
        video: url[i],
        imageFormat: ImageFormat.JPEG,
        maxHeight: Get.height ~/ 4,
        maxWidth: Get.width.toInt(),
        quality: 75,
      );

      thumbnails.add(fileName);
    }
  }

  @override
  void initState() {
    video();
    super.initState();
     profilePhoto.value = box.read("profilephoto") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: url.isEmpty ? 3 : url.length,
        itemBuilder: (context, index) {
          return Obx(() => thumbnails.isEmpty
              ? SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: const Center(child: CircularProgressIndicator()),
                )
              : SizedBox(
                  height: Get.height * .4,
                  width: Get.width,
                  child: Column(children: [
                    InkWell(
                      onTap: () {
                        Get.to(YTPlayer(title: video_title[index].toString() ,url: Uri.parse(url[index])));
                      },
                      child: SizedBox(
                        height: Get.height * .3,
                        width: Get.width * .95,
                        child: thumbnails.length > index
                            ? Image.memory(thumbnails[index] , fit: BoxFit.cover,)
                            : const Center(
                                child: SizedBox(
                                    child: CircularProgressIndicator())),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all( Get.width * .02),
                      child: Row(children: [
                        ClipRRect(borderRadius: BorderRadius.circular(50),child: CircleAvatar(backgroundColor: Colors.white ,child:profilePhoto.value=="" ?const Icon(Icons.person)  : Image.file(File(profilePhoto.value),fit: BoxFit.cover, ))),
                        SizedBox(width: Get.width * .04, ),
                        SizedBox(
                            width: Get.width * .8,
                            height: Get.height * .03,
                            child: Text(
                              video_title[index].toString(),
                              overflow: TextOverflow.ellipsis,
                            ))
                      ]),
                    )
                  ]),
                ));
        },
      ),
    );
  }
}
