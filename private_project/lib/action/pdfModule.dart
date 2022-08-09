import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart';

class pdfModule {
  late PdfDocument document;
  static final pdfModule _pdfModule = pdfModule.internal();
  static String pdfStoragePath = "";
  factory pdfModule() {
    return _pdfModule;
  }
  pdfModule.internal();
  void initDocument() async {
    await _extractTextFromPDF();
    //  sendEmail();
  }

  Future<List<int>> _readDocumentData(String name) async {
    final ByteData data = await rootBundle.load('assets/pdf/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _extractTextFromPDF() async {
    //Load the PDF document.
    final PdfDocument document = PdfDocument(
        inputBytes: await _readDocumentData('receipt_template.pdf'));
    PdfPage page = document.pages[0];

//Create text box field and add to the forms collection.

    document.form.fields.add(PdfTextBoxField(
        page, 'firstname', Rect.fromLTWH(0, 0, 100, 20),
        text: 'John', borderWidth: 0));
    Directory tempDir = await getTemporaryDirectory();
    pdfStoragePath = tempDir.path;
    File('$pdfStoragePath/copy.pdf').writeAsBytesSync(await document.save());
    File tempFile = File('$pdfStoragePath/copy.pdf');
    printDocument(tempFile);

    //Dispose the document.
    document.dispose();
  }

  Future<File> copyAsset() async {
    Directory tempDir = await getTemporaryDirectory();
    pdfStoragePath = tempDir.path;
    File tempFile = File('$pdfStoragePath/copy.pdf');
    ByteData bd = await rootBundle.load('assets/pdf/receipt_template.pdf');
    await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    // printDocument(tempFile);
    return tempFile;
  }

  void sendEmail() async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['aarontongwh@gmail.com'],
      attachmentPaths: ['$pdfStoragePath/copy.pdf'],
      isHTML: false,
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }
  }

  void printDocument(File file) async {
    //await FlutterPdfPrinter.printFile(file.path);
    await Printing.layoutPdf(onLayout: (_) async => file.readAsBytes());
  }
}
