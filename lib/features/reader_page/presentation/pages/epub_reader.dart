
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
    super.initState();
    loadEpub();
  }

  void loadEpub() async {
    try {
      _epubController = EpubController(
          // Load document
          document:
              EpubDocument.openAsset('assets/pdf/Ministers-Manual-Vol-1.epub'),
          // Set start point
          epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)');
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            // Show actual chapter name
            // title: EpubViewActualChapter(
            //     controller: _epubController,
            //     builder: (chapterValue) => Text(
            //           'Chapter: ${chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? ''}',
            //           textAlign: TextAlign.start,
            //         )),
            ),
        // Show table of contents
        drawer: Drawer(
          child: EpubViewTableOfContents(
            controller: _epubController,
          ),
        ),
        // Show epub document
        body: EpubView(
          controller: _epubController,
          onDocumentError: (error) {
            print(error.toString());
          },
        ),
      );
}
