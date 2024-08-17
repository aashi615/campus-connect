import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MyPdfViewerPB extends StatefulWidget {
  const MyPdfViewerPB({super.key});

  @override
  State<MyPdfViewerPB> createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewerPB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:
        // link fron internet
        SfPdfViewer.network(
         "assets/pdfs/Placement-Brochure-10-12-2020.pdf" ,
        )
      // SfPdfViewer.asset("asset/proposal.pdf"),
    );
  }
}