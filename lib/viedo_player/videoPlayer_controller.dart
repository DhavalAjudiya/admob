import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControllerDemo extends GetxController {
  late VideoPlayerController videoController;
  @override
  void onInit() async {
    print("call onInit");
    videoController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        videoController.play();
        // videoController.setVolume(15);
        // videoController.setLooping(true);
        // update();
      });
    super.onInit();
  }
}
