import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setSystemUIOverlay() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );
}
