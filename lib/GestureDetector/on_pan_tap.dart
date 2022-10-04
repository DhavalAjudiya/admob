import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:testadmob/GestureDetector/on_force_start.dart';
import 'package:testadmob/GestureDetector/tap.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: swip(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _width = 300;
  final double _height = 200;

  @override
  Widget build(BuildContext context) {
    final m = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: m.size.height,
          width: m.size.width,
          child: InteractiveViewer(
            maxScale: 30,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(height: _height, width: _width, color: Colors.red),
                Positioned(
                  bottom: _height + 300,
                  // top: _height / 2 - 10,
                  left: _width - 20,
                  child: GestureDetector(
                    onPanStart: (details) {
                      print("PAN STARTED");
                    },
                    onPanUpdate: (details) {
                      final delta = details.delta;
                      setState(() {
                        _width = _width + delta.dx;
                      });
                      print("PAN onPanUpdate");
                    },
                    child: Container(height: 20, width: 20, color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
