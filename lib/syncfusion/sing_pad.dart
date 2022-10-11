import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class SignaturePad extends StatefulWidget {
  const SignaturePad({Key? key}) : super(key: key);

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Container(
              child: SfSignaturePad(
                strokeColor: Colors.amber,
                key: _signaturePadKey,
                backgroundColor: Colors.grey[200],
              ),
              height: 200,
              width: 300,
            ),
            RaisedButton(
                child: const Text("Save As Image"),
                onPressed: () async {
                  _handleSaveButtonPressed();
                }),
          ],
        ),
      ),
    );
  }

  void _handleSaveButtonPressed() async {
    final data = await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    String sdata = base64.encode(bytes!.buffer.asUint8List());
    log("_signaturePadKey-----${sdata.codeUnits}");
    _handleClearButtonPressed();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleClearButtonPressed() {
    _signaturePadKey.currentState!.clear();
  }
}
