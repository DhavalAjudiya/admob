import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
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

  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        body: Column(
          children: [
            const SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Screenshot(
                controller: screenshotController,
                child: Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 400,
                      child: Image.memory(
                        img64,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                      child: Text(
                        "Hello",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: Text(
                'Capture Above Widget',
              ),
              onPressed: () async {
                final capturedImage = await screenshotController.capture();
/*                ByteData byteData = await capturedImage.toByteData(format: ui.ImageByteFormat.png);
                Uint8List pngBytes = byteData.buffer.asUint8List();
                Uint8List screnshote = base64Enco(capturedImage);           */
                // _saveScreen();
                await ImageGallerySaver.saveImage(capturedImage!);
                log("screnshote--->00");
                // try {
                //   // Saved with this method.
                //   var imageId = await ImageDownloader.downloadImage(capturedImage.toString());
                //   print("screnshote--->01");
                //   if (imageId == null) {
                //     print("screnshote--->02");
                //     return;
                //   }
                //   print("screnshote--->03");
                //
                //   // Below is a method of obtaining saved image information.
                //   var fileName = await ImageDownloader.findName(imageId);
                //   var path = await ImageDownloader.findPath(imageId);
                //   var size = await ImageDownloader.findByteSize(imageId);
                //   var mimeType = await ImageDownloader.findMimeType(imageId);
                //   print("fileName--->$fileName");
                //   print("path--->$path");
                //   print("size--->$size");
                //   print("mimeType--->$mimeType");
                // } on PlatformException catch (error) {
                //   print(error);
                // }
              },
            ),
            GestureDetector(
              child: Container(
                height: 100,
                color: Colors.red,
                child: Text(
                  '++++++',
                ),
              ),
              onTap: () async {
                log("screnshote--->0");
                final capturedImage = await screenshotController.capture();
                // log("screnshote--->${capturedImage.runtimeType}");
                var data = MemoryImage(capturedImage!);
              },
            ),
          ],
        ),
      ),
    );
  }

  _saveScreen() async {
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png) as FutureOr<ByteData?>);
    print("byteData--->$byteData");

    if (byteData != null) {
      final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      print(result);
    }
  }

  Future<ui.Image> loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Future<dynamic> ShowCapturedWidget(BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(child: capturedImage != null ? Image.memory(capturedImage) : Container()),
      ),
    );
  }

  _saved(File image) async {
    // final result = await ImageGallerySaver.save(image.readAsBytesSync());
    print("File Saved to Gallery");
  }
// takeScreenShot() async{
//   RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
//   ui.Image image = await boundary.toImage();
//   final directory = (await getApplicationDocumentsDirectory()).path;
//   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   Uint8List pngBytes = byteData.buffer.asUint8List();
//   print(pngBytes);
//   File imgFile =new File('$directory/screenshot.png');
//   imgFile.writeAsBytes(pngBytes);
// }
}
