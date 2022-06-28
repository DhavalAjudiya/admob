import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testadmob/images/bottombar/bottomnavigation.dart';

class Splsh extends StatefulWidget {
  const Splsh({Key? key}) : super(key: key);

  @override
  State<Splsh> createState() => _SplshState();
}

class _SplshState extends State<Splsh> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "HD WALLPAPER",
              style: TextStyle(
                fontSize: 25,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "for mobile",
              style: TextStyle(
                fontSize: 15,
                color: Colors.amber.shade400,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
