import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class pdfModule {
  late PdfDocument document;
  static final pdfModule _pdfModule = pdfModule.internal();
  factory pdfModule() {
    return _pdfModule;
  }
  pdfModule.internal();
  void initDocument() async {
    String fileName = "receipt_template.pdf";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    document = PdfDocument(inputBytes: file.readAsBytesSync());
  }
}
