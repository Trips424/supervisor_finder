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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supervisedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.yellow,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Supervisedia'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedPageIndex = 0;
                });
              },
              child: const Text('Student Login'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedPageIndex = 1;
                });
              },
              child: const Text('Staff Login'),
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedPageIndex,
          children: [
            StudentBrowseScreen(staffMembers: sampleStaffMembers),
            const StaffDashboardScreen(),
          ],
        ),
      ),

    );
  }
}
