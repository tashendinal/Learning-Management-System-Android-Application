import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModuleMarks {
  final String subject;
  final String lecturer;
  final double marks;

  ModuleMarks({
    required this.subject,
    required this.lecturer,
    required this.marks,
  });

  factory ModuleMarks.fromDocument(DocumentSnapshot doc) {
    return ModuleMarks(
      subject: doc['subject'],
      lecturer: doc['lecturer'],
      marks: double.parse(doc['marks']),
    );
  }
}

class MarksPage extends StatefulWidget {
  @override
  _MarksPageState createState() => _MarksPageState();
}

class _MarksPageState extends State<MarksPage> {
  final Stream<QuerySnapshot> _marksStream =
      FirebaseFirestore.instance.collection('marks').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Marks')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _marksStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<ModuleMarks> moduleMarks = snapshot.data!.docs
                .map((doc) => ModuleMarks.fromDocument(doc))
                .toList();

            return ListView.builder(
              itemCount: moduleMarks.length,
              itemBuilder: (BuildContext context, int index) {
                final marks = moduleMarks[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          marks.subject,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Lecturer: ${marks.lecturer}'),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              'Marks: ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              marks.marks.toStringAsFixed(1) + '%',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
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
