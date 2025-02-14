import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';

class EpubReader extends StatefulWidget {
  const EpubReader({super.key});

  @override
  State<EpubReader> createState() => _EpubReaderState();
}

class _EpubReaderState extends State<EpubReader> {
  late EpubController _epubController;

  @override
  void initState() {
    _epubController = EpubController(
        document:
            EpubDocument.openAsset('assets/json/Ministers_Manual_Vol_2.epub'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: EpubViewTableOfContents(controller: _epubController),
      ),
      body: EpubView(
        controller: _epubController,
        onDocumentError: (error) {
          print('error ${error.toString()}');
        },
        onDocumentLoaded: (document) {
          print('document ${document.Title}');
        },
      ),
    );
  }
}
