import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static const String fileName = "mint_pairing.csv";
  static const String folderName = "Mint Pairing";

  Future<String> getFilePath() async {
    if (Platform.isAndroid) {
      final directory = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      if (!await Directory(directory).exists()) {
        await Directory(directory).create();
      }
      return directory;
    } else {
      Directory storageDirectory = await getApplicationDocumentsDirectory();
      bool isExist = await storageDirectory.exists();
      if (!isExist) {
        storageDirectory = await storageDirectory.create();
      }
      return storageDirectory.path;
    }
  }

  Future<String> getCSVFilePath() async {
    String download = await getFilePath();

    String main = '$download/$folderName';

    Directory d = Directory(main);
    if (!await d.exists()) {
      await d.create();
    }

    return '${d.path}/$fileName';
  }

  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
