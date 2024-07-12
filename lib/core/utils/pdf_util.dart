import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';

class PdfUtil {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final file = File('${SharedService.getAppDocPath()}/$name');

    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<void> printDocument({
    required File file,
  }) async {
    Uint8List bytes = await file.readAsBytes();

    Uint8List pdfBytes = Uint8List.fromList(bytes);

    await Printing.layoutPdf(onLayout: (_) => pdfBytes);
  }
}
