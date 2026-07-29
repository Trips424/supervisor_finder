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
      theme: ThemeData(primarySwatch: const Color.fromARGB(255, 9, 5, 228)),
      home: const StudentBrowseScreen(staffMembers: sampleStaffMembers),
    );
  }
}
