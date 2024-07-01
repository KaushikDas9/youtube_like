import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeVideoPlayer extends StatefulWidget {
  RxString url = "".obs;
  HomeVideoPlayer({required this.url, super.key});

  @override
  State<HomeVideoPlayer> createState() => _HomeVideoPlayerState();
}

  class _HomeVideoPlayerState extends State<HomeVideoPlayer> {

    
  late VideoPlayerController _videoController;

  void videoPlayer() {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url.value))
      ..initialize().then((_) {
        setState(() {
          _videoController.play();
          _videoController.setLooping(true);
        });
      });
  }

  @override
  void initState() {
    super.initState();
    videoPlayer();
    debugPrint("Home Page${widget.url}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      height: Get.height * .4,
      width: Get.width,
      child: Column(children: [
        Container(
            height: Get.height * .3,
            width: Get.width * .9,
            child: _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: 9 / 16,
                    child: VideoPlayer(_videoController),
                  )
                : const Text("data")),
        const Text("All text")
      ]),
    ));
  }
}
