import 'package:flutter/material.dart';

import 'data/staff_member_data.dart';
import 'screens/student_browse_screen.dart';

void main() {
  runApp(const SupervisorFinderApp());
}

class SupervisorFinderApp extends StatelessWidget {
  const SupervisorFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supervisor Finder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Supervisor Finder')),
        body: StudentBrowseScreen(staffMembers: sampleStaffMembers),
      ),
    );
  }
}
