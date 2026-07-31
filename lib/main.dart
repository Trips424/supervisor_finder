import 'package:flutter/material.dart';

import 'data/staff_member_data.dart';
import 'models/staff_member.dart';
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
  final List<StaffMember> _staffMembers = List<StaffMember>.from(
    sampleStaffMembers,
  );

  // simple in-memory student accounts (id,email)
  final List<Map<String, String>> _studentAccounts = [];

  String? _loggedInRole; // 'student' or 'staff'
  String? _loggedInUserId;

  int _selectedPageIndex = 0;
  String _chosenStaffId = sampleStaffMembers.first.id;

  StaffMember get _chosenStaff {
    return _staffMembers.firstWhere((staff) => staff.id == _chosenStaffId);
  }

  void _selectStaff(String staffId) {
    setState(() {
      _chosenStaffId = staffId;
    });
  }

  void _updateStaffMember(StaffMember updatedStaff) {
    setState(() {
      final index = _staffMembers.indexWhere(
        (staff) => staff.id == updatedStaff.id,
      );

      if (index != -1) {
        _staffMembers[index] = updatedStaff;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supervisedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.yellow),
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
            StudentBrowseScreen(staffMembers: _staffMembers),
            StaffDashboardScreen(
              key: ValueKey(_chosenStaff.id),
              staffMembers: _staffMembers,
              selectedStaff: _chosenStaff,
              onStaffSelected: _selectStaff,
              onStaffUpdated: _updateStaffMember,
            ),
          ],
        ),
      ),
    );
  }
}
