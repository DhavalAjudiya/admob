import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:testadmob/image_store/shared_preference.dart';
import 'package:testadmob/tirp/shared_preference.dart';

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
              child: const Text(
                'Capture Above Widget',
              ),
              onPressed: () async {
                final capturedImage = await screenshotController.capture();
                log("screnshote--->$capturedImage");
/*                ByteData byteData = await capturedImage.toByteData(format: ui.ImageByteFormat.png);
                Uint8List pngBytes = byteData.buffer.asUint8List();
                Uint8List screnshote = base64Enco(capturedImage);           */
                // _saveScreen();
                // final data = await ImageGallerySaver.saveImage(capturedImage!);
                // log("screnshote---path>$data");
                var decoded = const Utf8Decoder().convert(capturedImage!);

                log("screnshote---string->$decoded");

                // List<int> list = "$capturedImage".codeUnits;
                // Uint8List bytes = Uint8List.fromList(list);
                // String string = String.fromCharCodes(bytes);
                try {
                  // Saved with this method.
                  var imageId = await ImageDownloader.downloadImage(decoded.toString());
                  print("screnshote--->01--$imageId");
                  if (imageId == null) {
                    print("screnshote--->02--$imageId");
                    return;
                  }
                  print("screnshote--->03");

                  // Below is a method of obtaining saved image information.
                  var fileName = await ImageDownloader.findName(imageId);
                  var path = await ImageDownloader.findPath(imageId);
                  var size = await ImageDownloader.findByteSize(imageId);
                  var mimeType = await ImageDownloader.findMimeType(imageId);
                  print("fileName--->$fileName");
                  print("path--->$path");
                  print("size--->$size");
                  print("mimeType--->$mimeType");
                } on PlatformException catch (error) {
                  print(error);
                }
              },
            ),
            GestureDetector(
              child: Container(
                height: 100,
                color: Colors.red,
                child: const Text(
                  '++++++',
                ),
              ),
              onTap: () async {
                try {
                  // List<int> list = 'xxx'.codeUnits;
                  final capturedImage = await screenshotController.capture();
                  final List<int> codeUnits = "hello".codeUnits;
                  final Uint8List unit8List = Uint8List.fromList(codeUnits);

                  final aaaa = String.fromCharCodes(unit8List);
                  log("screnshote---aaa>${codeUnits}");
                  log("screnshote---aaa>${unit8List}");
                  log("screnshote---aaa>${aaaa}");

                  Uint8List bytes = Uint8List.fromList(capturedImage!);
                  String string = String.fromCharCodes(bytes);
                  log("screnshote--->$capturedImage");
                  log("screnshote--->$bytes");
                  log("screnshote--->$string");
                  log("screnshote--->${capturedImage.runtimeType}");
                  log("screnshote---string->");

                  var decoded = const Utf8Decoder().convert(capturedImage);

                  log("screnshote---string->$decoded");
                } catch (e) {
                  print("errorr--$e");
                }
                // var data = MemoryImage(capturedImage);
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
