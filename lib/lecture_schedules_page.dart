import 'package:flutter/material.dart';

class LectureSchedule {
  final String subject;
  final String lecturer;
  final String time;
  final String location;

  LectureSchedule({
    required this.subject,
    required this.lecturer,
    required this.time,
    required this.location,
  });
}

class LectureSchedulesPage extends StatefulWidget {
  @override
  _LectureSchedulesPageState createState() => _LectureSchedulesPageState();
}

class _LectureSchedulesPageState extends State<LectureSchedulesPage> {
  List<LectureSchedule> lectureSchedules = [
    LectureSchedule(
      subject: 'Mobile Application Development',
      lecturer: 'John Doe',
      time: '08:30 - 10:00',
      location: 'Room 101',
    ),
    LectureSchedule(
      subject: 'Database Systems',
      lecturer: 'Jane Smith',
      time: '10:30 - 12:00',
      location: 'Room 102',
    ),
    // Add more lectures here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lecture Schedules')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView.builder(
          itemCount: lectureSchedules.length,
          itemBuilder: (BuildContext context, int index) {
            final lecture = lectureSchedules[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lecture.subject,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Lecturer: ${lecture.lecturer}'),
                    SizedBox(height: 4),
                    Text('Time: ${lecture.time}'),
                    SizedBox(height: 4),
                    Text('Location: ${lecture.location}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
