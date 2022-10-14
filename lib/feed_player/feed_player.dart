import 'package:flutter/material.dart';
import 'package:testadmob/feed_player/mock_data.dart';
import 'package:testadmob/feed_player/multi_manager/flick_multi_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import './multi_manager/flick_multi_manager.dart';

class FeedPlayer extends StatefulWidget {
  FeedPlayer({Key? key}) : super(key: key);

  @override
  _FeedPlayerState createState() => _FeedPlayerState();
}

class _FeedPlayerState extends State<FeedPlayer> {
  List items = mockData['items'];

  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: VisibilityDetector(
          key: ObjectKey(flickMultiManager),
          onVisibilityChanged: (visibility) {
            if (visibility.visibleFraction == 0 && mounted) {
              print("visibility.visibleFraction-----0-${visibility.visibleFraction}");
              flickMultiManager.pause();
            }
          },
          child: ListView.separated(
            separatorBuilder: (context, int) => Container(
              height: 20,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FlickMultiPlayer(
                      url: items[index]['trailer_url'],
                      flickMultiManager: flickMultiManager,
                      image: items[index]['image'],
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
