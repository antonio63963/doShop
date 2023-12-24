import 'package:doshop_app/models/models/category.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';

class PhotoService {
  static Image imageFromBase64String(String base64String) {
    logger.d('Image from Base 64: $base64String');
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
