import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

/// Creates the barcode generator
class BarcodeGenerate extends StatefulWidget {
  BarcodeGenerate({Key? key}) : super(key: key);

  @override
  State<BarcodeGenerate> createState() => _BarcodeGenerateState();
}

class _BarcodeGenerateState extends State<BarcodeGenerate> {
  TextEditingController BarcodeController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Barcode Generator Demo'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///Barcode Code
                TextFormField(
                  controller: BarcodeController,
                  onChanged: (value) {
                    value = BarcodeController.text;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: SfBarcodeGenerator(
                    value: BarcodeController.text,
                    symbology: QRCode(),
                    showValue: true,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: codeController,
                  onChanged: (value) {
                    value = codeController.text;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  width: 300,
                  child: SfBarcodeGenerator(
                    value: codeController.text,
                    symbology: Code128(),
                    showValue: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
