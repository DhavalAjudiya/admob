import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testadmob/viedo_player/videoPlayer_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerDemo extends StatelessWidget {
  VideoPlayerDemo({Key? key}) : super(key: key);
  final videoPlayerCon = Get.put(VideoPlayerControllerDemo());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: videoPlayerCon.videoController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: videoPlayerCon.videoController.value.aspectRatio,
                      child: VideoPlayer(
                        videoPlayerCon.videoController,
                      ),
                    )
                  : Container(
                      color: Colors.red,
                      height: 250,
                      width: 300,
                    ),
            );
          },
        ),
      ),
    );
  }
}
