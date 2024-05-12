import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

class GlobalData {
  static final ins = GlobalData._();

  GlobalData._();

  Font? font;

  Future<void> createFont() async {
    final data = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    font = Font.ttf(data);
  }
}
