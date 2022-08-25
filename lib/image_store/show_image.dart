import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testadmob/image_store/shared_preference.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({Key? key}) : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  var img64;

  @override
  void initState() {
    super.initState();
    img64 = base64Decode(AppPreference.getString("image"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Container(
              height: 250,
              width: 400,
              child: Image.memory(
                img64,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
