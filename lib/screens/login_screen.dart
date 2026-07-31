import 'package:flutter/material.dart';

import '../models/staff_member.dart';

enum AuthRole { student, staff }

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.staffMembers,
    required this.onStudentLogin,
    required this.onStudentRegister,
    required this.onStaffLogin,
    required this.onStaffRegister,
  });

  final List<StaffMember> staffMembers;
  final void Function(String studentId) onStudentLogin;
  final void Function(String email) onStudentRegister;
  final void Function(String staffId) onStaffLogin;
  final void Function(StaffMember staff) onStaffRegister;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthRole _role = AuthRole.student;
  bool _isRegister = false;

  // common
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // staff register
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  void _doLogin() {
    final email = _emailController.text.trim();
    if (_role == AuthRole.student) {
      if (email.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Enter student email')));
        return;
      }
      widget.onStudentLogin(email);
    } else {
      // staff login by email match
      final staff = widget.staffMembers.firstWhere(
        (s) => s.email.toLowerCase() == email.toLowerCase(),
        orElse: () => StaffMember(
          id: '',
          name: '',
          email: '',
          department: '',
          biography: '',
          specialisations: [],
          acceptingStudents: false,
          projectIdeas: [],
        ),
      );
      if (staff.id.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No staff found with that email')),
        );
        return;
      }
      widget.onStaffLogin(staff.id);
    }
  }

  void _doRegister() {
    final email = _emailController.text.trim();
    if (_role == AuthRole.student) {
      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter email to register')),
        );
        return;
      }
      widget.onStudentRegister(email);
    } else {
      final name = _nameController.text.trim();
      final dept = _departmentController.text.trim();
      if (name.isEmpty || email.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Enter name and email')));
        return;
      }

      final newStaff = StaffMember(
        id: 'staff-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        department: dept,
        biography: '',
        specialisations: [],
        acceptingStudents: true,
        projectIdeas: [],
      );

      widget.onStaffRegister(newStaff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login / Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                ToggleButtons(
                  isSelected: [
                    _role == AuthRole.student,
                    _role == AuthRole.staff,
                  ],
                  onPressed: (i) => setState(
                    () => _role = i == 0 ? AuthRole.student : AuthRole.staff,
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Student'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Staff'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () => setState(() => _isRegister = false),
                        icon: const Icon(Icons.login),
                        label: const Text('Login'),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () => setState(() => _isRegister = true),
                        icon: const Icon(Icons.app_registration),
                        label: const Text('Register'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_isRegister && _role == AuthRole.staff) ...[
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _departmentController,
                    decoration: const InputDecoration(
                      labelText: 'Department',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password (not used)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _isRegister ? _doRegister : _doLogin,
                      child: Text(_isRegister ? 'Register' : 'Login'),
                    ),
                    const SizedBox(width: 12),
                    if (!_isRegister && _role == AuthRole.staff)
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Or pick staff by name',
                            border: OutlineInputBorder(),
                          ),
                          items: widget.staffMembers
                              .map(
                                (s) => DropdownMenuItem(
                                  value: s.id,
                                  child: Text(s.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) widget.onStaffLogin(value);
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'Note: This demo uses in-memory accounts (no passwords).',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
