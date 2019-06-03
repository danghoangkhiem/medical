import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:medical/src/app.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(App());
}