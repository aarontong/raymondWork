import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart';

class pdfModule {
  late PdfDocument document;
  static final pdfModule _pdfModule = pdfModule.internal();
  factory pdfModule() {
    return _pdfModule;
  }
  pdfModule.internal();
  void initDocument() async {
    copyAsset();
  }

  Future<List<int>> _readDocumentData(String name) async {
    final ByteData data = await rootBundle.load('assets/pdf/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _extractTextFromPDF() async {
    //Load the PDF document.
    final PdfDocument document = PdfDocument(
        inputBytes: await _readDocumentData('receipt_template.pdf'));
    //Create PDF text extractor to extract text.
    PdfTextExtractor extractor = PdfTextExtractor(document);
    //Extract text
    String text = extractor.extractText();
    //Dispose the document.
    document.dispose();
  }

  Future<File> copyAsset() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File('$tempPath/copy.pdf');
    ByteData bd = await rootBundle.load('assets/pdf/receipt_template.pdf');
    await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return tempFile;
  }
}
