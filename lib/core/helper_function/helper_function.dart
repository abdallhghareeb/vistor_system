import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future delay(int milliseconds)async{
  await Future.delayed(Duration(milliseconds: milliseconds));
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}


String? getKeyByValue(Map map, dynamic value) {
  for (var entry in map.entries) {
    if (entry.value == value) {
      return entry.key;
    }
  }
  return null;
}


Future<String> getDownloadPath(String name) async {
  Directory? appDocDir = await getApplicationDocumentsDirectory();
  // String appDocPath = appDocDir.path;

  if (Platform.isAndroid) {
    appDocDir = await getExternalStorageDirectory(); // External storage directory (Android)
  } else if (Platform.isIOS) {
    appDocDir = await getApplicationDocumentsDirectory(); // iOS documents directory
  }
  String appDocPath = appDocDir!.path;
  return '$appDocPath/$name'; // Change file name as necessary
}

