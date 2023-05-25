import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

class LectureMaterial {
  final String title;
  final String subject;
  final String lecturer;
  final String url;

  LectureMaterial({
    required this.title,
    required this.subject,
    required this.lecturer,
    required this.url,
  });

  factory LectureMaterial.fromDocument(DocumentSnapshot doc) {
    return LectureMaterial(
      title: doc['title'],
      subject: doc['subject'],
      lecturer: doc['lecturer'],
      url: doc['url'],
    );
  }
}

class LectureMaterialsPage extends StatefulWidget {
  @override
  _LectureMaterialsPageState createState() => _LectureMaterialsPageState();
}

class _LectureMaterialsPageState extends State<LectureMaterialsPage> {
  final Stream<QuerySnapshot> _lectureMaterialsStream =
      FirebaseFirestore.instance.collection('lecture_materials').snapshots();

  Future<File> _downloadPdf(String url, String filename) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<void> _openPdf(BuildContext context, LectureMaterial material) async {
    final file = await _downloadPdf(material.url, '${material.title}.pdf');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(material.title)),
          body: PDFView(
            filePath: file.path,
            autoSpacing: true,
            enableSwipe: true,
            swipeHorizontal: true,
            onError: (error) {
              print(error);
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lecture Materials')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _lectureMaterialsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<LectureMaterial> lectureMaterials = snapshot.data!.docs
                .map((doc) => LectureMaterial.fromDocument(doc))
                .toList();

            return ListView.builder(
              itemCount: lectureMaterials.length,
              itemBuilder: (BuildContext context, int index) {
                final material = lectureMaterials[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () => _openPdf(context, material),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  material.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text('Subject: ${material.subject}'),
                                SizedBox(height: 4),
                                Text('Lecturer: ${material.lecturer}'),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Icon(
                            Icons.download, // The download icon
                            size:
                                30, // Change this value to make the icon larger or smaller
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
