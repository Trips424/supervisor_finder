import 'package:flutter/material.dart';

import 'data/staff_member_data.dart';
import 'screens/student_browse_screen.dart';
import 'screens/staff_dashboard_screen.dart';

void main() {
  runApp(const SupervisorFinderApp());
}

class SupervisorFinderApp extends StatefulWidget {
  const SupervisorFinderApp({super.key});

  @override
  State<SupervisorFinderApp> createState() => _SupervisorFinderAppState();
}

class _SupervisorFinderAppState extends State<SupervisorFinderApp> {
  int _selectedPageIndex = 0;

  @override

}
