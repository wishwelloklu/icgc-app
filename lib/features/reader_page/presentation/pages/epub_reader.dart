// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_epub/flutter_epub.dart';

// class EpubReader extends StatefulWidget {
//   const EpubReader({super.key});

//   @override
//   State<EpubReader> createState() => _EpubReaderState();
// }

// class _EpubReaderState extends State<EpubReader> {
//   @override
//   void initState() {
//     super.initState();
//     _epubController = EpubController(
//       // Load document
//       document: EpubDocument.openAsset('assets/book.epub'),
//       // Set start point
//       epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
//     );
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           // Show actual chapter name
//           title: EpubViewActualChapter(
//               controller: _epubController,
//               builder: (chapterValue) => Text(
//                     'Chapter: ' +
//                         (chapterValue?.chapter?.Title
//                                 ?.replaceAll('\n', '')
//                                 .trim() ??
//                             ''),
//                     textAlign: TextAlign.start,
//                   )),
//         ),
//         // Show table of contents
//         drawer: Drawer(
//           child: EpubViewTableOfContents(
//             controller: _epubController,
//           ),
//         ),
//         // Show epub document
//         body: EpubView(
//           controller: _epubController,
//         ),
//       );
// }
