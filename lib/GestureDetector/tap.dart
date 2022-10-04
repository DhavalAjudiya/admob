import 'dart:async';

import 'package:flutter/material.dart';

/// Main method to return runApp.

/// This is the main app stateful widget.
class SoundRecorder extends StatefulWidget {
  @override
  _SoundRecorderState createState() => _SoundRecorderState();
}

/// This is the app state.
class _SoundRecorderState extends State<SoundRecorder> {
  @override
  void initState() {
    /// Call out to intialize platform state.
    initPlatformState();
    super.initState();
  }

  /// Initialize platform state.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  /// Widget build method to return MaterailApp.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GestureDetector'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center(
              //   child: GestureDetector(
              //     onTapUp: (TapUpDetails tapUpDetails) {
              //       print('GestureDetector----:onTapUp');
              //     },
              //
              //     onTapDown: (TapDownDetails tapDownDetails) {
              //       print('GestureDetector----:onTapDown');
              //     },
              //     onSecondaryTap: () {
              //       print('GestureDetector----:onSecondaryTap');
              //     },
              //
              //     onVerticalDragDown: (DragDownDetails dragDownDetails) {
              //       print('GestureDetector----:onVerticalDragDown');
              //     },
              //
              //     onForcePressStart: (ForcePressDetails forcePressDetails) {
              //       print('GestureDetector----:onForcePressStart');
              //     },
              //     onForcePressPeak: (ForcePressDetails forcePressDetails) {
              //       print('GestureDetector----:onForcePressPeak');
              //     },
              //
              //     onPanStart: (DragStartDetails dragStartDetails) {
              //       print('GestureDetector----:onPanStart');
              //     },
              //     onPanUpdate: (DragUpdateDetails dragUpdateDetails) {
              //       print('GestureDetector----:onPanUpdate');
              //     },
              //
              //     onScaleStart: (ScaleStartDetails scaleStartDetails) {
              //       print('GestureDetector----:onScaleStart');
              //     },
              //     onScaleUpdate: (ScaleUpdateDetails scaleUpdateDetails) {
              //       print('GestureDetector----:onScaleUpdate');
              //     },
              //     child: const Text(
              //       'onSecondaryTap',
              //       style: TextStyle(
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
              // Center(
              //   child: FloatingButton(
              //     child: const Text(
              //       'InkWell',
              //       style: TextStyle(
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dispose method to close out and cleanup objects.
  @override
  void dispose() {
    super.dispose();
  }
}
