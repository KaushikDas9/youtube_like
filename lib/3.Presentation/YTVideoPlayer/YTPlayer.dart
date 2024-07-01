import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class YTPlayer extends StatefulWidget {
  Uri url;
  String title;
  YTPlayer({required this.title ,required this.url, super.key});

  @override
  State<YTPlayer> createState() => YTtPlayerState();
}

class YTtPlayerState extends State<YTPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  Future videoPlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });

    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoInitialize: true,
        autoPlay: true,
        showOptions: false,
        showControls: true,
        allowMuting: true,
        aspectRatio: 16 / 9,
        draggableProgressBar: true,
        // materialProgressColors: ChewieProgressColors(bufferedColor: Colors.black , handleColor: Colors.white ),
        cupertinoProgressColors: ChewieProgressColors(bufferedColor: Colors.black, handleColor: Colors.white),
        optionsTranslation: OptionsTranslation(subtitlesButtonText: "subtitles", playbackSpeedButtonText: "Speed"),
        playbackSpeeds: [.5, 1, 1.5, 2]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height * .3,
            width: Get.width,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          SizedBox(),
          SizedBox(
            width: Get.width * .9,
            child: Text(widget.title),
          )
        ],
      ),
    ));
  }
}
