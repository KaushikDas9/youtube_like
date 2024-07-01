import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/1.Data/FileStroage/VideoStorage.dart';

class videoPreviewPage extends StatefulWidget {
  File? videoFile;
  String videoPath;
  videoPreviewPage(
      {required this.videoFile, required this.videoPath, super.key});

  @override
  State<videoPreviewPage> createState() => _videoPreviewPageState();
}

class _videoPreviewPageState extends State<videoPreviewPage> {
  
  late VideoPlayerController _videoController;
  var uploadProcess = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  bool onTapPlaypause = false;

  void videoPlayer() {
    if (widget.videoFile != null) {
      _videoController = VideoPlayerController.file(widget.videoFile!)
        ..initialize().then((_) {
          setState(() {
            _videoController.play();
            _videoController.setLooping(true);
          });
        });
    }
  }

  @override
  void initState() {
    super.initState();
    videoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  onTapPlaypause
                      ? _videoController.play()
                      : _videoController.pause();
                  onTapPlaypause = !onTapPlaypause;
                },
                onLongPress: () {
                  _videoController.setPlaybackSpeed(2.0);
                },
                onLongPressEnd: (_) => _videoController.setPlaybackSpeed(1.0),
                child: Container(
                  width: Get.width, height: Get.height * .65,
                  color: Colors.amber,

                  //  video player

                  child: _videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: 16.0 / 9.0,
                          child: VideoPlayer(_videoController),
                        )
                      : const Center(
                          child: Text("Please select a correct file")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * .05,
                    right: Get.width * .05,
                    top: Get.width * .02),
                child: TextField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.title), hintText: "Enter a title"),
                  controller: titleController,
                  onEditingComplete: () =>
                      print(titleController.text.toString()),
                  maxLength: 500,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                child: SizedBox(
                    height: Get.height * .1,
                    child: TextField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.description),
                          hintText: "Enter a Caption"),
                      controller: captionController,
                      onEditingComplete: () =>
                          print(captionController.text.toString()),
                      maxLines: 1,
                      maxLength: 150,
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(
                    right: Get.width * .04,
                    left: Get.width * .04,
                    top: Get.width * .035,
                  ),
                  width: Get.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.close_rounded)),
                       Obx(() =>   ElevatedButton(
                            onPressed: () async {

                                  uploadProcess.value = true;
                                  await VideoStorage().uploadFileAtSupabase(
                                  file: widget.videoFile!,
                                  path: widget.videoPath,
                                  title: titleController.text );
                              
                            },
                            child: uploadProcess.value
                                ? const SizedBox(
                                    height: 20,
                                    width:  20,
                                    child:  CircularProgressIndicator())
                                : const Text("Upload")))
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
