import 'package:flutter/material.dart';

import 'data/staff_member_data.dart';
import 'models/staff_member.dart';
import 'screens/student_browse_screen.dart';
import 'screens/staff_dashboard_screen.dart';
import 'screens/login_screen.dart';

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

  void _logout() {
    setState(() {
      _loggedInRole = null;
      _loggedInUserId = null;
    });
  }

  void _studentRegister(String email) {
    final id = 'student-${DateTime.now().millisecondsSinceEpoch}';
    _studentAccounts.add({'id': id, 'email': email});
    _studentLoginById(id);
  }

  void _studentLogin(String email) {
    final existing = _studentAccounts.firstWhere(
      (s) => s['email']?.toLowerCase() == email.toLowerCase(),
      orElse: () => {},
    );
    if (existing.isNotEmpty) {
      _studentLoginById(existing['id']!);
      return;
    }

    // register implicitly
    _studentRegister(email);
  }

  void _studentLoginById(String id) {
    setState(() {
      _loggedInRole = 'student';
      _loggedInUserId = id;
      _selectedPageIndex = 0;
    });
  }

  void _staffLogin(String staffId) {
    setState(() {
      _loggedInRole = 'staff';
      _loggedInUserId = staffId;
      _chosenStaffId = staffId;
      _selectedPageIndex = 1;
    });
  }

  void _staffRegister(StaffMember staff) {
    setState(() {
      _staffMembers.add(staff);
    });
    _staffLogin(staff.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supervisedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.yellow),
      home: _loggedInRole == null
          ? LoginScreen(
              staffMembers: _staffMembers,
              onStudentLogin: _studentLogin,
              onStudentRegister: _studentRegister,
              onStaffLogin: _staffLogin,
              onStaffRegister: _staffRegister,
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text('Supervisedia'),
                actions: [
                  if (_loggedInRole != null)
                    TextButton(onPressed: _logout, child: const Text('Logout')),
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
                    isStaffUser: _loggedInRole == 'staff',
                    editableStaffId: _loggedInRole == 'staff'
                        ? _loggedInUserId
                        : null,
                  ),
                ],
              ),
            ),
    );
  }
}
