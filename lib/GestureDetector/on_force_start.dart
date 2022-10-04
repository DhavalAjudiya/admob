import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

class swip extends StatefulWidget {
  @override
  _swipState createState() => new _swipState();
}

class _swipState extends State<swip> {
  String _swipeDirection = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: SwipeDetector(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 80.0,
                        bottom: 80.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Swipe Me!',
                            style: TextStyle(
                              fontSize: 40.0,
                            ),
                          ),
                          Text(
                            _swipeDirection,
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onSwipeUp: () {
                    print("asdadasadadasdasdasdasdasdasdasd");
                    setState(() {
                      _swipeDirection = "Swipe Up";
                    });
                  },
                  onSwipeDown: () {
                    print("asdadasadadasdasdasdasdasdasdasd");

                    setState(() {
                      _swipeDirection = "Swipe Down";
                    });
                  },
                  onSwipeLeft: () {
                    print("asdadasadadasdasdasdasdasdasdasd");

                    setState(() {
                      _swipeDirection = "Swipe Left";
                    });
                  },
                  onSwipeRight: () {
                    print("asdadasadadasdasdasdasdasdasdasd");

                    setState(() {
                      _swipeDirection = "Swipe Right";
                    });
                  },
                  swipeConfiguration: SwipeConfiguration(
                      verticalSwipeMinVelocity: 100.0,
                      verticalSwipeMinDisplacement: 50.0,
                      verticalSwipeMaxWidthThreshold: 100.0,
                      horizontalSwipeMaxHeightThreshold: 50.0,
                      horizontalSwipeMinDisplacement: 50.0,
                      horizontalSwipeMinVelocity: 200.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
