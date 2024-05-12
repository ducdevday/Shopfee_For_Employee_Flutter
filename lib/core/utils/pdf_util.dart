import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
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

}