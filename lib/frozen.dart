import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedDemo extends StatefulWidget {
  const FrostedDemo({Key? key}) : super(key: key);

  @override
  State<FrostedDemo> createState() => _FrostedDemoState();
}

class _FrostedDemoState extends State<FrostedDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: const FlutterLogo()),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)),
                  child: Center(
                    child: Text('Frosted',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
