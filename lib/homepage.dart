import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:lms/account_page.dart';

import 'lecture_materials_page.dart';
import 'lecture_schedules_page.dart';
import 'marks_page.dart';

class Homepage extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<Homepage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = [
    LectureSchedulesPage(),
    MarksPage(),
    LectureMaterialsPage(),
    AccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: _pages[_selectedIndex],
  bottomNavigationBar: ConvexAppBar(
    backgroundColor: Theme.of(context).primaryColor,
    style: TabStyle.react,
    items: [
      TabItem(icon: Icons.schedule, title: 'Schedules'),
      TabItem(icon: Icons.assessment, title: 'Marks'),
      TabItem(icon: Icons.book, title: 'Materials'),
      TabItem(icon: Icons.person, title: 'Account'),
    ],
    initialActiveIndex: _selectedIndex,
    onTap: _onItemTapped,
  ),
);


  }
}
